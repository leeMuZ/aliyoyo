<?php
class ControllerModuleLivehelp extends Controller {
   private $error = array();
   
   public function index() {
      $this->load->language('module/livehelp');
      
      $this->document->setTitle($this->language->get('heading_title'));
      
      $this->load->model('setting/setting');
      
      if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) 
      {
         $this->model_setting_setting->editSetting('livehelp', $this->request->post);

         $this->session->data['success'] = $this->language->get('text_success');

         $this->response->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], true));
      }
      
      $data['heading_title'] = $this->language->get('heading_title');
      
      $data['text_yes']      = $this->language->get('text_yes');
      $data['text_no']       = $this->language->get('text_no');
      $data['text_enabled']  = $this->language->get('text_enabled');
      $data['text_disabled'] = $this->language->get('text_disabled');
      $data['text_edit']     = $this->language->get('text_edit'); 

      $data['text_info']                = $this->language->get('text_info');
      $data['text_module_info']         = $this->language->get('text_module_info');
      $data['title_livehelp_status']    = $this->language->get('title_livehelp_status');
      $data['text_content_bottom']      = $this->language->get('text_content_bottom');
      $data['text_livehelp_appearance'] = $this->language->get('text_livehelp_appearance');
      
      $data['entry_layout']        = $this->language->get('entry_layout');
      $data['entry_heading_title'] = $this->language->get('entry_heading_title');
      $data['entry_sort_order']    = $this->language->get('entry_sort_order');
      
      $data['entry_status'] = $this->language->get('entry_status');
      $data['entry_admin']  = $this->language->get('entry_admin');
      
      $data['button_save']       = $this->language->get('button_save');
      $data['button_cancel']     = $this->language->get('button_cancel');
      $data['button_add_module'] = $this->language->get('button_add_module');
      $data['button_remove']     = $this->language->get('button_remove');
      
      if (isset($this->error['warning'])) {
         $data['error_warning'] = $this->error['warning'];
      } else {
         $data['error_warning'] = '';
      }
      
      $data['breadcrumbs'] = array();
      
      $data['breadcrumbs'][] = array(
         'text' => $this->language->get('text_home'),
         'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
      );
      
      $data['breadcrumbs'][] = array(
         'text' => $this->language->get('text_module'),
         'href' => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL')
      );
      
      $data['breadcrumbs'][] = array(
         'text' => $this->language->get('heading_title'),
         'href' => $this->url->link('module/livehelp', 'token=' . $this->session->data['token'], 'SSL')
      );
            
      $data['action'] = $this->url->link('module/livehelp', 'token=' . $this->session->data['token'], 'SSL');
      
      $data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
      
      // Livehelp status
      if (isset($this->request->post['livehelp_status'])) {
         $data['livehelp_status'] = (int)$this->request->post['livehelp_status'];
      } else {
         $data['livehelp_status'] = (int)$this->config->get('livehelp_status');
      }
      
      $data['header'] = $this->load->controller('common/header');
      $data['column_left'] = $this->load->controller('common/column_left');
      $data['footer'] = $this->load->controller('common/footer');

      $this->response->setOutput($this->load->view('module/livehelp.tpl', $data));
   }
   
   public function install() {
      $this->load->language('module/livehelp');
      $this->load->model('livehelp/livehelp');
      
      $status = $this->model_livehelp_livehelp->install();
      if ($status) {
         $this->session->data['success'] = $this->language->get('success_sql_install');
      } else {
         $this->session->data['error'] = $this->language->get('error_sql_install');
      }
   }
   
   public function uninstall() {
      $this->load->language('module/livehelp');
      $this->load->model('livehelp/livehelp');
      $status = $this->model_livehelp_livehelp->uninstall();
      if ($status) {
         $this->session->data['success'] = $this->language->get('success_sql_uninstall');
      } else {
         $this->session->data['error'] = $this->language->get('error_sql_uninstall');
      }
   }
   
   protected function validate() {
      if (!$this->user->hasPermission('modify', 'module/livehelp')) {
         $this->error['warning'] = $this->language->get('error_permission');
      }
      
      return !$this->error;
   }
}