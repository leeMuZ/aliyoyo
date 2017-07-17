<?php
class ControllerLivehelpLivehelpWidget extends Controller {

   public function index() {
if(!$this->config->get('livehelp_status')) return;

      // Global livehelp status
      $this->initClass();

      if (!$this->livehelp_operator->hasAccess()) return;

      $this->load->language('livehelp/livehelp_widget');
      
      $this->document->addStyle('view/stylesheet/livehelp.css');
      $this->document->addScript('view/javascript/livehelp/livehelp_interface.min.js');
      
      // AS LOGGED
      $data['is_logged'] = false;
      
      if ($this->livehelp_operator->isLogged()) {
         $this->document->addScript('view/javascript/livehelp/livehelp_chat.min.js');
        
         $data['is_logged'] = true;
         $data['status_id'] = $this->livehelp_operator->getStatus();
        
         $data['operator_id'] = $this->livehelp_operator->getId();

         $data['threads'] = $this->livehelp_operator->getCurrentThreads();
        
         // Thread actions
         $data['text_kick']            = $this->language->get('text_kick');
         $data['text_ban']             = $this->language->get('text_ban');
         $data['text_remove']          = $this->language->get('text_remove');
         $data['text_toggle_operator'] = $this->language->get('text_toggle_operator');
        
         $data['text_thread_manage'] = $this->language->get('text_thread_manage');
        
         $data['operators'] = $this->livehelp_operator->getOperators(array(
            'online' => 1,
            'except_self' => true
         ));
        
         // SETTINGS  
         $setting = array();
        
         $setting['admin_refresh_rate'] = (int) $this->livehelp_operator->getSetting('admin_refresh_rate');
         $setting['text_max_length']    = (int) $this->livehelp_operator->getSetting('text_max_length');
        
         $setting['smiley_status'] = $this->livehelp_operator->getSetting('smiley_status');
         $setting['bbcode_status'] = $this->livehelp_operator->getSetting('bbcode_status');
        
         $setting['admin_sound_new_message']  = $this->livehelp_operator->getSetting('admin_sound_new_message');
         $setting['admin_sound_message_sent'] = $this->livehelp_operator->getSetting('admin_sound_message_sent');
         $setting['admin_sound_user_logged']  = $this->livehelp_operator->getSetting('admin_sound_user_logged');
         $setting['admin_sound_user_logout']  = $this->livehelp_operator->getSetting('admin_sound_user_logout');
         $setting['admin_sound_special']      = $this->livehelp_operator->getSetting('admin_sound_special');
        
         $setting['sound'] = ($setting['admin_sound_new_message'] || $setting['admin_sound_message_sent'] || $setting['admin_sound_user_logged'] || $setting['admin_sound_user_logout'] || $setting['admin_sound_special']);
        
         // Load smiles
         $data['emoticons']  = $this->livehelp_operator->getEmoticons();
         $setting['smiley_status'] = ($setting['smiley_status'] && !empty($data['emoticons'])); // merge to one
        
         $data['language_id']   = $this->config->get('config_language_id');
         $data['language_code'] = $this->config->get('config_language');
        
         $data['setting'] = $setting;
        
         // Get status message
         $data['statuses'] = array();
        
         if ($this->livehelp_operator->isLogged()) {
            $this->load->model('livehelp/livehelp_status');
            
            $data['statuses'] = $this->model_livehelp_livehelp_status->getStatuses();
         }

         $data['js_language'] = array();
         $data['js_language'][$this->config->get('config_language')] = array(
            'text_operator_signed'     => $this->language->get('text_js_operator_signed'),
            'text_username'            => $this->language->get('text_js_username'),
            'text_ip'                  => $this->language->get('text_js_ip'),
            'text_user_agent'          => $this->language->get('text_js_user_agent'),
            'text_referer'             => $this->language->get('text_js_referer'),
            'text_customer'            => $this->language->get('text_js_customer'),
            'text_registred'           => $this->language->get('text_js_registred'),
            'text_not_registred'       => $this->language->get('text_js_not_registred'),
            'text_date_added'          => $this->language->get('text_js_date_added'),
            'text_closed'              => $this->language->get('text_js_closed'),
            'text_ban_success'         => $this->language->get('text_js_ban_success'),
            'text_last_activity'       => $this->language->get('text_js_last_activity'),
            'text_before'              => $this->language->get('text_js_before'),
            'text_user_away'           => $this->language->get('text_js_user_away'),
            'text_user_back_online'    => $this->language->get('text_js_user_back_online'),
            'text_right_now'           => $this->language->get('text_js_right_now'),
            'text_user_cart'           => $this->language->get('text_js_user_cart'),
            'text_cart_items'          => $this->language->get('text_js_cart_items'),
            'text_cart_total'          => $this->language->get('text_js_cart_total'),
            'text_in_stock'            => $this->language->get('text_js_in_stock'),
            'text_out_stock'           => $this->language->get('text_js_out_stock'),
            'text_product_id'          => $this->language->get('text_js_product_id'),
            'text_product_name'        => $this->language->get('text_js_product_name'),
            'text_product_qty'         => $this->language->get('text_js_product_qty'),
            'text_empty_cart'          => $this->language->get('text_js_empty_cart'),
         );
      }
     
      // Language
      $data['heading_title'] = $this->language->get('heading_title');
      
      $data['text_nothing']         = $this->language->get('text_nothing');
      $data['text_status']          = $this->language->get('text_status');
      $data['text_online']          = $this->language->get('text_online');
      $data['text_offline']         = $this->language->get('text_offline');
      $data['text_signout_confirm'] = $this->language->get('text_signout_confirm');
      $data['text_current_state']   = $this->language->get('text_current_state');
      
      $data['button_sign_in']  = $this->language->get('button_sign_in');
      $data['button_sign_out'] = $this->language->get('button_sign_out');
      
      // BBCode title
      $data['title_bold']      = $this->language->get('title_bold');
      $data['title_italic']    = $this->language->get('title_italic');
      $data['title_underline'] = $this->language->get('title_underline');
      $data['title_link']      = $this->language->get('title_link');
      $data['title_image']     = $this->language->get('title_image');
      $data['title_youtube']   = $this->language->get('title_youtube');
      
      $data['title_tack_toggle']  = $this->language->get('title_tack_toggle');
      $data['title_sound_toggle'] = $this->language->get('title_sound_toggle');

      $data['token'] = $this->session->data['token'];     
      return $this->load->view('livehelp/livehelp_widget.tpl', $data);
   }
  
