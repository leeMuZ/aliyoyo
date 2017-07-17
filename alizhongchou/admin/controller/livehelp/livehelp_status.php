<?php
class ControllerLivehelpLivehelpStatus extends Controller {
   private $error = array();
   
   public function index() {
      $this->load->language('livehelp/livehelp_status');

      $this->load->model('livehelp/livehelp_status');
      
      $this->document->setTitle($this->language->get('heading_title'));

      $this->getList();
   }
   
   public function add() {
      $this->load->language('livehelp/livehelp_status');
      
      $this->document->setTitle($this->language->get('heading_title'));
      
      $this->load->model('livehelp/livehelp_status');
      
      if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
         $this->model_livehelp_livehelp_status->addStatus($this->request->post);
         
         $this->session->data['success'] = $this->language->get('text_success');
         
         $this->response->redirect($this->url->link('livehelp/livehelp_status', 'token=' . $this->session->data['token'], 'SSL'));
      }
      
      $this->getForm();
   }
   
   public function edit() {
      $this->load->language('livehelp/livehelp_status');
      
      $this->document->setTitle($this->language->get('heading_title'));
      
      $this->load->model('livehelp/livehelp_status');
      
      if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
         $this->model_livehelp_livehelp_status->editStatus($this->request->get['status_id'], $this->request->post);
         
         $this->session->data['success'] = $this->language->get('text_success');
         
         $this->response->redirect($this->url->link('livehelp/livehelp_status', 'token=' . $this->session->data['token'], 'SSL'));
      }
      
      $this->getForm();
   }
   
   public function delete() {
      $this->language->load('livehelp/livehelp_status');
      
      $this->document->setTitle($this->language->get('heading_title'));
      
      $this->load->model('livehelp/livehelp_status');
      
      if (isset($this->request->post['selected']) && $this->validateModify()) {
         foreach ($this->request->post['selected'] as $status_id) {
            $this->model_livehelp_livehelp_status->deleteStatus($status_id);
         }
         
         $this->session->data['success'] = $this->language->get('text_success');
         
         $this->response->redirect($this->url->link('livehelp/livehelp_status', 'token=' . $this->session->data['token'], 'SSL'));
      }
      
      $this->getList();
   }
   
   protected function getList() {
      if (isset($this->request->get['sort'])) {
         $sort = $this->request->get['sort'];
      } else {
         $sort = 'lst.name';
      }
      
      if (isset($this->request->get['order'])) {
         $order = $this->request->get['order'];
      } else {
         $order = 'ASC';
      }
      
      if (isset($this->request->get['page'])) {
         $page = $this->request->get['page'];
      } else {
         $page = 1;
      }
      
      $url = $this->getUrl(array(
         "sort",
         "order",
         "page"
      ));
      
      $data['breadcrumbs'] = array();
      
      $data['breadcrumbs'][] = array(
         'text' => $this->language->get('text_home'),
         'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL'),
         'separator' => false
      );
      
      $data['breadcrumbs'][] = array(
         'text' => $this->language->get('heading_title'),
         'href' => $this->url->link('livehelp/livehelp_status', 'token=' . $this->session->data['token'] . $url, 'SSL'),
         'separator' => ' :: '
      );
      
      if (isset($this->error['warning'])) {
         $data['error_warning'] = $this->error['warning'];
      } else {
         $data['error_warning'] = '';
      }
      
      if (isset($this->session->data['success'])) {
         $data['success'] = $this->session->data['success'];
         
         unset($this->session->data['success']);
      } else {
         $data['success'] = '';
      }
      
      $data['heading_title'] = $this->language->get('heading_title');
      
      $data['text_no_results'] = $this->language->get('text_no_results');
      $data['text_list']       = $this->language->get('text_list');
      $data['text_confirm']    = $this->language->get('text_confirm');

      $data['column_name']   = $this->language->get('column_name');
      $data['column_color']  = $this->language->get('column_color');
      $data['column_action'] = $this->language->get('column_action');
      
      $data['button_delete'] = $this->language->get('button_delete');
      $data['button_add'] = $this->language->get('button_add');
      
      $data['add'] = $this->url->link('livehelp/livehelp_status' . "/add", 'token=' . $this->session->data['token'] . $url);
      $data['delete'] = $this->url->link('livehelp/livehelp_status' . "/delete", 'token=' . $this->session->data['token'] . $url);
      
      $filter_data = array(
         'sort' => $sort,
         'order' => $order,
         'start' => ($page - 1) * $this->config->get('config_admin_limit'),
         'page' => $page,
         'limit' => $this->config->get('config_admin_limit')
      );
      
      $data['statuses'] = array();
      
      $result_total = $this->model_livehelp_livehelp_status->getTotalStatuses($filter_data);
      
      $results = $this->model_livehelp_livehelp_status->getStatuses($filter_data);
      
      foreach ($results as $result) {
         $action = array();
         
         $action[] = array(
            'text' => $this->language->get('text_edit'),
            'href' => $this->url->link('livehelp/livehelp_status/edit', 'token=' . $this->session->data['token'] . '&status_id=' . $result['status_id'] . $url, 'SSL')
         );
         
         $data['statuses'][] = array(
            'status_id' => $result['status_id'],
            'name' => $result['name'],
            'color' => '<span class="label" style="background-color: #' . $result['color'] . ';">' . $result['color'] . '</span>',
            'selected' => isset($this->request->post['selected']) && in_array($result['status_id'], $this->request->post['selected']),
            'selected' => isset($this->request->post['selected']) && in_array($result['status_id'], $this->request->post['selected']),
            'action' => $action
         );
      }
      
      $url = $this->getUrl(array(
         'sort',
         'order'
      ));
      
      $pagination        = new Pagination();
      $pagination->total = $result_total;
      $pagination->page  = $page;
      $pagination->limit = $this->config->get('config_admin_limit');
      $pagination->text  = $this->language->get('text_pagination');
      $pagination->url   = $this->url->link('livehelp/livehelp_status', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');
      
      $data['pagination'] = $pagination->render();
      
      $data['results'] = sprintf($this->language->get('text_pagination'), ($result_total) ? (($page - 1) * $this->config->get('config_limit_admin')) + 1 : 0, ((($page - 1) * $this->config->get('config_limit_admin')) > ($result_total - $this->config->get('config_limit_admin'))) ? $result_total : ((($page - 1) * $this->config->get('config_limit_admin')) + $this->config->get('config_limit_admin')), $result_total, ceil($result_total / $this->config->get('config_limit_admin')));

      $url = $this->getUrl(array(
         'page'
      ));
      
      if ($order == 'ASC') {
         $url .= '&order=DESC';
      } else {
         $url .= '&order=ASC';
      }
      
      $data['sort_name'] = $this->url->link('livehelp/livehelp_status', 'token=' . $this->session->data['token'] . '&sort=lst.name' . $url, 'SSL');
      
      $data['sort']  = $sort;
      $data['order'] = $order;
      
      $data['header'] = $this->load->controller('common/header');
      $data['column_left'] = $this->load->controller('common/column_left');
      $data['footer'] = $this->load->controller('common/footer');

      $this->response->setOutput($this->load->view('livehelp/livehelp_status_list.tpl', $data));
   }
   
   protected function getForm() {
      $this->document->addStyle('view/javascript/jquery/color_picker/jquery.minicolors.css');
      $this->document->addScript('view/javascript/jquery/color_picker/jquery.minicolors.min.js');
      
      $data['heading_title'] = $this->language->get('heading_title');
      
      $data['text_enabled']  = $this->language->get('text_enabled');
      $data['text_disabled'] = $this->language->get('text_disabled');
      $data['text_yes']      = $this->language->get('text_yes');
      $data['text_no']       = $this->language->get('text_no');
      $data['text_select']   = $this->language->get('text_select');
      $data['text_form']     = $this->language->get('text_form');
      
      $data['entry_color']       = $this->language->get('entry_color');
      $data['entry_name']        = $this->language->get('entry_name');
      $data['entry_user']        = $this->language->get('entry_user');
      $data['entry_description'] = $this->language->get('entry_description');
      
      $data['entry_text'] = $this->language->get('entry_text');
      
      $data['title_name']  = $this->language->get('title_name');
      $data['title_color'] = $this->language->get('title_color');
      
      $data['button_save']   = $this->language->get('button_save');
      $data['button_cancel'] = $this->language->get('button_cancel');
      
      $data['cancel'] = $this->url->link('livehelp/livehelp_status');
      
      if (isset($this->error['warning'])) {
         $data['error_warning'] = $this->error['warning'];
      } else {
         $data['error_warning'] = '';
      }
      
      if (isset($this->error['name'])) {
         $data['error_name'] = $this->error['name'];
      } else {
         $data['error_name'] = array();
      }
      
      if (isset($this->error['text'])) {
         $data['error_text'] = $this->error['text'];
      } else {
         $data['error_text'] = array();
      }
      
      $url = $this->getUrl(array(
         "sort",
         "order",
         "page"
      ));
      
      $data['breadcrumbs'] = array();
      
      $data['breadcrumbs'][] = array(
         'text' => $this->language->get('text_home'),
         'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
      );
      
      $data['breadcrumbs'][] = array(
         'text' => $this->language->get('heading_title'),
         'href' => $this->url->link('livehelp/livehelp_status', 'token=' . $this->session->data['token'] . $url, 'SSL')
      );
      
      if (!isset($this->request->get['status_id'])) {
         $data['action'] = $this->url->link('livehelp/livehelp_status/add', 'token=' . $this->session->data['token'], 'SSL');
      } else {
         $data['action'] = $this->url->link('livehelp/livehelp_status/edit', 'token=' . $this->session->data['token'] . '&status_id=' . $this->request->get['status_id'], 'SSL');
      }
      
      if (isset($this->request->get['status_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
         $status_info = $this->model_livehelp_livehelp_status->getStatus($this->request->get['status_id']);
      }
      
      if (isset($this->request->post['status_text'])) {
         $data['status_text'] = $this->request->post['status_text'];
      } elseif (isset($this->request->get['status_id'])) {
         $data['status_text'] = $this->model_livehelp_livehelp_status->getStatusText($this->request->get['status_id']);
      } else {
         $data['status_text'] = array();
      }
      
      if (isset($this->request->post['color'])) {
         $data['color'] = $this->request->post['color'];
      } elseif (!empty($status_info)) {
         $data['color'] = $status_info['color'];
      } else {
         $data['color'] = '000000';
      }
      
      // Languages
      $this->load->model('localisation/language');
      
      $data['languages'] = $this->model_localisation_language->getLanguages();
      
      $data['header'] = $this->load->controller('common/header');
      $data['column_left'] = $this->load->controller('common/column_left');
      $data['footer'] = $this->load->controller('common/footer');

      $this->response->setOutput($this->load->view('livehelp/livehelp_status_form.tpl', $data));
   }
   
   /*
   VALIDATION
   */
   protected function validateModify() {
      if (!$this->user->hasPermission('modify', 'livehelp/livehelp_status')) {
         $this->error['warning'] = $this->language->get('error_permission');
      }
      
      return !$this->error;
   }
   
   protected function validateForm() {
      $this->validateModify();
      
      foreach ($this->request->post['status_text'] as $language_id => $value) {
         if ((utf8_strlen($value['name']) < 2) || (utf8_strlen($value['name']) > 64)) {
            $this->error['name'][$language_id] = $this->language->get('error_name');
         }
         
         if ((utf8_strlen($value['text']) < 3) || (utf8_strlen($value['text']) > 450)) {
            $this->error['text'][$language_id] = $this->language->get('error_text');
         }
      }
      
      return !$this->error;
   }
   
   protected function getUrl($var) {
      $url = '';
      
      if (is_string($var)) {
         if (isset($this->request->get[$var]))
            $url .= "&" . $var . "=" . $this->request->get[$var];
      } else if (is_array($var)) {
         foreach ($var as $value) {
            if (isset($this->request->get[$value]))
               $url .= "&" . $value . "=" . $this->request->get[$value];
         }
      }
      return $url;
   }
}