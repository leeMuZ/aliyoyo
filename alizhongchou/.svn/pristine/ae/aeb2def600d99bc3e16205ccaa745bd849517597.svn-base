<?php
class ControllerLivehelpLivehelpDataWarehouse extends Controller {
   private $error = array();
   private $limit = 200;
   
   public function index() {
      $this->load->language('livehelp/livehelp_data_warehouse');

      $this->load->model('livehelp/livehelp_data_warehouse');
      
      $this->document->setTitle($this->language->get('heading_title'));

      $this->getList();
   }
   
   public function delete() {
      $this->load->language('livehelp/livehelp_data_warehouse');
      
      $this->document->setTitle($this->language->get('heading_title'));
      
      $this->load->model('livehelp/livehelp_data_warehouse');
      
      if (isset($this->request->post['selected']) && $this->validateModify()) {
         foreach ($this->request->post['selected'] as $row_id) {
            $this->model_livehelp_livehelp_data_warehouse->deleteRow($row_id);
         }
         
         $this->session->data['success'] = $this->language->get('text_success');
         
         $this->response->redirect($this->url->link('livehelp/livehelp_data_warehouse', 'token=' . $this->session->data['token'], 'SSL'));
      }
      
      $this->getList();
   }
   
   protected function getList() {
      if (isset($this->request->get['filter_thread_id'])) {
         $filter_thread_id = $this->request->get['filter_thread_id'];
      } else {
         $filter_thread_id = null;
      }
      
      if (isset($this->request->get['filter_customer_name'])) {
         $filter_customer_name = $this->request->get['filter_customer_name'];
      } else {
         $filter_customer_name = null;
      }
      
      if (isset($this->request->get['filter_operator_name'])) {
         $filter_operator_name = $this->request->get['filter_operator_name'];
      } else {
         $filter_operator_name = null;
      }
      
      if (isset($this->request->get['filter_message'])) {
         $filter_message = $this->request->get['filter_message'];
      } else {
         $filter_message = null;
      }
      
      if (isset($this->request->get['sort'])) {
         $sort = $this->request->get['sort'];
      } else {
         $sort = 'thread_id';
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
      
      $this->document->addStyle('view/stylesheet/livehelp.css');
      
      $url = $this->getUrl(array(
         "filter_thread_id",
         "filter_customer_name",
         "filter_operator_name",
         "filter_message",
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
         'href' => $this->url->link('livehelp/livehelp_data_warehouse', 'token=' . $this->session->data['token'] . $url, 'SSL')
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
      
      $data['text_fulltext_help'] = $this->language->get('text_fulltext_help');
      $data['text_special_char']  = $this->language->get('text_special_char');
      $data['text_description']   = $this->language->get('text_description');
      $data['text_sample']        = $this->language->get('text_sample');
      $data['text_list']          = $this->language->get('text_list');
      $data['text_confirm']       = $this->language->get('text_confirm');

      $data['text_char_plus_description']            = $this->language->get('text_char_plus_description');
      $data['text_char_minus_description']           = $this->language->get('text_char_minus_description');
      $data['text_char_bracket_description']         = $this->language->get('text_char_bracket_description');
      $data['text_char_swung_dash_description']      = $this->language->get('text_char_swung_dash_description');
      $data['text_char_star_description']            = $this->language->get('text_char_star_description');
      $data['text_char_quotes_description']          = $this->language->get('text_char_quotes_description');
      $data['text_char_less_great_than_description'] = $this->language->get('text_char_less_great_than_description');
      
      $data['column_thread_id']     = $this->language->get('column_thread_id');
      $data['column_customer_name'] = $this->language->get('column_customer_name');
      $data['column_operator_name'] = $this->language->get('column_operator_name');
      $data['column_message']       = $this->language->get('column_message');
      $data['column_action']        = $this->language->get('column_action');
      
      $data['button_delete'] = $this->language->get('button_delete');
      $data['button_filter'] = $this->language->get('button_filter');
      
      $data['delete'] = $this->url->link('livehelp/livehelp_data_warehouse' . "/delete", 'token=' . $this->session->data['token'] . $url);
      
      $data['token'] = $this->session->data['token'];
      
      $filter_data = array(
         'filter_thread_id' => $filter_thread_id,
         'filter_customer_name' => $filter_customer_name,
         'filter_operator_name' => $filter_operator_name,
         'filter_message' => $filter_message,
         'sort' => $sort,
         'order' => $order,
         'start' => ($page - 1) * $this->limit,
         'page' => $page,
         'limit' => $this->limit
      );
      
      $data['rows'] = array();
      
      $result_total = $this->model_livehelp_livehelp_data_warehouse->getTotalRows($filter_data);
      
      $results = $this->model_livehelp_livehelp_data_warehouse->getRows($filter_data);
      
      $thread_id_counter = 0;
      $thread_id         = 0;
      
      $initiator = array(
         1 => "received",
         2 => "sent",
         3 => "bot-generated"
      );
      
      foreach ($results as $result) {
         if ($thread_id != $result['thread_id']) {
            $thread_id = $result['thread_id'];
            $thread_id_counter++;
         }
         
         $message = '<div class="popup-messages"><div class="msg msg-' . $initiator[$result['initiator']] . '"><div class="msg-head"> <span class="msg-date">' . date($this->language->get('date_format_long'), strtotime($result['date_message_added'])) . '</span> </div> <div class="msg-body">' . $result['message'] . '</div></div></div>';
         
         $data['rows'][] = array(
            'row_id' => $result['row_id'],
            'thread_id' => $result['thread_id'],
            'customer_name' => $result['customer_name'],
            'operator_name' => $result['operator_name'],
            'message' => $message,
            'action' => array(),
            'selected' => isset($this->request->post['selected']) && in_array($result['row_id'], $this->request->post['selected']),
            'tr_class' => ($thread_id_counter % 2 ? 'active' : '')
         );
      }
      
      $url = $this->getUrl(array(
         "filter_thread_id",
         "filter_customer_name",
         "filter_operator_name",
         "filter_message",
         "sort",
         "order"
      ));
      
      $pagination        = new Pagination();
      $pagination->total = $result_total;
      $pagination->page  = $page;
      $pagination->limit = $this->limit;
      $pagination->text  = $this->language->get('text_pagination');
      $pagination->url   = $this->url->link('livehelp/livehelp_data_warehouse', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');
      
      $data['pagination'] = $pagination->render();
      
      $data['results'] = sprintf($this->language->get('text_pagination'), ($result_total) ? (($page - 1) * $this->config->get('config_limit_admin')) + 1 : 0, ((($page - 1) * $this->config->get('config_limit_admin')) > ($result_total - $this->config->get('config_limit_admin'))) ? $result_total : ((($page - 1) * $this->config->get('config_limit_admin')) + $this->config->get('config_limit_admin')), $result_total, ceil($result_total / $this->config->get('config_limit_admin')));
     
      $url = $this->getUrl(array(
         "filter_thread_id",
         "filter_customer_name",
         "filter_operator_name",
         "filter_message",
         "page"
      ));
      
      if ($order == 'ASC') {
         $url .= '&order=DESC';
      } else {
         $url .= '&order=ASC';
      }
      
      $data['sort_thread_id']     = $this->url->link('livehelp/livehelp_data_warehouse', 'token=' . $this->session->data['token'] . '&sort=thread_id' . $url, 'SSL');
      $data['sort_customer_name'] = $this->url->link('livehelp/livehelp_data_warehouse', 'token=' . $this->session->data['token'] . '&sort=customer_name' . $url, 'SSL');
      $data['sort_operator_name'] = $this->url->link('livehelp/livehelp_data_warehouse', 'token=' . $this->session->data['token'] . '&sort=operator_name' . $url, 'SSL');
      
      $data['filter_thread_id']     = $filter_thread_id;
      $data['filter_customer_name'] = $filter_customer_name;
      $data['filter_operator_name'] = $filter_operator_name;
      $data['filter_message']       = $filter_message;
      $data['sort']                 = $sort;
      $data['order']                = $order;
      
      $data['threads'] = $this->model_livehelp_livehelp_data_warehouse->getThreads();

      $data['header'] = $this->load->controller('common/header');
      $data['column_left'] = $this->load->controller('common/column_left');
      $data['footer'] = $this->load->controller('common/footer');

      $this->response->setOutput($this->load->view('livehelp/livehelp_data_warehouse.tpl', $data));
   }
   
   /*
   VALIDATION
   */
   protected function validateModify() {
      if (!$this->user->hasPermission('modify', 'livehelp/livehelp_data_warehouse')) {
         $this->error['warning'] = $this->language->get('error_permission');
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