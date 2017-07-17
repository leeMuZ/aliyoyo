<?php
class ControllerLivehelpLivehelpSetting extends Controller {
   private $sound_folder = "sounds/";
   private $error = array();
   
   public function index() {
      $this->load->language('livehelp/livehelp_setting');
      $this->load->model('livehelp/livehelp_setting');
      
      if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
         $this->model_livehelp_livehelp_setting->setSetting($this->request->post);
         
         $this->session->data['success'] = $this->language->get('text_success');
         
         $this->response->redirect($this->url->link('livehelp/livehelp_setting', 'token=' . $this->session->data['token'], 'SSL'));
      }
      
      $this->initClass();
      $this->document->setTitle($this->language->get('heading_title'));
      
      $data['breadcrumbs'] = array();
      
      $data['breadcrumbs'][] = array(
         'text' => $this->language->get('text_home'),
         'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
      );
      
      $data['breadcrumbs'][] = array(
         'text' => $this->language->get('heading_title'),
         'href' => $this->url->link('livehelp/livehelp_setting', 'token=' . $this->session->data['token'], 'SSL')
      );
      
      if (isset($this->session->data['success'])) {
         $data['success'] = $this->session->data['success'];
         
         unset($this->session->data['success']);
      } else {
         $data['success'] = '';
      }
      
      $data['heading_title'] = $this->language->get('heading_title');
      
      $data['text_enabled']     = $this->language->get('text_enabled');
      $data['text_disabled']    = $this->language->get('text_disabled');
      $data['text_yes']         = $this->language->get('text_yes');
      $data['text_no']          = $this->language->get('text_no');
      $data['text_select']      = $this->language->get('text_select');
      $data['text_plugin']      = $this->language->get('text_plugin');
      $data['text_offline']     = $this->language->get('text_offline');
      $data['text_count']       = $this->language->get('text_count');
      $data['text_seconds']     = $this->language->get('text_seconds');
      $data['text_miliseconds'] = $this->language->get('text_miliseconds');
      $data['text_play']        = $this->language->get('text_play');
      $data['text_form']        = $this->language->get('text_form');
      $data['text_default']     = $this->language->get('text_default');
      $data['text_help_offline_form_emails'] = $this->language->get('text_help_offline_form_emails');

      $data['text_spam_filter']          = $this->language->get('text_spam_filter');
      $data['text_entry_email']          = $this->language->get('text_entry_email');
      $data['text_iteration']            = $this->language->get('text_iteration');
      $data['text_off']                  = $this->language->get('text_off');
      $data['text_logout']               = $this->language->get('text_logout');
      $data['text_toggle_status']        = $this->language->get('text_toggle_status');
      $data['text_sample_image_display'] = $this->language->get('text_sample_image_display');
      $data['text_sample_image']         = $this->language->get('text_sample_image');
      $data['text_sounds']               = $this->language->get('text_sounds');
      $data['text_accepting_html']       = $this->language->get('text_accepting_html');
      $data['tab_general']               = $this->language->get('tab_general');
      $data['tab_admin']                 = $this->language->get('tab_admin');
      $data['tab_store']                 = $this->language->get('tab_store');
      
      $data['column_filename']         = $this->language->get('column_filename');
      $data['column_new_message']      = $this->language->get('column_new_message');
      $data['column_message_sent']     = $this->language->get('column_message_sent');
      $data['column_user_logged']      = $this->language->get('column_user_logged');
      $data['column_user_logout']      = $this->language->get('column_user_logout');
      $data['column_test_sound']       = $this->language->get('column_test_sound');
      $data['column_special_function'] = $this->language->get('column_special_function');
      $data['column_operator_logged']  = $this->language->get('column_operator_logged');
      $data['column_operator_logout']  = $this->language->get('column_operator_logout');
      
