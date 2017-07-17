<?php
class ControllerLivehelpLivehelpUser extends Controller {
   private $error = array();
   
   public function index() {
      $this->load->language('livehelp/livehelp_user');

      $this->load->model('livehelp/livehelp_user');
      
      $this->document->setTitle($this->language->get('heading_title'));

      $this->getList();
   }
   
   public function add() {
      $this->load->language('livehelp/livehelp_user');
      
      $this->document->setTitle($this->language->get('heading_title'));
      
      $this->load->model('livehelp/livehelp_user');
      
      if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
         $this->model_livehelp_livehelp_user->addOperator($this->request->post);
         
         $this->session->data['success'] = $this->language->get('text_success');
         
         $this->response->redirect($this->url->link('livehelp/livehelp_user', 'token=' . $this->session->data['token'], 'SSL'));
      }
      
      $this->getForm();
   }
   
   public function edit() {
      $this->load->language('livehelp/livehelp_user');
      
      $this->document->setTitle($this->language->get('heading_title'));
      
      $this->load->model('livehelp/livehelp_user');
      
      if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
         $this->model_livehelp_livehelp_user->editOperator($this->request->get['operator_id'], $this->request->post);
         
         $this->session->data['success'] = $this->language->get('text_success');
         
         $this->response->redirect($this->url->link('livehelp/livehelp_user', 'token=' . $this->session->data['token'], 'SSL'));
      }
      
      $this->getForm();
   }
   
   public function delete() {
      $this->load->language('livehelp/livehelp_user');
      
      $this->document->setTitle($this->language->get('heading_title'));
      
      $this->load->model('livehelp/livehelp_user');
      
      if (isset($this->request->post['selected']) && $this->validateModify()) {
         
         foreach ($this->request->post['selected'] as $operator_id) {
            $this->model_livehelp_livehelp_user->deleteOperator($operator_id);
         }
         
         $this->session->data['success'] = $this->language->get('text_success');
         
         $url = $this->getUrl(array(
            "sort",
            "order",
            "page"
         ));
         
         $this->response->redirect($this->url->link('livehelp/livehelp_user', 'token=' . $this->session->data['token'] . $url, 'SSL'));
      }
      
      $this->getList();
   }
     
   protected function getList() {
      if (isset($this->request->get['sort'])) {
         $sort = $this->request->get['sort'];
      } else {
         $sort = 'u.username';
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
         "filter_date_added",
         "filter_date_expired",
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
         'href' => $this->url->link('livehelp/livehelp_user', 'token=' . $this->session->data['token'] . $url, 'SSL')
      );
      
      $data['heading_title'] = $this->language->get('heading_title');
      
      $data['text_no_results'] = $this->language->get('text_no_results');

      $data['text_list']         = $this->language->get('text_list');
      $data['column_username']   = $this->language->get('column_username');
      $data['column_action']     = $this->language->get('column_action');
      $data['column_date_added'] = $this->language->get('column_date_added');
      $data['column_status']     = $this->language->get('column_status');
      $data['column_name']       = $this->language->get('column_name');
      $data['text_confirm']      = $this->language->get('text_confirm');

      $data['button_add']    = $this->language->get('button_add');
      $data['button_delete'] = $this->language->get('button_delete');
      
      $data['add'] = $this->url->link('livehelp/livehelp_user' . '/add', 'token=' . $this->session->data['token'] . $url, 'SSL');
      $data['edit'] = $this->url->link('livehelp/livehelp_user' . '/edit', 'token=' . $this->session->data['token'] . $url, 'SSL');
      $data['delete'] = $this->url->link('livehelp/livehelp_user' . "/delete", 'token=' . $this->session->data['token'] . $url);
      
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
      
      $filter_data = array(
         'sort' => $sort,
         'order' => $order,
         'start' => ($page - 1) * $this->config->get('config_admin_limit'),
         'limit' => $this->config->get('config_admin_limit')
      );
      
      $data['users'] = array();
      
      $result_total = $this->model_livehelp_livehelp_user->getTotalOperators($filter_data);
      
      $results = $this->model_livehelp_livehelp_user->getOperators($filter_data);
      
      foreach ($results as $result) {
         $action = array();
         
         $action[] = array(
            'text' => $this->language->get('text_edit'),
            'href' => $this->url->link('livehelp/livehelp_user' . '/edit', 'token=' . $this->session->data['token'] . '&operator_id=' . $result['operator_id'] . $url, 'SSL')
         );
         
         $data['users'][] = array(
            'operator_id' => $result['operator_id'],
            'name' => $result['name'],
            'username' => '<a href="' . $this->url->link('user/user/edit', 'token=' . $this->session->data['token'] . '&user_id=' . $result['user_id']) . '">' . $result['username'] . '</a>',
            'description' => $result['description'],
            'date_added' => $result['date_added'],
            'status' => $result['status'],
            'selected' => isset($this->request->post['selected']) && in_array($result['ban_id'], $this->request->post['selected']),
            'action' => $action
         );
      }
      
      $url = $this->getUrl(array(
         "page"
      ));
      
      if ($order == 'ASC') {
         $url .= '&order=DESC';
      } else {
         $url .= '&order=ASC';
      }
      
      $data['sort_name']       = $this->url->link('livehelp/livehelp_user', 'token=' . $this->session->data['token'] . '&sort=lo.name' . $url, 'SSL');
      $data['sort_username']   = $this->url->link('livehelp/livehelp_user', 'token=' . $this->session->data['token'] . '&sort=u.username' . $url, 'SSL');
      $data['sort_date_added'] = $this->url->link('livehelp/livehelp_user', 'token=' . $this->session->data['token'] . '&sort=lo.date_added' . $url, 'SSL');
      $data['sort_status']     = $this->url->link('livehelp/livehelp_user', 'token=' . $this->session->data['token'] . '&sort=lo.status' . $url, 'SSL');
      
      $url = $this->getUrl(array(
         "sort",
         "order"
      ));
      
      $pagination        = new Pagination();
      $pagination->total = $result_total;
      $pagination->page  = $page;
      $pagination->limit = $this->config->get('config_admin_limit');
      $pagination->text  = $this->language->get('text_pagination');
      $pagination->url   = $this->url->link('sale/order', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');
      
      $data['pagination'] = $pagination->render();
      
      $data['results'] = sprintf($this->language->get('text_pagination'), ($result_total) ? (($page - 1) * $this->config->get('config_limit_admin')) + 1 : 0, ((($page - 1) * $this->config->get('config_limit_admin')) > ($result_total - $this->config->get('config_limit_admin'))) ? $result_total : ((($page - 1) * $this->config->get('config_limit_admin')) + $this->config->get('config_limit_admin')), $result_total, ceil($result_total / $this->config->get('config_limit_admin')));

      $data['sort']  = $sort;
      $data['order'] = $order;
      
      $data['header'] = $this->load->controller('common/header');
      $data['column_left'] = $this->load->controller('common/column_left');
      $data['footer'] = $this->load->controller('common/footer');

      $this->response->setOutput($this->load->view('livehelp/livehelp_user_list.tpl', $data));
   }
   
   protected function getForm() {
      $data['heading_title'] = $this->language->get('heading_title');
      
      $data['text_form']                 = $this->language->get('text_form');
      $data['text_enabled']              = $this->language->get('text_enabled');
      $data['text_disabled']             = $this->language->get('text_disabled');
      $data['text_yes']                  = $this->language->get('text_yes');
      $data['text_no']                   = $this->language->get('text_no');
      $data['text_select']               = $this->language->get('text_select');
      $data['text_accepting_html']       = $this->language->get('text_accepting_html');
      $data['entry_status']              = $this->language->get('entry_status');
      $data['entry_name']                = $this->language->get('entry_name');
      $data['entry_user']                = $this->language->get('entry_user');
      $data['entry_image']               = $this->language->get('entry_image');
      $data['title_image']               = $this->language->get('title_image');
      $data['entry_description']         = $this->language->get('entry_description');
      $data['text_operator_description'] = $this->language->get('text_operator_description');
      
      $data['button_save']   = $this->language->get('button_save');
      $data['button_cancel'] = $this->language->get('button_cancel');
      
      if (isset($this->error['warning'])) {
         $data['error_warning'] = $this->error['warning'];
      } else {
         $data['error_warning'] = '';
      }
      
      if (isset($this->error['user'])) {
         $data['error_user'] = $this->error['user'];
      } else {
         $data['error_user'] = '';
      }
      
      if (isset($this->error['name'])) {
         $data['error_name'] = $this->error['name'];
      } else {
         $data['error_name'] = '';
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
         'href' => $this->url->link('livehelp/livehelp_user', 'token=' . $this->session->data['token'] . $url, 'SSL')
      );
      
      if (!isset($this->request->get['operator_id'])) {
         $data['action'] = $this->url->link('livehelp/livehelp_user/add', 'token=' . $this->session->data['token'] . $url, 'SSL');
      } else {
         $data['action'] = $this->url->link('livehelp/livehelp_user/edit', 'token=' . $this->session->data['token'] . '&operator_id=' . $this->request->get['operator_id'] . $url, 'SSL');
      }
      
      $data['cancel'] = $this->url->link('livehelp/livehelp_user', 'token=' . $this->session->data['token'] . $url, 'SSL');
      
      if (isset($this->request->get['operator_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
         $operator_info = $this->model_livehelp_livehelp_user->getOperator($this->request->get['operator_id']);
      }
      
      if (isset($this->request->post['user_id'])) {
         $data['user_id'] = $this->request->post['user_id'];
      } elseif (!empty($operator_info)) {
         $data['user_id'] = $operator_info['user_id'];
      } else {
         $data['user_id'] = '';
      }
      
      if (isset($this->request->post['name'])) {
         $data['name'] = $this->request->post['name'];
      } elseif (!empty($operator_info)) {
         $data['name'] = $operator_info['name'];
      } else {
         $data['name'] = '';
      }
      
      if (isset($this->request->post['status'])) {
         $data['status'] = $this->request->post['status'];
      } elseif (!empty($operator_info)) {
         $data['status'] = $operator_info['status'];
      } else {
         $data['status'] = '';
      }
      
      if (isset($this->request->post['description'])) {
         $data['description'] = $this->request->post['description'];
      } elseif (!empty($operator_info)) {
         $data['description'] = $operator_info['description'];
      } else {
         $data['description'] = '';
      }
      
      // Avatar image
      if (isset($this->request->post['image'])) {
         $data['image'] = $this->request->post['image'];
      } elseif (!empty($operator_info)) {
         $data['image'] = $operator_info['image'];
      } else {
         $data['image'] = '';
      }

      $this->load->model('tool/image');

      if (isset($this->request->post['image']) && is_file(DIR_IMAGE . $this->request->post['image'])) {
         $data['thumb'] = $this->model_tool_image->resize($this->request->post['image'], 100, 100);
      } elseif (!empty($operator_info) && is_file(DIR_IMAGE . $operator_info['image'])) {
         $data['thumb'] = $this->model_tool_image->resize($operator_info['image'], 100, 100);
      } else {
         $data['thumb'] = $this->model_tool_image->resize('no_image.png', 100, 100);
      }

      $data['placeholder'] = $this->model_tool_image->resize('no_image.png', 100, 100);


      // Users
      $this->load->model('user/user');
      $data['users'] = $this->model_user_user->getUsers();
      
      $data['header'] = $this->load->controller('common/header');
      $data['column_left'] = $this->load->controller('common/column_left');
      $data['footer'] = $this->load->controller('common/footer');

      $this->response->setOutput($this->load->view('livehelp/livehelp_user_form.tpl', $data));
   }
   
   /*
   VALIDATION
   */
   protected function validateModify() {
      if (!$this->user->hasPermission('modify', 'livehelp/livehelp_user')) {
         $this->error['warning'] = $this->language->get('error_permission');
      }
      
      return !$this->error;
   }
   
   protected function validateForm() {
      $this->validateModify();
      
      if (isset($this->request->get['operator_id'])) {
         $operator_id = $this->request->get['operator_id'];
      } else {
         $operator_id = 0;
      }
      
      if (empty($this->request->post['user_id'])) {
         $this->error['user'] = $this->language->get('error_user');
      } else {
         $user_match = $this->model_livehelp_livehelp_user->getOperatorByUserId($this->request->post['user_id'], $operator_id);
         
         if ($user_match) {
            $this->error['user'] = $this->language->get('error_user_exists');
         }
      }
      
      if ((utf8_strlen($this->request->post['name']) < 3) || (utf8_strlen($this->request->post['name']) > 64)) {
         $this->error['name'] = $this->language->get('error_name');
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