   public function operation() {
      $this->initClass();
      $this->language->load('livehelp/livehelp_widget');
      $json = array();
      
      if ($this->request->server['REQUEST_METHOD'] == 'POST') {
         if (isset($this->request->post['operation'])) {
            $operation = strtolower($this->request->post['operation']);
         } else {
            $operation = null;
         }
        
         try {
            switch ($operation) {
               case 'login':
                  $this->livehelp_operator->login();
                  break;
               case 'logout':
                  $this->livehelp_operator->logout();
                  break;
               case 'changestatus':
                  if (!isset($this->request->post['status_id']))
                     throw new Exception("Error requested data", 1);
                  $this->livehelp_operator->setStatus($this->request->post['status_id']);
                  break;
               default:   // All operation taken from livehelp_chat.js  
                  $json = $this->livehelp_operator->autoUpdate($this->request->post);
                  break;
            }
         }
         catch (Exception $e) {
            $json['fatal'] = $e;
         }
      }
      
      $this->response->setOutput(json_encode($json));
   }

   protected function initClass() 
   {
      $route = preg_replace('/[^a-zA-Z0-9_\/]/', '', 'livehelp/livehelp_operator');
	  $class = str_replace('/', '\\', $route);

      if(method_exists( $this->load, 'library')) 
      {
         $this->load->library('livehelp/livehelp_operator');

         if(!isset($this->livehelp_operator))
         {
         	$this->registry->set(basename($route), new $class($this->registry));
         }

      } else {
         $file = DIR_SYSTEM . 'library/' . $route . '.php';

         if (is_file($file)) {
            include_once($file);

            $this->registry->set(basename($route), new $class($this->registry));
         } else {
            throw new \Exception('Error: Could not load library ' . $route . '!');
         }
      }
   }
}