      $data['entry_cart_update_interval']    = $this->language->get('entry_cart_update_interval');
      $data['entry_absolute_path']           = $this->language->get('entry_absolute_path');
      $data['entry_text_max_length']         = $this->language->get('entry_text_max_length');
      $data['entry_data_warehouse_status']   = $this->language->get('entry_data_warehouse_status');
      $data['entry_store_inactive_timeout']  = $this->language->get('entry_store_inactive_timeout');
      $data['entry_admin_inactive_timeout']  = $this->language->get('entry_admin_inactive_timeout');
      $data['entry_refresh_rate']            = $this->language->get('entry_refresh_rate');
      $data['entry_admin_inactive_action']   = $this->language->get('entry_admin_inactive_action');
      $data['entry_expired']                 = $this->language->get('entry_expired');
      $data['entry_store_heading_title']     = $this->language->get('entry_store_heading_title');
      $data['entry_smiley_status']           = $this->language->get('entry_smiley_status');
      $data['entry_bbcode_status']           = $this->language->get('entry_bbcode_status');
      $data['entry_offline_form']            = $this->language->get('entry_offline_form');
      $data['entry_offline_form_emails']     = $this->language->get('entry_offline_form_emails');
      $data['entry_spam_filter_status']      = $this->language->get('entry_spam_filter_status');
      $data['entry_spam_filter_score_limit'] = $this->language->get('entry_spam_filter_score_limit');
      $data['entry_spam_filter_penalty']     = $this->language->get('entry_spam_filter_penalty');
      $data['entry_spam_filter_range']       = $this->language->get('entry_spam_filter_range');
      
      $data['title_expired']                = $this->language->get('title_expired');
      $data['title_absolute_path']          = $this->language->get('title_absolute_path');
      $data['title_refresh_rate']           = $this->language->get('title_refresh_rate');
      $data['title_admin_inactive_timeout'] = $this->language->get('title_admin_inactive_timeout');
      $data['title_admin_inactive_action']  = $this->language->get('title_admin_inactive_action');
      $data['title_store_inactive_timeout'] = $this->language->get('title_store_inactive_timeout');
      $data['title_cart_update_interval']   = $this->language->get('title_cart_update_interval');
      $data['title_spam_filter_penalty']    = $this->language->get('title_spam_filter_penalty');
      $data['title_spam_filter_range']      = $this->language->get('title_spam_filter_range');
      $data['title_offline_form_emails']    = $this->language->get('title_offline_form_emails');
      
      $data['button_save'] = $this->language->get('button_save');
      
      if (isset($this->error['warning'])) {
         $data['error_warning'] = $this->error['warning'];
      } else {
         $data['error_warning'] = '';
      }
      
      foreach ($this->error as $key => $value) {
         $data['error_' . $key] = $value;
      }
      
      $data['action'] = $this->url->link('livehelp/livehelp_setting', 'token=' . $this->session->data['token'], 'SSL');
      
      // GENERAL VARIABLES
      if (isset($this->request->post['admin_refresh_rate'])) {
         $data['admin_refresh_rate'] = $this->request->post['admin_refresh_rate'];
      } else {
         $data['admin_refresh_rate'] = $this->livehelp_operator->getSetting('admin_refresh_rate');
      }
      
      if (isset($this->request->post['store_refresh_rate'])) {
         $data['store_refresh_rate'] = $this->request->post['store_refresh_rate'];
      } else {
         $data['store_refresh_rate'] = $this->livehelp_operator->getSetting('store_refresh_rate');
      }
      
      if (isset($this->request->post['absolute_path'])) {
         $data['absolute_path'] = $this->request->post['absolute_path'];
      } else {
         $data['absolute_path'] = $this->livehelp_operator->getSetting('absolute_path');
      }
      
      if (isset($this->request->post['text_max_length'])) {
         $data['text_max_length'] = $this->request->post['text_max_length'];
      } else {
         $data['text_max_length'] = $this->livehelp_operator->getSetting('text_max_length');
      }
      
      if (isset($this->request->post['smiley_status'])) {
         $data['smiley_status'] = $this->request->post['smiley_status'];
      } else {
         $data['smiley_status'] = $this->livehelp_operator->getSetting('smiley_status');
      }
      
