<?php
class ControllerAccountOrderdetail extends Controller {
   
	public function index() {
		if (!$this->customer->isLogged()) {
			$this->session->data['redirect'] = $this->url->link('account/order', '', true);

			$this->response->redirect($this->url->link('account/login', '', true));
		}
		$this->document->addStyle('catalog/view/stylesheet/orderdetails.css');
        $this->load->model('account/orderdetail');
		 if(!empty($this->request->get['order_id'])){			 
			 $result = $this->model_account_orderdetail->getorderdetail($this->request->get['order_id']);
			 $data['result'] = $result;
			 $history = $this->model_account_orderdetail->getOrderHistories($this->request->get['order_id']);
		     $data['history'] = $history;
			 $histor = $this->model_account_orderdetail->getOrderHistorie($this->request->get['order_id']);
             $arr=array();
			 foreach($histor as $k=>$v){
				 if($k==0){
					 continue;
				 }
			    $arr[$k]=$v; 
			 }
			$data['arr']=$arr;
			$order_infor = $this->model_account_orderdetail->getOrder($this->request->get['order_id']);
			$format = 'name:'."&nbsp".'{firstname} {lastname}' . "\n" .'shipping_telephone:'."&nbsp". '{shipping_telephone}'. "\n" .'company:'."&nbsp". '{company}' . "\n" . 'Street_1:'."&nbsp".'{address_1}' . "\n" .'Street_2:'."&nbsp". '{address_2}' . "\n" .'city:'."&nbsp". '{city} '."\n" . 'postcode:'."&nbsp". '{postcode}'. "\n" . 'zone:'."&nbsp".'{zone}' . "\n" .'country:'."&nbsp". '{country}';
			$find = array(
				'{firstname}',
				'{lastname}',
			    '{shipping_telephone}',
				'{company}',
				'{address_1}',
				'{address_2}',
				'{city}',
				'{postcode}',
				'{zone}',
				'{zone_code}',
				'{country}'
			);
            foreach($order_infor as $order_infor ){
			$replace = array(
				'firstname' => $order_infor['shipping_firstname'],
				'lastname'  => $order_infor['shipping_lastname'],
			    'shipping_telephone'  => $order_infor['shipping_telephone'],
				'company'   => ' ',
				'address_1' => $order_infor['shipping_address_1'],
				'address_2' => $order_infor['shipping_address_2'],
				'city'      => $order_infor['shipping_city'],
				'postcode'  => $order_infor['shipping_postcode'],
				'zone'      => $order_infor['shipping_zone'],
				'zone_code' => ' ',
				'country'   => $order_infor['shipping_country']
			);
			}

			$data['shipping_address'] = str_replace(array("\r\n", "\r", "\n"), '<br />', preg_replace(array("/\s\s+/", "/\r\r+/", "/\n\n+/"), '<br />', trim(str_replace($find, $replace, $format))));

		 }

	    $this->document->setTitle($this->config->get('config_meta_title'));
		$this->document->setDescription($this->config->get('config_meta_description'));
		$this->document->setKeywords($this->config->get('config_meta_keyword'));
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');
		$this->response->setOutput($this->load->view('account/orderdetails', $data));
	}

}
