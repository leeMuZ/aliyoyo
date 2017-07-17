<?php
class ControllerAccountAdress extends Controller {
	private $error = array();

	public function index() {
		if (!$this->customer->isLogged()) {
			$this->session->data['redirect'] = $this->url->link('account/adress', '', true);
			if($this->request->server['REQUEST_METHOD'] == 'POST'&&!empty($this->request->files['file']['name']['photo'])){
				$json['code']=2;
				$json['data']='account/login';
				echo json_encode($json);
				return;
			}
			$this->response->redirect($this->url->link('account/login', '', true));
		}

		if (isset($this->session->data['success'])) {
		    $data['success'] = $this->session->data['success'];
		
		    unset($this->session->data['success']);
		} else {
		    $data['success'] = '';
		}

		$this->load->model('account/customer');
		$result=$this->model_account_customer->getaddress();
		$data['result']=$result;
		$this->load->language('account/edit');
		if ($this->request->server['REQUEST_METHOD'] == 'POST' && $this->validate()) {
            $this->model_account_customer->carteadress($this->request->post);
			$this->response->redirect($this->url->link('account/newedit#shipping'));
			return;
		}

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}
		//add by liuxuewen  at 2017713

		
		if (isset($this->error['firstname'])) {
			$data['error_firstname'] = $this->error['firstname'];
		} else {
			$data['error_firstname'] = '';
		}

		if (isset($this->error['lastname'])) {
			$data['error_lastname'] = $this->error['lastname'];
		} else {
			$data['error_lastname'] = '';
		}


		if (isset($this->error['telephone'])) {
			$data['error_telephone'] = $this->error['telephone'];
		} else {
			$data['error_telephone'] = '';
		}
		if (isset($this->error['city'])) {
			$data['error_city'] = $this->error['city'];
		} else {
			$data['error_city'] = '';
		}
		if (isset($this->error['postcode'])) {
			$data['error_postcode'] = $this->error['postcode'];
		} else {
			$data['error_postcode'] = '';
		}
		if (isset($this->error['custom_field'])) {
			$data['error_custom_field'] = $this->error['custom_field'];
		} else {
			$data['error_custom_field'] = array();
		}

		if ($this->request->server['REQUEST_METHOD'] != 'POST') {
			$customer_info = $this->model_account_customer->getCustomer($this->customer->getId());

		}
		
		// add by liuxuewen 20170712
		if (isset($this->request->post['company'])) {
		    $data['company'] = $this->request->post['company'];
		} else {
		    $data['company'] = '';
		}
		
		if (isset($this->request->post['address_1'])) {
		    $data['address_1'] = $this->request->post['address_1'];
		} else {
		    $data['address_1'] = '';
		}
		
		if (isset($this->request->post['address_2'])) {
		    $data['address_2'] = $this->request->post['address_2'];
		} else {
		    $data['address_2'] = '';
		}
		
		if (isset($this->request->post['firstname'])) {
			$data['firstname'] = $this->request->post['firstname'];
		} else {
			$data['firstname'] = '';
		}

		if (isset($this->request->post['lastname'])) {
			$data['lastname'] = $this->request->post['lastname'];
		}else {
			$data['lastname'] = '';
		}

		if (isset($this->request->post['city'])) {
			$data['city'] = $this->request->post['city'];
		} else {
			$data['city'] = '';
		}

		if (isset($this->request->post['telephone'])) {
			$data['telephone'] = $this->request->post['telephone'];
		}else {
			$data['telephone'] = '';
		}

		if (isset($this->request->post['postcode'])) {
			$data['postcode'] = $this->request->post['postcode'];
		}else {
			$data['postcode'] = '';
		}