      if (isset($this->request->post['bbcode_status'])) {
         $data['bbcode_status'] = $this->request->post['bbcode_status'];
      } else {
         $data['bbcode_status'] = $this->livehelp_operator->getSetting('bbcode_status');
      }
      
      if (isset($this->request->post['data_warehouse_status'])) {
         $data['data_warehouse_status'] = $this->request->post['data_warehouse_status'];
      } else {
         $data['data_warehouse_status'] = $this->livehelp_operator->getSetting('data_warehouse_status');
      }
      
      if (isset($this->request->post['admin_inactive_timeout'])) {
         $data['admin_inactive_timeout'] = $this->request->post['admin_inactive_timeout'];
      } else {
         $data['admin_inactive_timeout'] = $this->livehelp_operator->getSetting('admin_inactive_timeout');
      }
      
      if (isset($this->request->post['store_inactive_timeout'])) {
         $data['store_inactive_timeout'] = $this->request->post['store_inactive_timeout'];
      } else {
         $data['store_inactive_timeout'] = $this->livehelp_operator->getSetting('store_inactive_timeout');
      }
      
      if (isset($this->request->post['cart_update_interval'])) {
         $data['cart_update_interval'] = (int) $this->request->post['cart_update_interval'];
      } else {
         $data['cart_update_interval'] = (int) $this->livehelp_operator->getSetting('cart_update_interval');
      }
      
      $emoticons                     = $this->livehelp_operator->getEmoticons();
      $data['sample_emoticon'] = (isset($emoticons['smile']) ? "image/emoticons/smile.png" : false);
      
      if (isset($this->request->post['offline_form'])) {
         $data['offline_form'] = $this->request->post['offline_form'];
      } else {
         $data['offline_form'] = $this->livehelp_operator->getSetting('offline_form');
      }
      
      if (isset($this->request->post['offline_form_emails'])) {
         $data['offline_form_emails'] = $this->request->post['offline_form_emails'];
      } else {
         $data['offline_form_emails'] = $this->livehelp_operator->getSetting('offline_form_emails');
      }
      
      // SPAM FILTER
      if (isset($this->request->post['spam_filter_status'])) {
         $data['spam_filter_status'] = $this->request->post['spam_filter_status'];
      } else {
         $data['spam_filter_status'] = $this->livehelp_operator->getSetting('spam_filter_status');
      }
      
      if (isset($this->request->post['spam_filter_score_limit'])) {
         $data['spam_filter_score_limit'] = $this->request->post['spam_filter_score_limit'];
      } else {
         $data['spam_filter_score_limit'] = $this->livehelp_operator->getSetting('spam_filter_score_limit');
      }
      
      if (isset($this->request->post['spam_filter_penalty'])) {
         $data['spam_filter_penalty'] = $this->request->post['spam_filter_penalty'];
      } else {
         $data['spam_filter_penalty'] = $this->livehelp_operator->getSetting('spam_filter_penalty');
      }
      
      if (isset($this->request->post['spam_filter_range'])) {
         $data['spam_filter_range'] = $this->request->post['spam_filter_range'];
      } else {
         $data['spam_filter_range'] = $this->livehelp_operator->getSetting('spam_filter_range');
      }
      
      // SOUNDS
      // admin
      if (isset($this->request->post['admin_sound_new_message'])) {
         $data['admin_sound_new_message'] = $this->request->post['admin_sound_new_message'];
      } else {
         $data['admin_sound_new_message'] = $this->livehelp_operator->getSetting('admin_sound_new_message');
      }
      
      if (isset($this->request->post['admin_sound_message_sent'])) {
         $data['admin_sound_message_sent'] = $this->request->post['admin_sound_message_sent'];
      } else {
         $data['admin_sound_message_sent'] = $this->livehelp_operator->getSetting('admin_sound_message_sent');
      }
      
      if (isset($this->request->post['admin_sound_user_logged'])) {
         $data['admin_sound_user_logged'] = $this->request->post['admin_sound_user_logged'];
      } else {
         $data['admin_sound_user_logged'] = $this->livehelp_operator->getSetting('admin_sound_user_logged');
      }
      
