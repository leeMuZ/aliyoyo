<?php

namespace Livehelp;

require_once(DIR_SYSTEM . "library/livehelp/livehelp.php");

class Livehelp_User extends Core {
   private $oi = 10;
   
   protected $thread_id;
   
   protected $user_id; // Just for identification same users in chat histories
   protected $user_name;
   
   protected $ip;
   protected $operator_id;
   protected $last_readed;
   
   protected $is_writable = 1;
   
   protected $is_banned = 0;
   protected $is_kicked = 0;
   
   public function __construct($registry) {
      parent::__construct($registry);
      $this->customer = $registry->get('customer');
      $this->cart     = $registry->get('cart');
      
      // Better to move it into login
      $this->is_banned = $this->checkBannedStatus();
      if ($this->is_banned) {
         $this->is_writable = 0;
         
         $this->signOut();
         return;
      }
      
      if (!isset($this->session->data['lh_iteration_counter']))
         $this->session->data['lh_iteration_counter'] = 1;
      
      // Check if has already thread
      if (isset($this->session->data['lh_thread_id']) && isset($this->session->data['lh_utoken'])) {
         $thread_query = $this->db->query("SELECT thread_id, user_id, user_name, operator_id, user_readed, date_closed, kicked FROM `" . DB_PREFIX . "livehelp_thread` WHERE thread_id = '" . (int) $this->session->data['lh_thread_id'] . "' AND utoken = '" . (int) $this->session->data['lh_utoken'] . "'"); //AND date_closed = 0
         
         if ($thread_query->num_rows) {
            $this->thread_id   = $thread_query->row['thread_id'];
            $this->user_id     = $thread_query->row['user_id'];
            $this->user_name   = $thread_query->row['user_name'];
            $this->operator_id = $thread_query->row['operator_id'];
            $this->last_readed = $thread_query->row['user_readed'];
            
            if ($thread_query->row['kicked']) {
               $this->is_kicked   = 1;
               $this->is_writable = 0;
            }
            
            if ($this->getSetting('cart_update_interval') && !($this->session->data['lh_iteration_counter'] % $this->getSetting('cart_update_interval'))) {
               $this->updateThread($this->thread_id, array(
                  'ping_user' => true,
                  'cart' => $this->checkCustomerCart()
               ));
            } else {
               $this->updateThread($this->thread_id, array(
                  'ping_user' => true
               ));
            }
            
         } else {
            $this->signOut();
         }
      }
      // When defined user_id from cookies - restoring login data
      else if (isset($this->request->cookie['lh_user_id'])) {
         $user_query = $this->db->query("SELECT thread_id, user_id, user_name, operator_id FROM `" . DB_PREFIX . "livehelp_thread` WHERE user_id = '" . $this->db->escape($this->request->cookie['lh_user_id']) . "' ORDER BY date_added DESC LIMIT 1");
         
         if ($user_query->num_rows) {
            $this->user_id     = $user_query->row['user_id'];
            $this->user_name   = $user_query->row['user_name'];
            $this->operator_id = $user_query->row['operator_id'];
         } else {
            setcookie('lh_user_id', "", time() + 1, '/', $this->request->server['HTTP_HOST']);
         }
      } else if ($this->customer->isLogged()) {
         $this->user_name = $this->customer->getFirstName() . ' ' . $this->customer->getLastName();
      } else {
         $username        = $this->getSetting('store_default_username');
         $this->user_name = (isset($username[$this->config->get('config_language_id')]) ? $username[$this->config->get('config_language_id')] : '');
      }
   }
   
   public function signIn($name, $operator_id) {
      $current_time = time();
      $ip_address   = $this->request->server['REMOTE_ADDR'];
      
      $user_agent = $this->request->server['HTTP_USER_AGENT'];
      $referer    = $this->request->server['HTTP_REFERER'];
      
      $user_id = md5($ip_address . $current_time);
      $token   = $this->getToken();
      
      $sql = "INSERT INTO `" . DB_PREFIX . "livehelp_thread`" . " SET" . "     user_id = '" . $this->db->escape($user_id) . "'," . "    user_name = '" . $this->db->escape($name) . "'," . "    utoken = '" . (int) $token . "'," . "    customer_id = '" . (int) $this->customer->getId() . "'," . "    operator_id = '" . (int) $operator_id . "'," . "    date_added = '" . (int) $current_time . "'," . "    user_ip = '" . $this->db->escape($ip_address) . "'," . "    user_agent = '" . $this->db->escape($user_agent) . "'," . "    user_cart = '" . $this->db->escape($this->checkCustomerCart()) . "'," . "    referer = '" . $this->db->escape($referer) . "'," . "    language_id = '" . $this->config->get('config_language_id') . "'," . "    user_ping = '" . time() . "'";
      
      $this->db->query($sql);
      
      $thread_id = $this->db->getLastId();
      
      $this->thread_id   = $thread_id;
      $this->user_id     = $user_id;
      $this->user_name   = $name;
      $this->operator_id = $operator_id;
      $this->last_readed = 0;
      
      $this->session->data['lh_thread_id'] = $thread_id;
      $this->session->data['lh_utoken']    = $token;
      
      setcookie('lh_user_id', $user_id, strtotime("+1 year"), '/', $this->request->server['HTTP_HOST']);
      
      $this->checkOperatorStatus();
      
      return true;
   }
   
