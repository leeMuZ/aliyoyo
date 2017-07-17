<?php
class ControllerAccountNewedit extends Controller {
	private $error = array();

	public function index() {
		if (!$this->customer->isLogged()) {
			$this->session->data['redirect'] = $this->url->link('account/newedit', '', true);
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
		
		$this->load->language('account/edit');
		$this->document->addScript('catalog/view/javascript/jquery/datetimepicker/moment.js');
		$this->document->addScript('catalog/view/javascript/js/profile.js');
		$this->document->addScript('catalog/view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.js');
		$this->document->addStyle('catalog/view/javascript/bootstrap/css/bootstrap.min.css');
		$this->document->addStyle('catalog/view/stylesheet/css/profile.css');
		$this->load->model('account/customer');
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
		    //add by yagami 20160816 reason file upload
		    if(!empty($this->request->files['image']) && is_file($this->request->files['image']['tmp_name'][0])){
		    	$json = array();
		    	if(isset($this->request->files)){
		    		$this->load->model('tool/image');
		    		$json = $this->model_tool_image->upload(['files' => $this->request->files['image'], 'directory' => 'catalog/customer_avatar/','limit_size' =>2097152]);
		    	}
		    	 /*foreach ($json['images'] as $key=>$image){
			        if($this->config->get('amazon_s3_status')){
			    		$json['images'][$key]['url'] = DIR_S3IMAGE . $image['url'];	    		
			    	}else{
			       $json['images'][$key]['url'] = HTTP_CATALOG ."image/". $image['url'];
			    	} 
		    	}*/ 
		    	//var_dump($json['images']);exit;
		    	if(isset($json['images'][0]['success'])){
					$this->model_account_customer->editCustomerImg($json['images'][0]['url']);
					$json['code'] = 1;
					$json['data'] = $this->model_tool_image->profileResize($json['images'][0]['url'],100,100);
		    	}else if(isset($json['images'][0]['error'])){
		    	        $json['code']=0;
		    	        $json['data']=$json['images'][0]['error'];
		    	}
				$this->response->addHeader('Content-Type: application/json');
			    $this->response->setOutput(json_encode($json));
			    return;
		    }else{

				$this->model_account_customer->editCustomer($this->request->post);
			}
			
			// Add to activity log
			$this->load->model('account/activity');
			$this->session->data['success'] = $this->language->get('text_success');
			$activity_data = array(
				'customer_id' => $this->customer->getId(),
				'name'        => $this->customer->getFirstName() . ' ' . $this->customer->getLastName()
			);

			$this->model_account_activity->addActivity('edit', $activity_data);
			$this->response->redirect($this->url->link('account/newedit'));
			return;
		}

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home')
		);

