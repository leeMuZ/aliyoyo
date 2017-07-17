<?php
class ControllerCommonHome extends Controller {
	public function index() {
	    //$this->document->addScript('catalog/view/theme/' . $this->config->get($this->config->get('config_theme') . '_directory') . '/js/imagesloaded.pkgd.min.js');
	    $this->document->addStyle('catalog/view/stylesheet/css/home.css');
        $this->load->language('common/home');
        $this->document->setTitle($this->language->get('index_title'));
        $this->document->setDescription($this->language->get('index_description'));
        $this->document->setKeywords($this->language->get('index_keyword'));
        $this->load->model('crowdfunding/crowdfunding');
        $data['index'] = $this->model_crowdfunding_crowdfunding->take_recommend_category();
        $data['footer'] = $this->load->controller('common/footer');
        $data['header'] = $this->load->controller('common/header');
		$this->response->setOutput($this->load->view('common/home', $data));
	}
}