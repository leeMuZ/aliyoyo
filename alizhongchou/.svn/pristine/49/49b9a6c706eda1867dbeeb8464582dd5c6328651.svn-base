<?php
class ControllerLivehelpLivehelpBan extends Controller {
   private $error = array();
   
   public function index() {
      $this->load->language('livehelp/livehelp_ban');

      $this->load->model('livehelp/livehelp_ban');
      
      $this->document->setTitle($this->language->get('heading_title'));

      $this->getList();
   }
   
   public function add() {
      $this->load->language('livehelp/livehelp_ban');
      
      $this->document->setTitle($this->language->get('heading_title'));
      
      $this->load->model('livehelp/livehelp_ban');
      
      if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
         $this->model_livehelp_livehelp_ban->addBan($this->request->post);
         
         $this->session->data['success'] = $this->language->get('text_success');
         
         $url = $this->getUrl(array(
            "filter_date_added",
            "filter_date_expired",
            "sort",
            "order",
            "page"
         ));
         
         $this->response->redirect($this->url->link('livehelp/livehelp_ban', 'token=' . $this->session->data['token'] . $url, 'SSL'));
      }
      
      $this->getForm();
   }
   
   public function edit() {
      $this->load->language('livehelp/livehelp_ban');
      
      $this->document->setTitle($this->language->get('heading_title'));
      
      $this->load->model('livehelp/livehelp_ban');
      
      if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
         $this->model_livehelp_livehelp_ban->editBan($this->request->get['ban_id'], $this->request->post);
         
         $this->session->data['success'] = $this->language->get('text_success');
         
         $url = $this->getUrl(array(
            "filter_date_added",
            "filter_date_expired",
            "sort",
            "order",
            "page"
         ));
         
         $this->response->redirect($this->url->link('livehelp/livehelp_ban', 'token=' . $this->session->data['token'] . $url, 'SSL'));
      }
      
      $this->getForm();
   }
   
   public function delete() {
      $this->load->language('livehelp/livehelp_ban');
      
      $this->document->setTitle($this->language->get('heading_title'));
      
      $this->load->model('livehelp/livehelp_ban');
      
      if (isset($this->request->post['selected']) && $this->validateModify()) {
         
         foreach ($this->request->post['selected'] as $ban_id) {
            $this->model_livehelp_livehelp_ban->deleteBan($ban_id);
         }
         
         $this->session->data['success'] = $this->language->get('text_success');
         
         $url = $this->getUrl(array(
            "filter_date_added",
            "filter_date_expired",
            "sort",
            "order",
            "page"
         ));
         
         $this->response->redirect($this->url->link('livehelp/livehelp_ban', 'token=' . $this->session->data['token'] . $url, 'SSL'));
      }
      
      $this->getList();
   }
   
   protected function getList() {
      if (isset($this->request->get['filter_date_expired'])) {
         $filter_date_expired = $this->request->get['filter_date_expired'];
      } else {
         $filter_date_expired = null;
      }
      
      if (isset($this->request->get['filter_date_added'])) {
         $filter_date_added = $this->request->get['filter_date_added'];
      } else {
         $filter_date_added = null;
      }
      
      if (isset($this->request->get['sort'])) {
         $sort = $this->request->get['sort'];
      } else {
         $sort = 'user_name';
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
         'href' => $this->url->link('livehelp/livehelp_ban', 'token=' . $this->session->data['token'] . $url, 'SSL')
      );
      
      $data['heading_title'] = $this->language->get('heading_title');
      
      $data['column_user_name']    = $this->language->get('column_user_name');
      $data['column_date_added']   = $this->language->get('column_date_added');
      $data['column_date_expired'] = $this->language->get('column_date_expired');
      $data['column_ip']           = $this->language->get('column_ip');
      $data['column_action']       = $this->language->get('column_action');
      $data['text_list']           = $this->language->get('text_list');

      $data['text_forever']    = $this->language->get('text_forever');
      $data['text_no_results'] = $this->language->get('text_no_results');
      $data['text_confirm']    = $this->language->get('text_confirm');

      $data['button_add'] = $this->language->get('button_add');
      $data['button_delete'] = $this->language->get('button_delete');
      $data['button_filter'] = $this->language->get('button_filter');
      
      $data['add'] = $this->url->link('livehelp/livehelp_ban' . '/add', 'token=' . $this->session->data['token'] . $url, 'SSL');
      $data['delete'] = $this->url->link('livehelp/livehelp_ban' . '/delete', 'token=' . $this->session->data['token'] . $url, 'SSL');
      
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
         'filter_date_added' => $filter_date_added,
         'filter_date_expired' => $filter_date_expired,
         'sort' => $sort,
         'order' => $order,
         'start' => ($page - 1) * $this->config->get('config_admin_limit'),
         'limit' => $this->config->get('config_admin_limit')
      );
      
      $data['banned_users'] = array();
      
      $result_total = $this->model_livehelp_livehelp_ban->getTotalBans($filter_data);
      
      $results = $this->model_livehelp_livehelp_ban->getBans($filter_data);
      
      foreach ($results as $result) {
         $action = array();
         
         $action[] = array(
            'text' => $this->language->get('text_edit'),
            'href' => $this->url->link('livehelp/livehelp_ban' . '/edit', 'token=' . $this->session->data['token'] . '&ban_id=' . $result['ban_id'] . $url, 'SSL')
         );
         
         $data['banned_users'][] = array(
            'ban_id' => $result['ban_id'],
            'user_name' => $result['user_name'],
            'date_added' => date($this->language->get('date_format_short'), $result['date_added']),
            'date_expired' => ($result['date_expired'] > 0 ? date($this->language->get('date_format_short'), $result['date_expired']) : $this->language->get('text_forever')),
            'ip' => $result['ip'],
            'selected' => isset($this->request->post['selected']) && in_array($result['ban_id'], $this->request->post['selected']),
            'action' => $action
         );
      }
      
      $url = $this->getUrl(array(
         "filter_date_added",
         "filter_date_expired",
         "page"
      ));
      
      if ($order == 'ASC') {
         $url .= '&order=DESC';
      } else {
         $url .= '&order=ASC';
      }
      
      $data['sort_user_name']    = $this->url->link('livehelp/livehelp_ban', 'token=' . $this->session->data['token'] . '&sort=user_name' . $url, 'SSL');
      $data['sort_date_added']   = $this->url->link('livehelp/livehelp_ban', 'token=' . $this->session->data['token'] . '&sort=date_added' . $url, 'SSL');
      $data['sort_date_expired'] = $this->url->link('livehelp/livehelp_ban', 'token=' . $this->session->data['token'] . '&sort=date_expired' . $url, 'SSL');
      $data['sort_ip']           = $this->url->link('livehelp/livehelp_ban', 'token=' . $this->session->data['token'] . '&sort=ip' . $url, 'SSL');
      
      $url = $this->getUrl(array(
         "filter_date_added",
         "filter_date_expired",
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

      $data['filter_date_added']   = $filter_date_added;
      $data['filter_date_expired'] = $filter_date_expired;
      
      $data['sort']  = $sort;
      $data['order'] = $order;
      
      $data['token'] = $this->session->data['token'];
      
      $data['header'] = $this->load->controller('common/header');
      $data['column_left'] = $this->load->controller('common/column_left');
      $data['footer'] = $this->load->controller('common/footer');

      $this->response->setOutput($this->load->view('livehelp/livehelp_ban_list.tpl', $data));
   }
   
   protected function getForm() {
      $data['heading_title'] = $this->language->get('heading_title');
      
      $data['text_enabled']  = $this->language->get('text_enabled');
      $data['text_disabled'] = $this->language->get('text_disabled');
      $data['text_yes']      = $this->language->get('text_yes');
      $data['text_no']       = $this->language->get('text_no');
      $data['text_select']   = $this->language->get('text_select');
      $data['text_form']     = $this->language->get('text_form');

      $data['entry_user_name'] = $this->language->get('entry_user_name');
      $data['entry_comment']   = $this->language->get('entry_comment');
      $data['entry_expired']   = $this->language->get('entry_expired');
      $data['entry_ip']        = $this->language->get('entry_ip');
      
      $data['title_expired'] = $this->language->get('title_expired');
      
      $data['button_save']   = $this->language->get('button_save');
      $data['button_cancel'] = $this->language->get('button_cancel');
      
      if (isset($this->error['warning'])) {
         $data['error_warning'] = $this->error['warning'];
      } else {
         $data['error_warning'] = '';
      }
      
      if (isset($this->error['user_name'])) {
         $data['error_user_name'] = $this->error['user_name'];
      } else {
         $data['error_user_name'] = '';
      }
      
      if (isset($this->error['ip'])) {
         $data['error_ip'] = $this->error['ip'];
      } else {
         $data['error_ip'] = '';
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
         'href' => $this->url->link('livehelp/livehelp_ban', 'token=' . $this->session->data['token'] . $url, 'SSL')
      );
      
      if (!isset($this->request->get['ban_id'])) {
         $data['action'] = $this->url->link('livehelp/livehelp_ban/add', 'token=' . $this->session->data['token'], 'SSL');
      } else {
         $data['action'] = $this->url->link('livehelp/livehelp_ban/edit', 'token=' . $this->session->data['token'] . '&ban_id=' . $this->request->get['ban_id'], 'SSL');
      }
      
      $data['cancel'] = $this->url->link('livehelp/livehelp_ban', 'token=' . $this->session->data['token'] . $url, 'SSL');
      
      if (isset($this->request->get['ban_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
         $ban_info = $this->model_livehelp_livehelp_ban->getBan($this->request->get['ban_id']);
      }
      
      if (isset($this->request->post['user_name'])) {
         $data['user_name'] = $this->request->post['user_name'];
      } elseif (!empty($ban_info)) {
         $data['user_name'] = $ban_info['user_name'];
      } else {
         $data['user_name'] = '';
      }
      
      if (isset($this->request->post['comment'])) {
         $data['comment'] = $this->request->post['comment'];
      } elseif (!empty($ban_info)) {
         $data['comment'] = $ban_info['comment'];
      } else {
         $data['comment'] = '';
      }
      
      if (isset($this->request->post['date_expired'])) {
         $data['date_expired'] = $this->request->post['date_expired'];
      } elseif (!empty($ban_info)) {
         $data['date_expired'] = ($ban_info['date_expired'] != -1 ? date("Y-m-d H:i:s", $ban_info['date_expired']) : "");
      } else {
         $data['date_expired'] = '';
      }
      
      if (isset($this->request->post['ip'])) {
         $data['ip'] = $this->request->post['ip'];
      } elseif (!empty($ban_info)) {
         $data['ip'] = $ban_info['ip'];
      } else {
         $data['ip'] = '';
      }
      
      $data['header'] = $this->load->controller('common/header');
      $data['column_left'] = $this->load->controller('common/column_left');
      $data['footer'] = $this->load->controller('common/footer');

      $this->response->setOutput($this->load->view('livehelp/livehelp_ban_form.tpl', $data));
   }
   
   /*
   VALIDATION
   */
   protected function validateModify() {
      if (!$this->user->hasPermission('modify', 'livehelp/livehelp_ban')) {
         $this->error['warning'] = $this->language->get('error_permission');
      }
      
      return !$this->error;
   }
   
   protected function validateForm() {
      $this->validateModify();
      
      if ((utf8_strlen($this->request->post['user_name']) < 3) || (utf8_strlen($this->request->post['user_name']) > 40)) {
         $this->error['user_name'] = $this->language->get('error_user_name');
      }
      
      if ((utf8_strlen($this->request->post['ip']) < 3) || (utf8_strlen($this->request->post['ip']) > 128)) {
         $this->error['ip'] = $this->language->get('error_ip');
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