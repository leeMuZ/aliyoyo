<?php
class ControllerCommonHeader extends Controller {
	public function index() {
		// Analytics
	    /*     
		$this->load->model('extension/extension');
				
		$data['analytics'] = array();

		$analytics = $this->model_extension_extension->getExtensions('analytics');

		foreach ($analytics as $analytic) {
			if ($this->config->get($analytic['code'] . '_status')) {
				$data['analytics'][] = $this->load->controller('analytics/' . $analytic['code'], $this->config->get($analytic['code'] . '_status'));
			}
		} */
	    $data['register'] = $this->url->link('account/register');
	    $data['login'] = $this->url->link('account/login');
	if ($this->request->server['HTTPS']) {
	        $server = HTTPS_SERVER;
	    } else {
	        $server = HTTP_SERVER;
	    }
		

		if (is_file(DIR_IMAGE . $this->config->get('config_icon'))) {
			$this->document->addLink(HTTP_Aliyoyo . 'image/' . $this->config->get('config_icon'), 'icon');
		}
		$data['title'] = $this->document->getTitle();

		$data['base'] = $server;
		$data['description'] = $this->document->getDescription();
		$data['keywords'] = $this->document->getKeywords();
		$data['links'] = $this->document->getLinks();
		$data['styles'] = $this->document->getStyles();
		$data['scripts'] = $this->document->getScripts();
		$data['lang'] = $this->language->get('code');
		$data['direction'] = $this->language->get('direction');
		
		$data['name'] = $this->config->get('config_name');
		if($this->customer->isLogged()){
		    $data['is_login'] = 1;
		    $this->load->model('account/home');
		    $this->load->model('tool/image');
		    $data['cutomer_name'] = $this->customer->getNickname();
		    $data['projects']= $this->model_account_home->getcrowdfundings($this->customer->getId());
		    foreach ($data['projects'] as $key=>$project){
		    
		        $data['projects'][$key]['image'] = $this->model_tool_image->profileResize($project['image'],45,27);
		        $data['projects'][$key]['url'] = $this->url->link('project/crowdfund/company','funding_id=' .$project['funding_id']);
		    }
		}else{
		    $data['is_login'] = 0;
		}
		if (is_file(DIR_IMAGE . $this->config->get('config_logo'))) {
			$data['logo'] = $server . 'image/' . $this->config->get('config_logo');
		} else {
			$data['logo'] = '';
		}
        $this->load->model('account/home');
        $data['category'] = $this->model_account_home->categoryMessage();
	    $data['createProject'] = $this->url->link("project/crowdfund");
	    $data['aboutUs'] = $this->url->link("common/aboutUs");
		$data['edit'] = $this->url->link('account/edit');
		$data['homePage'] = $this->url->link('account/home');
		$data['logout'] = $this->url->link('account/logout');
		return $this->load->view('common/header', $data);
	}
}