      if (isset($this->request->post['admin_sound_user_logout'])) {
         $data['admin_sound_user_logout'] = $this->request->post['admin_sound_user_logout'];
      } else {
         $data['admin_sound_user_logout'] = $this->livehelp_operator->getSetting('admin_sound_user_logout');
      }
      
      if (isset($this->request->post['admin_sound_special'])) {
         $data['admin_sound_special'] = $this->request->post['admin_sound_special'];
      } else {
         $data['admin_sound_special'] = $this->livehelp_operator->getSetting('admin_sound_special');
      }
      
      // store
      if (isset($this->request->post['store_heading_title'])) {
         $data['store_heading_title'] = $this->request->post['store_heading_title'];
      } else {
         $data['store_heading_title'] = ($this->livehelp_operator->getSetting('store_heading_title') ? $this->livehelp_operator->getSetting('store_heading_title') : array());
      }
      
      if (isset($this->request->post['store_sound_new_message'])) {
         $data['store_sound_new_message'] = $this->request->post['store_sound_new_message'];
      } else {
         $data['store_sound_new_message'] = $this->livehelp_operator->getSetting('store_sound_new_message');
      }
      
      if (isset($this->request->post['store_sound_message_sent'])) {
         $data['store_sound_message_sent'] = $this->request->post['store_sound_message_sent'];
      } else {
         $data['store_sound_message_sent'] = $this->livehelp_operator->getSetting('store_sound_message_sent');
      }
      
      if (isset($this->request->post['store_sound_operator_logged'])) {
         $data['store_sound_operator_logged'] = $this->request->post['store_sound_operator_logged'];
      } else {
         $data['store_sound_operator_logged'] = $this->livehelp_operator->getSetting('store_sound_operator_logged');
      }
      
      if (isset($this->request->post['store_sound_operator_logout'])) {
         $data['store_sound_operator_logout'] = $this->request->post['store_sound_operator_logout'];
      } else {
         $data['store_sound_operator_logout'] = $this->livehelp_operator->getSetting('store_sound_operator_logout');
      }
      
      if (isset($this->request->post['store_sound_special'])) {
         $data['store_sound_special'] = $this->request->post['store_sound_special'];
      } else {
         $data['store_sound_special'] = $this->livehelp_operator->getSetting('store_sound_special');
      }
      

      // NEW custom update
      $data['text_appearance']    = $this->language->get('text_appearance');

      $data['text_stick_right']    = $this->language->get('text_stick_right');
      $data['text_stick_left']    = $this->language->get('text_stick_left');
      $data['text_stick_bottom']    = $this->language->get('text_stick_bottom');

      $data['entry_stick_position']    = $this->language->get('entry_stick_position');
      $data['entry_widget_theme']    = $this->language->get('entry_widget_theme');
      $data['entry_dragable_widget_status']    = $this->language->get('entry_dragable_widget_status');
      $data['entry_auto_user_sign']    = $this->language->get('entry_auto_user_sign');   
      $data['title_auto_user_sign']    = $this->language->get('title_auto_user_sign');  

      $data['entry_page_title_alert']    = $this->language->get('entry_page_title_alert');  
      $data['title_page_title_alert']    = $this->language->get('title_page_title_alert');  

      $data['entry_custom_message_slidebar']    = $this->language->get('entry_custom_message_slidebar');  
      $data['title_custom_message_slidebar']    = $this->language->get('title_custom_message_slidebar');

      # Get possible livehelp themes
      $data['themes'] = array();

      if(file_exists(DIR_CATALOG . "view/theme/default/stylesheet/livehelp_theme"))
      {
         foreach (glob(DIR_CATALOG . "view/theme/default/stylesheet/livehelp_theme/*.css") as $file) 
         {
            $f_info = pathinfo($file);
            if($f_info['filename'] !== "lh_default") $data['themes'][] = $f_info['filename'];
         }

      } else {
         $data['error_theme'] = "Error: location " . DIR_CATALOG . "view/theme/default/stylesheet/livehelp_theme" . " not found! Themes list can not be loaded!";
      }

