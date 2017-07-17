<?php

namespace Livehelp;

require_once(DIR_SYSTEM . "library/livehelp/livehelp.php");

class Livehelp_Operator extends Core {
   protected $operator_id;
   protected $user_id;
   protected $name;
   protected $last_activity;
   protected $status_id;
   
   public function __construct($registry) {
      parent::__construct($registry);
      $this->user = $registry->get('user');
      
      if (isset($this->session->data['livehelp']['operator_id'])) {
         $operator_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "livehelp_operator WHERE operator_id = '" . (int) $this->session->data['livehelp']['operator_id'] . "' AND user_id = '" . $this->user->getId() . "' AND status = '1'");
         
         if ($operator_query->num_rows) {
            $this->operator_id   = $this->session->data['livehelp']['operator_id'];
            $this->user_id       = $operator_query->row['user_id'];
            $this->name          = $operator_query->row['name'];
            $this->last_activity = $operator_query->row['last_activity'];
            $this->status_id     = $operator_query->row['status_id'];
            
            $this->refreshLogged(1);
         } else {
            $this->logout();
         }
      }
   }
   
   public function login() {
      $operator_query = $this->db->query("SELECT lo.*, u.username FROM " . DB_PREFIX . "livehelp_operator AS lo LEFT JOIN `" . DB_PREFIX . "user` AS u ON (u.user_id = lo.user_id) WHERE lo.user_id = '" . $this->user->getId() . "' AND lo.status = '1'");
      
      if ($operator_query->num_rows) {
         $this->session->data['livehelp']                = array();
         $this->session->data['livehelp']['operator_id'] = $operator_query->row['operator_id'];
         
         $this->operator_id   = $operator_query->row['operator_id'];
         $this->user_id       = $operator_query->row['user_id'];
         $this->name          = ($operator_query->row['name'] ? $operator_query->row['name'] : $operator_query->row['username']);
         $this->last_activity = $operator_query->row['last_activity'];
         $this->status_id     = $operator_query->row['status_id'];
         
         $this->refreshLogged(1);
      } else {
         return false;
      }
   }
   
   public function logout() {
      unset($this->session->data['livehelp']);
      
      $this->refreshLogged(0);
      
      $this->operator_id   = null;
      $this->user_id       = null;
      $this->name          = null;
      $this->last_activity = null;
      $this->status_id     = null;
   }
   
   // Common getters
   public function isLogged() {
      return $this->operator_id;
   }
   
   public function getId() {
      return $this->operator_id;
   }
   
   public function getName() {
      return $this->name;
   }
   
   public function getStatus() {
      return $this->status_id;
   }
   
   // Setters
   public function setStatus($status_id) {
      if (!$status_id) {
         $this->db->query("UPDATE `" . DB_PREFIX . "livehelp_operator` SET status_id = NULL, last_activity = '" . time() . "', is_logged = 1 WHERE operator_id = '" . $this->operator_id . "'");
         $this->status_id = null;
      } else {
         $this->db->query("UPDATE `" . DB_PREFIX . "livehelp_operator` SET status_id = '" . (int) $status_id . "', last_activity = '" . time() . "', is_logged = 1 WHERE operator_id = '" . $this->operator_id . "'");
         $this->status_id = (int) $status_id;
         $this->broadcastNewStatus($status_id);
      }
   }
   
   public function sendMessage($data) {
      $msg = new LivehelpMSG($this);
      
      $msg->thread_id = $data['thread_id'];
      $msg->text      = $data['text'];
      $msg->initiator = $this->role['operator'];
      
      return $msg->send();
   }
   
   public function autoUpdate($data) {
      $result = array();
      
      if (isset($data['operation'])) {
         switch ($data['operation']) {
            case 'new_msg':
               $msg = new LivehelpMSG($this);
               
               $msg->thread_id = $data['msg_thread_id'];
               $msg->text      = $data['msg_text'];
               $msg->initiator = $this->role['operator'];
               
               $msg->send();
               break;
            case 'update_readed':
               if ((int) $data['update_readed_id'] === 0) {
                  $query                    = $this->db->query("SELECT MAX(message_id) AS last_id FROM `" . DB_PREFIX . "livehelp_message` WHERE thread_id = '" . (int) $data['update_readed_thread'] . "'");
                  $data['update_readed_id'] = $query->row['last_id'];
               }
               $this->updateThread($data['update_readed_thread'], array(
                  'operator_readed' => $data['update_readed_id']
               ));
               break;
            case 'toggle_operator':
               $this->updateThread($data['toggle_operator']['thread_id'], array(
                  'new_operator' => $data['toggle_operator']['operator_id']
               ));
               $new_operator_data = $this->getOperators(array(
                  'operator_id' => $data['toggle_operator']['operator_id']
               ));
               $msg               = new LivehelpMSG($this);
               
               $msg->thread_id = $data['toggle_operator']['thread_id'];
               $msg->text      = sprintf($this->language->get('text_action_operator_toggled'), $this->name, ($new_operator_data[0]['name'] ? $new_operator_data[0]['name'] : $new_operator_data[0]['username']));
               $msg->initiator = $this->role['bot'];
               
               $msg->send();
               break;
            case 'action_ban':
               $user_data = $this->db->query("SELECT user_name, user_ip FROM `" . DB_PREFIX . "livehelp_thread` WHERE thread_id = '" . (int) $data['baned_thread_id'] . "'");
               $this->db->query("INSERT INTO `" . DB_PREFIX . "livehelp_ban` SET user_name = '" . $this->db->escape($user_data->row['user_name']) . "', comment = '" . $this->db->escape($data['baned_comment']) . "', date_added = '" . time() . "', ip = '" . $this->db->escape($user_data->row['user_ip']) . "'");
               $this->closeThread($data['baned_thread_id'], 1);
               $result['success'] = $this->language->get('success_user_banned');
               break;
            case 'action_kick':
               $this->closeThread($data['kicked_thread_id'], 1);
               $result['success'] = $this->language->get('success_user_kicked');
               break;
            case 'action_remove': {
               $this->removeThread($data['remove_thread_id']);
            }
         }
      }
      
      // Do common stuff
      $threads  = $this->getCurrentThreads(true);
      $messages = array();
      
      if (!empty($data['threads'])) {
         foreach ($data['threads'] as $thread) {
            //if(!isset($threads[$thread['thread_id']])) continue;
            $msg_data = $this->getMessages($thread['thread_id'], $thread['last_id']);
            
            foreach ($msg_data as $msg) {
               $messages[$thread['thread_id']][] = array(
                  'message_id' => $msg['message_id'],
                  'initiator' => $msg['initiator'],
                  'message' => $msg['message'],
                  'date_added' => date("H:i:s", $msg['date_added'])
               );
            }
         }
      }
      
      $result['threads']  = $threads;
      $result['messages'] = $messages;
      
      return $result;
   }
   
   public function getCurrentThreads($extended = false) {
      $threads = array();
      
      $sql = "SELECT lt.*";
      if ($extended) {
         $sql .= ", (SELECT COUNT(lm.message_id) FROM `" . DB_PREFIX . "livehelp_message` AS lm WHERE lm.thread_id = lt.thread_id AND lm.message_id > lt.operator_readed AND lm.initiator = 1) AS total_new";
      }
      $sql .= " FROM `" . DB_PREFIX . "livehelp_thread` AS lt WHERE lt.operator_id = '" . (int) $this->operator_id . "'"; //AND lt.date_closed = 0
      
      $query = $this->db->query($sql);
      
      foreach ($query->rows as $thread) {
         $threads[$thread['thread_id']] = array(
            'thread_id' => $thread['thread_id'],
            'user_name' => $thread['user_name'],
            'customer_id' => $thread['customer_id'],
            'customer_link' => $thread['customer_id'] ? $this->url->link('sale/customer/info', 'token=' . $this->session->data['token'] . '&customer_id=' . $thread['customer_id']) : null,
            'user_readed' => $thread['user_readed'],
            'operator_readed' => $thread['operator_readed'],
            'date_added' => date("H:i:s", $thread['date_added']),
            'date_modified' => date("H:i:s", $thread['date_modified']),
            'date_closed' => $thread['date_closed'],
            'user_ip' => $thread['user_ip'],
            'user_agent' => $thread['user_agent'],
            'user_cart' => $thread['user_cart'] ? unserialize($thread['user_cart']) : null,
            'referer' => $thread['referer'],
            'language_id' => $thread['language_id'],
            'ping_diff' => time() - $thread['user_ping'],
            'is_online' => ($thread['date_closed'] || ($thread['user_ping'] < (time() - (int) $this->getSetting('store_inactive_timeout'))) ? 0 : 1)
         );
         
         if ($extended)
            $threads[$thread['thread_id']]['total_new'] = $thread['total_new'];
      }
      return $threads;
   }
   
   protected function removeThread($thread_id) {
      // Save into data warehouse
      if ($this->getSetting('data_warehouse_status')) {
         $sql = "";
         
         $thread_info = $this->getThread($thread_id);
         $messages    = $this->getMessages($thread_id);
         
         if ($messages) {
            $sql .= "INSERT INTO `" . DB_PREFIX . "livehelp_data_warehouse` (`thread_id`, `customer_name`, `customer_id`, `operator_id`, `operator_name`, `date_thread_added`, `date_thread_closed`, `customer_ip`, `customer_agent`, `initiator`, `message`, `date_message_added`) VALUES ";
            
            $thread_array   = array();
            $thread_array[] = (int) $thread_id;
            $thread_array[] = $this->db->escape($thread_info['user_name']);
            $thread_array[] = (int) $thread_info['customer_id'];
            $thread_array[] = (int) $thread_info['operator_id'];
            $thread_array[] = $this->db->escape($this->name);
            $thread_array[] = date("Y-m-d H:i:s", $thread_info['date_added']);
            $thread_array[] = date("Y-m-d H:i:s", $thread_info['date_closed']);
            $thread_array[] = $this->db->escape($thread_info['user_ip']);
            $thread_array[] = $this->db->escape($thread_info['user_agent']);
            
            foreach ($messages as $message) {
               $values = array();
               $values += $thread_array;
               $values[] = (int) $message['initiator'];
               $values[] = $this->db->escape($message['message']);
               $values[] = date("Y-m-d H:i:s", $message['date_added']);
               
               $sql .= " ('" . implode("', '", $values) . "')";
               
               if (end($messages) != $message)
                  $sql .= ",";
            }
            
            $this->db->query($sql);
         }
      }
      
      $this->db->query("DELETE FROM `" . DB_PREFIX . "livehelp_message` WHERE thread_id = '" . (int) $thread_id . "'");
      $this->db->query("DELETE FROM `" . DB_PREFIX . "livehelp_thread` WHERE thread_id = '" . (int) $thread_id . "'");
   }
   
   // Update operator's last_activity and check is_logged
   public function refreshLogged($logged = 1) {
      $this->db->query("UPDATE `" . DB_PREFIX . "livehelp_operator` SET last_activity = '" . time() . "', is_logged = '" . (int) $logged . "' WHERE operator_id = '" . $this->operator_id . "'");
   }
   
   public function hasAccess($status = 1) {
      $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "livehelp_operator WHERE user_id = '" . (int) $this->user->getId() . "' AND status = '" . (int) $status . "'");
      
      return ($query->num_rows ? true : false);
   }
   
   protected function broadcastNewStatus($status_id) {
      $results = $this->db->query("SELECT thread_id FROM `" . DB_PREFIX . "livehelp_thread` WHERE operator_id = '" . (int) $this->operator_id . "' AND date_closed = '0'");
      
      $status_info = $this->getStatusDetail($status_id);
      
      if ($status_info && $results->rows) {
         
         foreach ($results->rows as $row) {
            $msg = new LivehelpMSG($this);
            
            $msg->thread_id = $row['thread_id'];
            $msg->text      = $this->language->get('text_change_status_to') . '<div class="lh-status-label label label-default">' . $status_info['name'] . '</div><p class="lh-status-text"' . ($status_info['color'] ? ' style="color: #' . $status_info['color'] . '"' : '') . '>' . $status_info['text'] . '</p>';
            $msg->initiator = $this->role['bot'];
            
            $msg->send();
         }
      }
   }
}