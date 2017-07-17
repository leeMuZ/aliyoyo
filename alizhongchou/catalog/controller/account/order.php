<?php
class ControllerAccountorder extends Controller {
   
	public function index() {
		if (!$this->customer->isLogged()) {
			$this->session->data['redirect'] = $this->url->link('account/order', '', true);

			$this->response->redirect($this->url->link('account/login', '', true));
		}
		$this->document->addStyle('catalog/view/stylesheet/orderlist.css');
		$this->load->model('account/order');
		 if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}
		 $filter_data = array(
			'start' => ($page - 1) * 6,
			'limit' => $this->config->get('config_limit_admin')
		);
		$result = $this->model_account_order->getorder($filter_data);

		$data['result']=$result;
		$order_total = $this->model_account_order->getTotalOrders();
        $pagination = new Pagination();
		$pagination->total = $order_total;
		$pagination->page = $page;
		$pagination->limit = 6;
		$pagination->url = $this->url->link('account/order', 'page={page}', true);
		$data['pagination'] = $pagination->render();
		$data['url']= $this->url->link('account/applyforrefund', true);
		$data['href']= $this->url->link('account/order/info');
        $data['src']= $this->url->link('account/orderdetail');
	    $this->document->setTitle($this->config->get('config_meta_title'));
		$this->document->setDescription($this->config->get('config_meta_description'));
		$this->document->setKeywords($this->config->get('config_meta_keyword'));
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');
		$this->response->setOutput($this->load->view('account/order', $data));
	}
	public function info() {
		$this->load->model('account/order');
		if (isset($this->request->get['oid'])) {
		$order_total = $this->model_account_order->deleorder($this->request->get['oid']); 
		}
       $json['success'] = 1;
	   $this->response->setOutput(json_encode($json));
		  
	}
}