        $data['update'] = $this->url->link('account/adress/edit');
        $data['aurl'] = $this->url->link('account/adress', '', true);
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');
		$this->response->setOutput($this->load->view('account/adress', $data));
	}
		public function add() {
		if (!$this->customer->isLogged()) {
			$this->session->data['redirect'] = $this->url->link('account/adress', '', true);
			if($this->request->server['REQUEST_METHOD'] == 'POST'&&!empty($this->request->files['file']['name']['photo'])){
				$json['code']=2;
				$json['data']='account/login';
				echo json_encode($json);
				return;
			}
			$this->response->redirect($this->url->link('account/login', '', true));
		}

		if (isset($this->session->data['success'])) {
		    $data['success'] = $this->session->data['success'];
		
		    unset($this->session->data['success']);
		} else {
		    $data['success'] = '';
		}

		$this->load->model('account/customer');
		$result=$this->model_account_customer->getaddress();
		$data['result']=$result;
		$this->load->language('account/edit');
		if ($this->request->server['REQUEST_METHOD'] == 'POST' && $this->validate()) {
            $this->model_account_customer->carteadress($this->request->post);
			$this->response->redirect($this->url->link('account/newedit#shipping'));
			return;
		}

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}
		//add by liuxuewen  at 2017713

		
		if (isset($this->error['firstname'])) {
			$data['error_firstname'] = $this->error['firstname'];
		} else {
			$data['error_firstname'] = '';
		}

		if (isset($this->error['lastname'])) {
			$data['error_lastname'] = $this->error['lastname'];
		} else {
			$data['error_lastname'] = '';
		}


		if (isset($this->error['telephone'])) {
			$data['error_telephone'] = $this->error['telephone'];
		} else {
			$data['error_telephone'] = '';
		}
		if (isset($this->error['city'])) {
			$data['error_city'] = $this->error['city'];
		} else {
			$data['error_city'] = '';
		}
		if (isset($this->error['postcode'])) {
			$data['error_postcode'] = $this->error['postcode'];
		} else {
			$data['error_postcode'] = '';
		}
		if (isset($this->error['custom_field'])) {
			$data['error_custom_field'] = $this->error['custom_field'];
		} else {
			$data['error_custom_field'] = array();
		}

		if ($this->request->server['REQUEST_METHOD'] != 'POST') {
			$customer_info = $this->model_account_customer->getCustomer($this->customer->getId());

		}
		
		// add by liuxuewen 20170712
		if (isset($this->request->post['company'])) {
		    $data['company'] = $this->request->post['company'];
		} else {
		    $data['company'] = '';
		}
		
		if (isset($this->request->post['address_1'])) {
		    $data['address_1'] = $this->request->post['address_1'];
		} else {
		    $data['address_1'] = '';
		}
		
		if (isset($this->request->post['address_2'])) {
		    $data['address_2'] = $this->request->post['address_2'];
		} else {
		    $data['address_2'] = '';
		}
		
		if (isset($this->request->post['firstname'])) {
			$data['firstname'] = $this->request->post['firstname'];
		} else {
			$data['firstname'] = '';
		}

		if (isset($this->request->post['lastname'])) {
			$data['lastname'] = $this->request->post['lastname'];
		}else {
			$data['lastname'] = '';
		}

		if (isset($this->request->post['city'])) {
			$data['city'] = $this->request->post['city'];
		} else {
			$data['city'] = '';
		}

		if (isset($this->request->post['telephone'])) {
			$data['telephone'] = $this->request->post['telephone'];
		}else {
			$data['telephone'] = '';
		}

		if (isset($this->request->post['postcode'])) {
			$data['postcode'] = $this->request->post['postcode'];
		}else {
			$data['postcode'] = '';
		}


        $data['action'] = $this->url->link('account/adress/add', '', true);
        $data['aurl'] = $this->url->link('account/adress', '', true);
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');
		$this->response->setOutput($this->load->view('account/address_form', $data));
	}
	public function edit() {
		if (!$this->customer->isLogged()) {
			$this->session->data['redirect'] = $this->url->link('account/adress', '', true);
			if($this->request->server['REQUEST_METHOD'] == 'POST'&&!empty($this->request->files['file']['name']['photo'])){
				$json['code']=2;
				$json['data']='account/login';
				echo json_encode($json);
				return;
			}
			$this->response->redirect($this->url->link('account/login', '', true));
		}
		$this->load->model('account/customer');
		$this->load->language('account/edit');
		if ($this->request->server['REQUEST_METHOD'] == 'POST' && $this->validate()) {
            $this->model_account_customer->editadress($this->request->post);
			$this->response->redirect($this->url->link('account/newedit#shipping'));
			return;
		}
       
		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}
		//add by liuxuewen  at 2017713

		
		if (isset($this->error['firstname'])) {
			$data['error_firstname'] = $this->error['firstname'];
		} else {
			$data['error_firstname'] = '';
		}

		if (isset($this->error['lastname'])) {
			$data['error_lastname'] = $this->error['lastname'];
		} else {
			$data['error_lastname'] = '';
		}


		if (isset($this->error['telephone'])) {
			$data['error_telephone'] = $this->error['telephone'];
		} else {
			$data['error_telephone'] = '';
		}
		if (isset($this->error['city'])) {
			$data['error_city'] = $this->error['city'];
		} else {
			$data['error_city'] = '';
		}
		if (isset($this->error['postcode'])) {
			$data['error_postcode'] = $this->error['postcode'];
		} else {
			$data['error_postcode'] = '';
		}
		if (isset($this->error['custom_field'])) {
			$data['error_custom_field'] = $this->error['custom_field'];
		} else {
			$data['error_custom_field'] = array();
		}

		if (isset($this->request->get['address_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$address_info = $this->model_account_customer->getoneadress($this->request->get['address_id']);
		}
		
		if (isset($this->request->post['firstname'])) {
			$data['firstname'] = $this->request->post['firstname'];
		} elseif (!empty($address_info)) {
			$data['firstname'] = $address_info['firstname'];
		} else {
			$data['firstname'] = '';
		}

		if (isset($this->request->post['lastname'])) {
			$data['lastname'] = $this->request->post['lastname'];
		} elseif (!empty($address_info)) {
			$data['lastname'] = $address_info['lastname'];
		} else {
			$data['lastname'] = '';
		}
		//modify by yagami at 20160709 
		if (isset($this->request->post['telephone'])) {
		    $data['telephone'] = $this->request->post['telephone'];
		} elseif (!empty($address_info)) {
		    $data['telephone'] = $address_info['telephone'];
		} else {
		    $data['telephone'] = '';
		}
	    if (isset($this->request->post['address_id'])) {
		    $data['address_id'] = $this->request->post['address_id'];
		} elseif (!empty($address_info)) {
		    $data['address_id'] = $address_info['address_id'];
		} else {
		    $data['address_id'] = '';
		}
		if (isset($this->request->post['company'])) {
			$data['company'] = $this->request->post['company'];
		} elseif (!empty($address_info)) {
			$data['company'] = $address_info['company'];
		} else {
			$data['company'] = '';
		}

		if (isset($this->request->post['address_1'])) {
			$data['address_1'] = $this->request->post['address_1'];
		} elseif (!empty($address_info)) {
			$data['address_1'] = $address_info['address_1'];
		} else {
			$data['address_1'] = '';
		}

		if (isset($this->request->post['address_2'])) {
			$data['address_2'] = $this->request->post['address_2'];
		} elseif (!empty($address_info)) {
			$data['address_2'] = $address_info['address_2'];
		} else {
			$data['address_2'] = '';
		}

		if (isset($this->request->post['postcode'])) {
			$data['postcode'] = $this->request->post['postcode'];
		} elseif (!empty($address_info)) {
			$data['postcode'] = $address_info['postcode'];
		} else {
			$data['postcode'] = '';
		}

		if (isset($this->request->post['city'])) {
			$data['city'] = $this->request->post['city'];
		} elseif (!empty($address_info)) {
			$data['city'] = $address_info['city'];
		} else {
			$data['city'] = '';
		}


        $data['action'] = $this->url->link('account/adress/edit', '', true);
        $data['aurl'] = $this->url->link('account/adress', '', true);
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');
		$this->response->setOutput($this->load->view('account/address_form', $data));
	}
	public function deleted() {
		$this->load->model('account/customer');
		if (isset($this->request->get['oid'])) {
		$order_total = $this->model_account_customer->deleteadress($this->request->get['oid']); 
		}
       $json['success'] = 1;
	   $this->response->setOutput(json_encode($json));
		  
	}
	protected function getForm() {

		if (isset($this->error['firstname'])) {
			$data['error_firstname'] = $this->error['firstname'];
		} else {
			$data['error_firstname'] = '';
		}

		if (isset($this->error['lastname'])) {
			$data['error_lastname'] = $this->error['lastname'];
		} else {
			$data['error_lastname'] = '';
		}
		//modify by yagami at 20160709 添加处理电话错误信息
		if (isset($this->error['telephone'])) {
		    $data['error_telephone'] = $this->error['telephone'];
		} else {
		    $data['error_telephone'] = '';
		}

		if (isset($this->error['address_1'])) {
			$data['error_address_1'] = $this->error['address_1'];
		} else {
			$data['error_address_1'] = '';
		}

		if (isset($this->error['city'])) {
			$data['error_city'] = $this->error['city'];
		} else {
			$data['error_city'] = '';
		}

		if (isset($this->error['postcode'])) {
			$data['error_postcode'] = $this->error['postcode'];
		} else {
			$data['error_postcode'] = '';
		}

		if (isset($this->error['country'])) {
			$data['error_country'] = $this->error['country'];
		} else {
			$data['error_country'] = '';
		}

		if (isset($this->error['zone'])) {
			$data['error_zone'] = $this->error['zone'];
		} else {
			$data['error_zone'] = '';
		}

		
		if (!isset($this->request->get['address_id'])) {
			$data['action'] = $this->url->link('account/adress/add', '', true);
		} else {
			$data['action'] = $this->url->link('account/adress/edit','', true);

		}

		if (isset($this->request->get['address_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$address_info = $this->model_account_customer->getoneadress($this->request->get['address_id']);
		}

		if (isset($this->request->post['firstname'])) {
			$data['firstname'] = $this->request->post['firstname'];
		} elseif (!empty($address_info)) {
			$data['firstname'] = $address_info['firstname'];
		} else {
			$data['firstname'] = '';
		}

		if (isset($this->request->post['lastname'])) {
			$data['lastname'] = $this->request->post['lastname'];
		} elseif (!empty($address_info)) {
			$data['lastname'] = $address_info['lastname'];
		} else {
			$data['lastname'] = '';
		}
		//modify by yagami at 20160709 
		if (isset($this->request->post['telephone'])) {
		    $data['telephone'] = $this->request->post['telephone'];
		} elseif (!empty($address_info)) {
		    $data['telephone'] = $address_info['telephone'];
		} else {
		    $data['telephone'] = '';
		}
	    if (isset($this->request->post['address_id'])) {
		    $data['address_id'] = $this->request->post['address_id'];
		} elseif (!empty($address_info)) {
		    $data['address_id'] = $address_info['address_id'];
		} else {
		    $data['address_id'] = '';
		}
		if (isset($this->request->post['company'])) {
			$data['company'] = $this->request->post['company'];
		} elseif (!empty($address_info)) {
			$data['company'] = $address_info['company'];
		} else {
			$data['company'] = '';
		}

		if (isset($this->request->post['address_1'])) {
			$data['address_1'] = $this->request->post['address_1'];
		} elseif (!empty($address_info)) {
			$data['address_1'] = $address_info['address_1'];
		} else {
			$data['address_1'] = '';
		}

		if (isset($this->request->post['address_2'])) {
			$data['address_2'] = $this->request->post['address_2'];
		} elseif (!empty($address_info)) {
			$data['address_2'] = $address_info['address_2'];
		} else {
			$data['address_2'] = '';
		}

		if (isset($this->request->post['postcode'])) {
			$data['postcode'] = $this->request->post['postcode'];
		} elseif (!empty($address_info)) {
			$data['postcode'] = $address_info['postcode'];
		} else {
			$data['postcode'] = '';
		}

		if (isset($this->request->post['city'])) {
			$data['city'] = $this->request->post['city'];
		} elseif (!empty($address_info)) {
			$data['city'] = $address_info['city'];
		} else {
			$data['city'] = '';
		}

		if (isset($this->request->post['country_id'])) {
			$data['country_id'] = (int)$this->request->post['country_id'];
		}  elseif (!empty($address_info)) {
			$data['country_id'] = $address_info['country_id'];
		} else {
			$data['country_id'] = $this->config->get('config_country_id');
		}

		if (isset($this->request->post['zone_id'])) {
			$data['zone_id'] = (int)$this->request->post['zone_id'];
		}  elseif (!empty($address_info)) {
			$data['zone_id'] = $address_info['zone_id'];
		} else {
			$data['zone_id'] = '';
		}

		$this->load->model('localisation/country');

		$data['countries'] = $this->model_localisation_country->getCountries();

		// Custom fields
		$this->load->model('account/custom_field');

		if (isset($this->request->post['default'])) {
			$data['default'] = $this->request->post['default'];
		} elseif (isset($this->request->get['address_id'])) {
			$data['default'] = $this->customer->getAddressId() == $this->request->get['address_id'];
		} else {
			$data['default'] = false;
		}

		$data['back'] = $this->url->link('account/address', '', true);

		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');


		$this->response->setOutput($this->load->view('account/address_form', $data));


	}	


	protected function validate() {

			//add by liuxuewen at 2017713

			if ((utf8_strlen(trim($this->request->post['firstname'])) < 1) || (utf8_strlen(trim($this->request->post['firstname'])) > 32)) {
				$this->error['firstname'] = $this->language->get('error_firstname');
			}
			if ((utf8_strlen(trim($this->request->post['city'])) < 1) || (utf8_strlen(trim($this->request->post['city'])) > 20)) {
				$this->error['city'] = '不能为空';
			}
			if ((utf8_strlen(trim($this->request->post['postcode'])) < 1) || (utf8_strlen(trim($this->request->post['postcode'])) > 20)) {
				$this->error['postcode'] = '不能为空';
			}

			if ((utf8_strlen(trim($this->request->post['lastname'])) < 1) || (utf8_strlen(trim($this->request->post['lastname'])) > 32)) {
				$this->error['lastname'] = $this->language->get('error_lastname');
			}


			if ((utf8_strlen($this->request->post['telephone']) < 3) || (utf8_strlen($this->request->post['telephone']) > 32)) {
				$this->error['telephone'] = $this->language->get('error_telephone');
			}



		return !$this->error;
	}

}