		$data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_account'),
			'href'      => $this->url->link('account/account', '', true)
		);

		$data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_edit'),
			'href'      => $this->url->link('account/edit', '', true)
		);

		$data['heading_title'] = $this->language->get('heading_title');
		$data['text_edit'] = $this->language->get('text_edit');
		$data['text_password'] = $this->language->get('text_password');
		$data['text_address'] = $this->language->get('text_address');
		$data['text_order'] = $this->language->get('text_order');
		$data['text_reward'] = $this->language->get('text_reward');
		$data['text_return'] = $this->language->get('text_return');
		$data['text_your_details'] = $this->language->get('text_your_details');
		$data['text_additional'] = $this->language->get('text_additional');
		$data['text_select'] = $this->language->get('text_select');
		$data['text_loading'] = $this->language->get('text_loading');

		$data['entry_firstname'] = $this->language->get('entry_firstname');
		$data['entry_lastname'] = $this->language->get('entry_lastname');
		//add by yagami at 20160711
		$data['entry_photo'] = $this->language->get('entry_photo');
		$data['entry_changephoto'] = $this->language->get('entry_changephoto');
		$data['entry_nickname'] = $this->language->get('entry_nickname');
		$data['entry_email'] = $this->language->get('entry_email');
		$data['entry_telephone'] = $this->language->get('entry_telephone');
		//$data['entry_fax'] = $this->language->get('entry_fax');
		$data['entry_description'] = $this->language->get('entry_escription');
		$data['entry_save'] = $this->language->get('entry_save');

		$data['button_continue'] = $this->language->get('button_continue');
		$data['button_back'] = $this->language->get('button_back');
		$data['button_upload'] = $this->language->get('button_upload');

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}
		//add by yagami at 20160711
		if (isset($this->error['nickname'])) {
		    $data['error_nickname'] = $this->error['nickname'];
		} else {
		    $data['error_nickname'] = '';
		}
		
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

		if (isset($this->error['email'])) {
			$data['error_email'] = $this->error['email'];
		} else {
			$data['error_email'] = '';
		}

		if (isset($this->error['telephone'])) {
			$data['error_telephone'] = $this->error['telephone'];
		} else {
			$data['error_telephone'] = '';
		}
		if (isset($this->error['description'])) {
			$data['error_description'] = $this->error['description'];
		} else {
			$data['error_description'] = '';
		}

		if (isset($this->error['custom_field'])) {
			$data['error_custom_field'] = $this->error['custom_field'];
		} else {
			$data['error_custom_field'] = array();
		}

		$data['action'] = $this->url->link('account/newedit', '', true);

		if ($this->request->server['REQUEST_METHOD'] != 'POST') {
			$customer_info = $this->model_account_customer->getCustomer($this->customer->getId());

		}
		
		// add by liuxuewen 20170712
		if (isset($this->request->post['avatar'])){
		    $data['photo'] = $this->request->post['avatar'];
		} elseif (!empty($customer_info)) {
		    $this->load->model('tool/image');
		    $data['photo'] = $this->model_tool_image->profileResize($customer_info['image'],100,100);
		} else {
		    $data['photo'] = '';
		}
		// add by liuxuewen 20170712
		if (isset($this->request->post['nickname'])) {
		    $data['nickname'] = $this->request->post['nickname'];
		} elseif (!empty($customer_info)) {
		    $data['nickname'] = $customer_info['nickname'];
		} else {
		    $data['nickname'] = '';
		}
		// add by liuxuewen 20170712
		if (isset($this->request->post['year'])) {
            $data['year']=$this->request->post['year'];
			$data['month']=$this->request->post['month'];
			$data['day']=$this->request->post['day'];
		} elseif (!empty($customer_info['birthday'])) {
		    $birthday=explode('/',$customer_info['birthday']);
            $data['year']=$birthday[0];
			$data['month']=$birthday[1];
			$data['day']=$birthday[2];
		} else {
		    $data['year']=2000;
			$data['month']=4;
			$data['day']=2;
		}
		$this->document->setTitle($this->language->get('heading_title_new').$data['nickname']);
		if (isset($this->request->post['firstname'])) {
			$data['firstname'] = $this->request->post['firstname'];
		} elseif (!empty($customer_info)) {
			$data['firstname'] = $customer_info['firstname'];
		} else {
			$data['firstname'] = '';
		}

		if (isset($this->request->post['lastname'])) {
			$data['lastname'] = $this->request->post['lastname'];
		} elseif (!empty($customer_info)) {
			$data['lastname'] = $customer_info['lastname'];
		} else {
			$data['lastname'] = '';
		}

		if (isset($this->request->post['email'])) {
			$data['email'] = $this->request->post['email'];
		} elseif (!empty($customer_info)) {
			$data['email'] = $customer_info['email'];
		} else {
			$data['email'] = '';
		}

		if (isset($this->request->post['telephone'])) {
			$data['telephone'] = $this->request->post['telephone'];
		} elseif (!empty($customer_info)) {
			$data['telephone'] = $customer_info['telephone'];
		} else {
			$data['telephone'] = '';
		}

		if (isset($this->request->post['description'])) {
			$data['description'] = $this->request->post['description'];
		} elseif (!empty($customer_info)) {
			$data['description'] = $customer_info['description'];
		} else {
			$data['description'] = '';
		}

		// Custom Fields
		$this->load->model('account/custom_field');

		$data['custom_fields'] = $this->model_account_custom_field->getCustomFields($this->config->get('config_customer_group_id'));

		if (isset($this->request->post['custom_field'])) {
			$data['account_custom_field'] = $this->request->post['custom_field'];
		} elseif (isset($customer_info)) {
			//$data['account_custom_field'] = json_decode($customer_info['custom_field'], true);
		} else {
			$data['account_custom_field'] = array();
		}

		$data['back'] = $this->url->link('account/account', '', true);

		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');
		$this->response->setOutput($this->load->view('account/newedit', $data));
	}
	
	public function valsex(){
	$this->load->model('account/customer');
	if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) { 

			//add by yagami 20160816 reason file upload
		    if(!empty($this->request->files['image']) && is_file($this->request->files['image']['tmp_name'][0])){
		    	$json = array();
		    	if(isset($this->request->files)){
		    		$this->load->model('tool/image');
		    		$json = $this->model_tool_image->upload(['files' => $this->request->files['image'], 'directory' => 'catalog/customer_avatar/','limit_size' =>2097152]);
		    	}
		    	if(isset($json['images'][0]['success'])){
                    $image_size   =   getimagesize(HTTP_Aliyoyo.'image/'.$json['images'][0]['url']);
					$this->model_account_customer->editCustomerImgs($json['images'][0]['url']);
					$json['code'] = 1;
		    	    $json['image'] = HTTP_Aliyoyo.'image/'.$json['images'][0]['url'];
				}else if(isset($json['images'][0]['error'])){
		    	        $json['code']=0;
		    	        $json['data']=$json['images'][0]['error'];
		    	}
				$this->response->addHeader('Content-Type: application/json');
			    $this->response->setOutput(json_encode($json));
			    return;
		    }else{
				$this->model_account_customer->editCustomer($this->request->post);
			}
			
			// Add to activity log
			$this->load->model('account/activity');
			$this->session->data['success'] = $this->language->get('text_success');
			$activity_data = array(
				'customer_id' => $this->customer->getId(),
				'name'        => $this->customer->getFirstName() . ' ' . $this->customer->getLastName()
			);

			$this->model_account_activity->addActivity('edit', $activity_data);
			$this->response->redirect($this->url->link('account/newedit'));
			return;
		}
	}

	protected function validate() {
	    //add by yagami at 20160815 reason validate file 
	    if(isset($this->request->files['image']) && is_file($this->request->files['image']['tmp_name'][0])){
	                  return true;
	    }else {
			//add by yagami at 20160711
			if ((utf8_strlen(trim($this->request->post['nickname'])) < 1) || (utf8_strlen(trim($this->request->post['nickname'])) > 17)) {
				$this->error['nickname'] = $this->language->get('error_nickname');
			}
			if ((utf8_strlen(trim($this->request->post['firstname'])) < 1) || (utf8_strlen(trim($this->request->post['firstname'])) > 32)) {
				$this->error['firstname'] = $this->language->get('error_firstname');
			}

			if ((utf8_strlen(trim($this->request->post['lastname'])) < 1) || (utf8_strlen(trim($this->request->post['lastname'])) > 32)) {
				$this->error['lastname'] = $this->language->get('error_lastname');
			}


			if ((utf8_strlen($this->request->post['telephone']) < 3) || (utf8_strlen($this->request->post['telephone']) > 32)) {
				$this->error['telephone'] = $this->language->get('error_telephone');
			}
			if ((utf8_strlen($this->request->post['description']) > 140)) {
				$this->error['description'] = $this->language->get('error_description');
			}
		}
		// Custom field validation
		$this->load->model('account/custom_field');
		$custom_fields = $this->model_account_custom_field->getCustomFields($this->config->get('config_customer_group_id'));
		foreach ($custom_fields as $custom_field) {
			if (($custom_field['location'] == 'account') && $custom_field['required'] && empty($this->request->post['custom_field'][$custom_field['custom_field_id']])) {
				$this->error['custom_field'][$custom_field['custom_field_id']] = sprintf($this->language->get('error_custom_field'), $custom_field['name']);
			} elseif (($custom_field['type'] == 'text' && !empty($custom_field['validation'])) && !filter_var($this->request->post['custom_field'][$custom_field['custom_field_id']], FILTER_VALIDATE_REGEXP, array('options' => array('regexp' => $custom_field['validation'])))) {
                $this->error['custom_field'][$custom_field['custom_field_id']] = sprintf($this->language->get('error_custom_field_validate'), $custom_field['name']);;
            }
		}

		return !$this->error;
	}

	public function editProfile() {
	    $this->load->language('account/edit');
	    $json = array();
	    $rejson = array();
	    // Make sure we have the correct directory
	    $directory = DIR_IMAGE . 'catalog/customer_avatar';
	    // Check its a directory
	    if (!is_dir($directory)) {
	        $rejson['sys_error'] = $this->language->get('error_directory');
	    }
	    if (!$rejson) {
	    	if(isset($this->request->files)){
	    		$this->load->model('tool/image');
	    		$json = $this->model_tool_image->upload(['files' => $this->request->files['image'], 'directory' => 'catalog/customer_avatar/', 'limit_size' =>1048576]);
	    	}
	    	if(isset($json['images'][0]['success'])){
	    		$this->load->model('account/customer');
	    		$this->model_account_customer->editCustomerImg($json['images'][0]['url']);
				$rejson['success'] = $json['images'][0]['success'];
	    		$rejson['url'] = $this->model_tool_image->profileResize($json['images'][0]['url'],100,100);
	    	}
	    	if(isset($json['images'][0]['error'])){
	    		$rejson['error'] = $json['images'][0]['error'];
	    	}
	    }else {
	        $rejson['sys_error'] = $this->language->get('error_upload');
	    }
	    $this->response->addHeader('Content-Type: application/json');
	    $this->response->setOutput(json_encode($rejson));
	}
	
	//add by yagami at 20161109  editProfile and editHomeImg
	public function editHomeImg() {
	    $this->load->language('account/edit');
	    $json = array();
	    $rejson = array();
	    // Make sure we have the correct directory
	    $directory = DIR_IMAGE . 'catalog/userHome';
	    // Check its a directory
	    if (!is_dir($directory)) {
	        $rejson['sys_error'] = $this->language->get('error_directory');
	    }
	    if (!$rejson) {
	    	if(isset($this->request->files)){
	    		$this->load->model('tool/image');
	    		$json = $this->model_tool_image->upload(['files' => $this->request->files['image'], 'directory' => 'catalog/customer_avatar/', 'limit_size'=>2097152]);
	    	}
	    	if(isset($json['images'][0]['success'])){
	    		$this->load->model('account/customer');	    
	    		$data = array(
		    		'BackgroudImage' => $json['images'][0]['url'],
		    		'customer_id' => $this->customer->getId()
			    );
			    $this->model_account_customer->edituserHomeBackgroud($data);
	    		 foreach ($json['images'] as $key=>$image){
	    			if($this->config->get('amazon_s3_status')){
	    				$json['images'][$key]['url'] = DIR_S3IMAGE . $image['url'];
	    			}else{
	    		        $json['images'][$key]['url'] = DIR_IMAGE . $image['url'];
	    			}
	    		} 
	    		$rejson['success'] = $json['images'][0]['success'];
	    		$rejson['url'] = HTTP_CATALOG . 'image/'.$json['images'][0]['url'];
	    	}
	    	if(isset($json['images'][0]['error'])){
	    		$rejson['error'] = $json['images'][0]['error'];
	    	}
	    }else {
	        $json['sys_error'] = $this->language->get('error_upload');
	    }
	    $json['count']=count($this->request->files['file']['tmp_name']);
	    $this->response->addHeader('Content-Type: application/json');
	    $this->response->setOutput(json_encode($rejson));
	}
	}