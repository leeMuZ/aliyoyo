<?php
namespace Livehelp;

abstract class Core {
   protected $setting = array();
   public $role = array('user' => 1, 'operator' => 2, 'bot' => 3);
   
   protected $emoticons = array();
   
   protected function __construct($registry) {
      $this->config   = $registry->get('config');
      $this->db       = $registry->get('db');
      $this->request  = $registry->get('request');
      $this->cache    = $registry->get('cache');
      $this->session  = $registry->get('session');
      $this->url      = $registry->get('url');
      $this->language = $registry->get('language');
      
      $this->initSettings();
      $this->initEmoticons();
   }
   
   private function initSettings() {
      $query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "livehelp_setting`");
      
      foreach ($query->rows as $row) {
         $this->setting[$row['key']] = $row['serialized'] ? unserialize($row['value']) : $row['value'];
      }
   }
   
   public function getSetting($key) {
      return (isset($this->setting[$key]) ? $this->setting[$key] : null);
   }
   
   public function getEmoticons() {
      return $this->emoticons;
   }
   
   // Load emoticons from config file
   private function initEmoticons() {
      if (!$this->getSetting('smiley_status'))
         return;
      
      $_emoticons = array();
      require(DIR_SYSTEM . "library/livehelp/emoticons.php");
      
      $this->emoticons = array_merge($this->emoticons, $_emoticons);
   }
   
   protected function getMessages($thread_id, $last_id = null) {
      $sql = "SELECT * FROM `" . DB_PREFIX . "livehelp_message`" . " WHERE thread_id = '" . (int) $thread_id . "'";
      if ($last_id) {
         $sql .= " AND message_id > '" . (int) $last_id . "'";
      }
      
      $sql .= " ORDER BY message_id ASC";
      
      $query = $this->db->query($sql);
      
      return $query->rows;
   }
   
   protected function getThread($thread_id) {
      $query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "livehelp_thread` WHERE thread_id = '" . (int) $thread_id . "'");
      
      return $query->row;
   }
   
   protected function updateThread($thread_id, $data = array()) {
      $sql = "UPDATE `" . DB_PREFIX . "livehelp_thread`" . " SET date_modified = '" . time() . "'";
      
      if (!empty($data['user_readed'])) {
         $sql .= ", user_readed = '" . (int) $data['user_readed'] . "'";
      }
      
      if (!empty($data['operator_readed'])) {
         $sql .= ", operator_readed = '" . (int) $data['operator_readed'] . "'";
      }
      
      if (!empty($data['new_operator'])) {
         $sql .= ", operator_id = '" . (int) $data['new_operator'] . "'";
      }
      
      if (!empty($data['cart'])) {
         $sql .= ", user_cart = '" . $this->db->escape($data['cart']) . "'";
      }
      
      if (!empty($data['ping_user'])) {
         $sql .= ", user_ping = '" . time() . "'";
      }
      
      $sql .= " WHERE thread_id = '" . (int) $thread_id . "'";
      
      $this->db->query($sql);
   }
   
   protected function closeThread($thread_id, $kicked = 0) {
      $this->db->query("UPDATE `" . DB_PREFIX . "livehelp_thread` SET date_closed = '" . time() . "', kicked = '" . (int) $kicked . "' WHERE thread_id = '" . (int) $thread_id . "'");
   }
   
   public function getOperators($data = array()) {
      $sql = "";
      $sql .= "SELECT operator_id, name, image, description, status_id FROM `" . DB_PREFIX . "livehelp_operator` WHERE status = 1";
      
      if (isset($data['operator_id'])) {
         $sql .= " AND operator_id = '" . (int) $data['operator_id'] . "'";
      }
      
      if (isset($data['except_self'])) {
         $sql .= " AND operator_id <> '" . (int) $this->getId() . "'";
      }
      
      if (isset($data['online'])) {
         $this->verifyOperatorActivity();
         $sql .= " AND is_logged = '" . (int) $data['online'] . "'";
      }
      
      $sql .= " ORDER BY name ASC";
      
      $query = $this->db->query($sql);
      
      return $query->rows;
   }
   
   /**
    * Check operator's last_activity and verify his online status
    */
   protected function verifyOperatorActivity($operator_id = null) {
      $time_range = (int) $this->getSetting('admin_inactive_timeout');
      $action     = (int) $this->getSetting('admin_inactive_action');
      
      if ($action === -1) {
         $this->db->query("UPDATE `" . DB_PREFIX . "livehelp_operator` SET is_logged = 0 WHERE last_activity < " . (time() - $time_range) . "");
      } else {
         $this->db->query("UPDATE `" . DB_PREFIX . "livehelp_operator` SET status_id = '" . (int) $action . "' WHERE last_activity < '" . (time() - $time_range) . "'");
         $this->broadcastNewStatus($action);
      }
   }
   
   protected function getStatusDetail($status_id) {
      $query = $this->db->query("SELECT ls.color, lst.name, lst.text FROM `" . DB_PREFIX . "livehelp_status` ls LEFT JOIN `" . DB_PREFIX . "livehelp_status_text` lst ON (ls.status_id = lst.status_id) WHERE ls.status_id = '" . (int) $status_id . "' AND lst.language_id = '" . (int) $this->config->get('config_language_id') . "'");
      
      return ($query->num_rows ? $query->row : false);
   }
   
   protected function getToken() {
      return mt_rand(999999, 999999999);
   }
}