   public function signOut() {
      if ($this->thread_id) {
         $this->closeThread($this->thread_id);
      }
      
      $this->thread_id = '';
      $this->user_id   = '';
      
      unset($this->session->data['lh_thread_id']);
      unset($this->session->data['lh_utoken']);
      unset($this->session->data['lh_iteration_counter']);
   }
   
   public function isLogged() {
      return $this->thread_id;
   }
   
   public function isBanned() {
      return $this->is_banned;
   }
   
   public function isKicked() {
      return $this->is_kicked;
   }
   
   public function getThreadId() {
      return $this->thread_id;
   }
   
   public function getUserName() {
      return $this->user_name;
   }
   
   public function getOperatorId() {
      return $this->operator_id;
   }
   
   public function getLastReaded() {
      return $this->last_readed;
   }
   
   public function sendMsg($data) {
      if (is_null($this->thread_id) || !$this->is_writable)
         return;
      
      if ($this->getSetting('spam_filter_status')) {
         if ($this->checkSpam())
            return array(
               'error' => sprintf($this->language->get('text_muted_for_time'), $this->getSetting('spam_filter_penalty'))
            );
         
         if (!empty($data['spamBlock']))
            $this->setSpam();
      }
      
      $msg = new LivehelpMSG($this);
      
      $msg->thread_id = $this->thread_id;
      $msg->text      = $data['text'];
      $msg->initiator = $this->role['user'];
      
      return $msg->send();
   }
   
   protected function checkSpam() {
      if (isset($this->session->data['lh-spam-filter'])) {
         $ss_date = $this->session->data['lh-spam-filter'];
      } else {
         $ss_date = 0;
      }
      
      $ss_date += (int) $this->getSetting('spam_filter_penalty');
      return (time() < $ss_date ? true : false);
   }
   
   protected function setSpam() {
      $this->session->data['lh-spam-filter'] = time();
   }
   
   public function autoUpdate($data) {
      if (isset($data['lastReaded'])) {
         $this->last_readed = $data['lastReaded'];
         $this->updateThread($this->thread_id, array(
            'user_readed' => $data['lastReaded']
         ));
      }
      
      $last_id = isset($data['lastId']) ? $data['lastId'] : 0;
      
      // Get operator info - only every xth iteration
      $operator_data = array();
      
      if (!$this->session->data['lh_iteration_counter'] % $this->oi) {
         $this->verifyOperatorActivity();
         $query         = $this->db->query("SELECT name, status_id, last_activity, is_logged FROM `" . DB_PREFIX . "livehelp_operator` WHERE operator_id = '" . (int) $this->operator_id . "' AND status = 1");
         $operator_data = $query->rows;
      }
      
      $this->session->data['lh_iteration_counter']++;
      
      $result = array(
         'kicked' => $this->is_kicked,
         'messages' => array(),
         'lastId' => $last_id
      );
      
      if ($operator_data)
         $result['operator'] = $operator_data;
      
      $messages = $this->getMessages($this->thread_id, $last_id);
      foreach ($messages as $message) {
         $result['messages'][] = array(
            'message_id' => $message['message_id'],
            'initiator' => $message['initiator'],
            'text' => $message['message'],
            'date_added' => date("H:i:s", $message['date_added'])
         );
         
         if ($message == end($messages))
            $result['lastId'] = $message['message_id'];
      }
      
      return $result;
   }
   
   protected function checkCustomerCart() {
      $cart_data = $this->cart->getProducts();
      
      $products = array();
      $items    = 0;
      
      if ($cart_data) {
         foreach ($cart_data as $key => $val) {
            $products[$val['product_id']] = array(
               'name' => $val['name'],
               'stock' => ($val['stock'] ? 1 : 0),
               'qty' => $val['quantity']
            );
            
            $items += $val['quantity'];
         }
      }
      
      $cart_result = array(
         'products' => $products,
         'total' => $this->cart->getTotal(),
         'items' => $items
      );
      
      return serialize($cart_result);
   }
   
   protected function checkBannedStatus() {
      $query = $this->db->query("SELECT ban_id FROM `" . DB_PREFIX . "livehelp_ban` WHERE ip = '" . $this->db->escape($this->request->server['REMOTE_ADDR']) . "'    AND (date_expired = '-1' || date_expired > '" . time() . "') LIMIT 1");
      
      return $query->num_rows ? true : false;
   }
   
   protected function checkOperatorStatus() {
      $query     = $this->db->query("SELECT status_id FROM `" . DB_PREFIX . "livehelp_operator` WHERE operator_id = '" . (int) $this->operator_id . "'");
      $status_id = $query->row['status_id'];
      
      if ($status_id) {
         $status_info = $this->getStatusDetail($status_id);
         
         $msg = new LivehelpMSG($this);
         
         $msg->thread_id = $this->thread_id;
         
         $msg->text = '<div class="lh-status-label label label-default">' . $status_info['name'] . '</div><p class="lh-status-text"' . ($status_info['color'] ? ' style="color: #' . $status_info['color'] . '"' : '') . '>' . $status_info['text'] . '</p>';
         
         $msg->initiator = $this->role['bot'];
         
         $msg->send();
      }
   }

   public function getOperatorInfo()
   {
      $query = $this->db->query("SELECT name, description, image FROM  " . DB_PREFIX . "livehelp_operator WHERE operator_id = " . $this->operator_id);

      return $query->row;
   }
}