<?php
class ControllerAccountRegister extends Controller {
    private $error = array();
	public function index() {
	        $this->load->language('account/register');
	        $this->load->model('account/customer');
	        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
	            $data = $this->request->post;
	            $customer_id = $this->model_account_customer->addCustomer($data);
	            $this->customer->login($this->request->post['email'], $this->request->post['password']);
	            unset($this->session->data['guest']);
	        
	            $this->response->redirect($this->url->link('account/home'));
	        }
	        $this->document->setTitle($this->language->get('heading_title'));
	        $data['login'] = $this->url->link('account/login', '', true);
		    $data['register'] = $this->url->link('account/register', '', true);
		    $data['forgotten'] = $this->url->link('account/forgotten', '', true);
	        if (isset($this->request->post['nickname'])) {
	            $data['nickname'] = $this->request->post['nickname'];
	        } else {
	            $data['nickname'] = '';
	        }
	        
	        if (isset($this->request->post['email'])) {
	            $data['email'] = $this->request->post['email'];
	        } else {
	            $data['email'] = '';
	        }
	        
	        if (isset($this->request->post['password'])) {
	            $data['password'] = $this->request->post['password'];
	        } else {
	            $data['password'] = '';
	        }
	        
	        if (isset($this->request->post['confirm'])) {
	            $data['confirm'] = $this->request->post['confirm'];
	        } else {
	            $data['confirm'] = '';
	        }
	        
	        if (isset($this->error['nickname'])) {
	            $data['error_nickname'] = $this->error['nickname'];
	        } else {
	            $data['error_nickname'] = '';
	        }
	        
	        if (isset($this->error['email'])) {
	            $data['error_email'] = $this->error['email'];
	        } else {
	            $data['error_email'] = '';
	        }
	        
	        if (isset($this->error['password'])) {
	            $data['error_password'] = $this->error['password'];
	        } else {
	            $data['error_password'] = '';
	        }
	        
	        if (isset($this->error['confirm'])) {
	            $data['error_confirm'] = $this->error['confirm'];
	        } else {
	            $data['error_confirm'] = '';
	        }  
	  if (isset($this->error['warning'])) {
	            $data['warning'] = $this->error['warning'];
	        } else {
	            $data['warning'] = '';
	        }  
	     if ($this->request->server['HTTPS']) {
	        $server = HTTPS_SERVER;
	    } else {
	        $server = HTTP_SERVER;
	    } 
	    
	    $data['title'] = $this->document->getTitle();
	    $data['function']='register';
	    $data['base'] = $server;
	    $data['lang'] = $this->language->get('code');
	    $data['direction'] = $this->language->get('direction');
	    $data['description'] = $this->document->getDescription();
	    $data['cook'] = $this->url->link('account/register/cook');
		$data['terms'] = $this->url->link('account/register/terms');
		$data['privacy'] = $this->url->link('account/register/privacy');
		$data['keywords'] = $this->document->getKeywords();
		$data['href'] = $this->url->link('account/forgotten');
		$this->response->setOutput($this->load->view('account/registerAndLogin', $data));
	}
	
	public function cook() {
	  $this->document->setTitle('Cookies');
	  $data['footer'] = $this->load->controller('common/footer');
	  $data['header'] = $this->load->controller('common/header');
	  $this->response->setOutput($this->load->view('account/cook',$data));
	}
	public function terms() {
	  $this->document->setTitle('termsuse');
	  $data['footer'] = $this->load->controller('common/footer');
	  $data['header'] = $this->load->controller('common/header');
	  $this->document->addStyle('catalog/view/stylesheet/privacypolicy.css');
	  $this->response->setOutput($this->load->view('account/terms',$data));
	}
	public function privacy() {
	  $this->document->setTitle('privacypolicy');
	  $data['footer'] = $this->load->controller('common/footer');
	  $data['header'] = $this->load->controller('common/header');
	  $this->response->setOutput($this->load->view('account/privacy',$data));
	}
	
	private function validate() {
	    if ((utf8_strlen(trim($this->request->post['nickname'])) < 3) || (utf8_strlen(trim($this->request->post['nickname'])) > 17)) {
	        $this->error['nickname'] = $this->language->get('error_nickname');
	    }
	    if ((utf8_strlen($this->request->post['email']) > 96) || !filter_var($this->request->post['email'], FILTER_VALIDATE_EMAIL)) {
	        $this->error['email'] = $this->language->get('error_email');
	    }
	
	    if ($this->model_account_customer->getTotalCustomersByEmail($this->request->post['email'])) {
	        $this->error['email'] = $this->language->get('error_exists');
	    }
	
	
	    if ((utf8_strlen($this->request->post['password']) < 4) || (utf8_strlen($this->request->post['password']) > 20)) {
	        $this->error['password'] = $this->language->get('error_password');
	    }
	
	    if ($this->request->post['confirm'] != $this->request->post['password']) {
	        $this->error['confirm'] = $this->language->get('error_confirm');
	    }
	    return !$this->error;
	}

}