class LivehelpMSG {
   private $core;
   
   public $thread_id;
   public $text;
   public $initiator;
   public $action;
   public $data = array();
   public $date_added;
   
   // BBcode array
   protected $bb_find = array('~\[b\](.*?)\[\/b\]~s', '~\[i\](.*?)\[\/i\]~s', '~\[u\](.*?)\[\/u\]~s', 
   //'~\[quote\](.*?)\[/quote\]~s',
      
   //'~\[size=(.*?)\](.*?)\[/size\]~s',
      
   //'~\[color=(.*?)\](.*?)\[/color\]~s',
      '~\[url\]((((?:ftp|https?):\/\/)|(?:www\.)).*?)\[\/url\]~s', '~\[img\](https?://.*?\.(?:jpg|jpeg|gif|png|bmp))\[/img\]~s', '~\[youtube\](https?:\/\/www.youtube.com\/embed\/.*?)\[/youtube\]~s');
   
   // HTML tags to replace BBcode
   protected $bb_replace = array('<b>$1</b>', '<i>$1</i>', '<u>$1</u>', 
   //'<pre>$1</pre>',
      
   //'<span style="font-size:$1px;">$2</span>',
      
   //'<span style="color:$1;">$2</span>',
      '<a href="$1" target="_blank">$1</a>', '<img src="$1" alt="" class="lh-msg-image" />', '<div class="embed-responsive embed-responsive-4by3"><iframe src="$1" allowfullscreen=""></iframe></div>');
   
   public function __construct($core) {
      $this->core = $core;
   }
   
   public function send() {
      // Verify
      if ((!utf8_strlen($this->text) || !$this->initiator) && !$this->action)
         return false;
      if (!$this->date_added)
         $this->date_added = time();
      
      if ($this->initiator !== $this->core->role['bot'])
         $this->clearString();
      if ($this->core->getSetting("smiley_status"))
         $this->parseEmoticons();
      if ($this->core->getSetting("bbcode_status"))
         $this->parseBBCode();
      
      $sql = "INSERT INTO `" . DB_PREFIX . "livehelp_message`" . " SET thread_id = '" . (int) $this->thread_id . "'," . " initiator = '" . (int) ($this->action ? $this->core->role['bot'] : $this->initiator) . "'," . " message = " . ($this->text ? "'" . $this->core->db->escape($this->text) . "'" : "NULL") . "," . " action = " . ($this->action ? "'" . $this->core->db->escape($this->action) . "'" : "NULL") . "," . " data = " . ($this->data ? "'" . $this->core->db->escape(serialize($this->data)) . "'" : "NULL") . "," . " date_added = '" . (int) $this->date_added . "'";
      
      $this->core->db->query($sql);
      
      return array(
         'message_id' => $this->core->db->getLastId(),
         'text' => $this->text,
         'initiator' => $this->initiator,
         'date_added' => date("H:i:s", $this->date_added)
      );
   }
   
   private function clearString() {
      $this->text = strip_tags(html_entity_decode($this->text));
   }
   
   private function parseBBCode() {
      $this->text = preg_replace($this->bb_find, $this->bb_replace, $this->text);
   }
   
   private function parseEmoticons() {
      foreach ($this->core->getEmoticons() as $key => $emoteicons) {
         for ($i = 0; $i < count($emoteicons); $i++) {
            $this->text = str_ireplace($emoteicons[$i], '<img src="' . $this->core->getSetting('absolute_path') . 'image/emoticons/' . $key . '.png" alt="' . $key . '">', $this->text);
         }
      }
   }
}