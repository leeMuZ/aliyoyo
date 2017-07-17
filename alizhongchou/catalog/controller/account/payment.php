<?php
class ControllerAccountpayment extends Controller {
   
	public function index() {
		if (!$this->customer->isLogged()) {
			$this->session->data['redirect'] = $this->url->link('account/payment', '', true);

			$this->response->redirect($this->url->link('account/login', '', true));
		}
	
	    //$this->document->addScript('catalog/view/theme/' . $this->config->get($this->config->get('config_theme') . '_directory') . '/js/imagesloaded.pkgd.min.js');
	    //$this->document->addStyle('view/stylesheet/livehelp.css');
	    $this->document->setTitle($this->config->get('config_meta_title'));
		$this->document->setDescription($this->config->get('config_meta_description'));
		$this->document->setKeywords($this->config->get('config_meta_keyword'));
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');
		$this->response->setOutput($this->load->view('account/payment', $data));
	}
}