      # Dragable widget
      if (isset($this->request->post['dragable_widget_status'])) {
         $data['dragable_widget_status'] = $this->request->post['dragable_widget_status'];
      } else {
         $data['dragable_widget_status'] = $this->livehelp_operator->getSetting('dragable_widget_status');
      }

      # Widget theme
      if (isset($this->request->post['widget_theme'])) {
         $data['widget_theme'] = $this->request->post['widget_theme'];
      } else {
         $data['widget_theme'] = $this->livehelp_operator->getSetting('widget_theme');
      }

      # Stick position
      if (isset($this->request->post['stick_position'])) {
         $data['stick_position'] = $this->request->post['stick_position'];
      } else {
         $data['stick_position'] = $this->livehelp_operator->getSetting('stick_position');
      }

      # Auto user sign
      if (isset($this->request->post['auto_user_sign'])) {
         $data['auto_user_sign'] = $this->request->post['auto_user_sign'];
      } else {
         $data['auto_user_sign'] = $this->livehelp_operator->getSetting('auto_user_sign');
      }

      # Auto user sign
      if (isset($this->request->post['page_title_alert'])) {
         $data['page_title_alert'] = $this->request->post['page_title_alert'];
      } else {
         $data['page_title_alert'] = $this->livehelp_operator->getSetting('page_title_alert');
      }

      # Auto user sign
      if (isset($this->request->post['custom_message_slidebar'])) {
         $data['custom_message_slidebar'] = $this->request->post['custom_message_slidebar'];
      } else {
         $data['custom_message_slidebar'] = $this->livehelp_operator->getSetting('custom_message_slidebar');
      }
      // end -->



      // LANGUAGES
      $this->load->model('localisation/language');
      $data['languages'] = $this->model_localisation_language->getLanguages();
      
      // STATUS TEXT
      $this->load->model('livehelp/livehelp_status');
      $data['statuses'] = $this->model_livehelp_livehelp_status->getStatuses();
      
      // SOUNDS
      $sounds = scandir(DIR_IMAGE . $this->sound_folder);
      unset($sounds[0]);
      unset($sounds[1]);
      
      $data['sounds']       = array_values($sounds);
      $data['sound_folder'] = DIR_IMAGE . $this->sound_folder;
      

      $data['header']      = $this->load->controller('common/header');
      $data['column_left'] = $this->load->controller('common/column_left');
      $data['footer']      = $this->load->controller('common/footer');

      $this->response->setOutput($this->load->view('livehelp/livehelp_setting.tpl', $data));
   }
   
   protected function validate() {
      if (!$this->user->hasPermission('modify', 'livehelp/livehelp_setting')) {
         $this->error['warning'] = $this->language->get('error_permission');
      }
      
      // ms unit 1000 = 1 second
      if (!$this->request->post['admin_refresh_rate'] || (int) $this->request->post['admin_refresh_rate'] < 2000) {
         $this->error['admin_refresh_rate'] = $this->language->get('error_admin_refresh_rate');
      }
      
      if (!$this->request->post['store_refresh_rate'] || (int) $this->request->post['store_refresh_rate'] < 2000) {
         $this->error['store_refresh_rate'] = $this->language->get('error_store_refresh_rate');
      }
      
      if ((int) $this->request->post['text_max_length'] < 10) {
         $this->error['text_max_length'] = $this->language->get('error_text_max_length');
      }
      
      // s unit: 60 = 1 minute
      if (!$this->request->post['admin_inactive_timeout'] || $this->request->post['admin_inactive_timeout'] < 60) {
         $this->error['admin_inactive_timeout'] = $this->language->get('error_admin_inactive_timeout');
      }
      
      if (!$this->request->post['store_inactive_timeout'] || $this->request->post['store_inactive_timeout'] < 60) {
         $this->error['store_inactive_timeout'] = $this->language->get('error_store_inactive_timeout');
      }
      
      return !$this->error;
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