<?php
class ControllerCommonPrivacy extends Controller {
	public function index() {
	    //$this->document->addScript('catalog/view/theme/' . $this->config->get($this->config->get('config_theme') . '_directory') . '/js/imagesloaded.pkgd.min.js');
	    $this->document->addStyle('catalog/view/stylesheet/privacypolicy.css');
        $data['footer'] = $this->load->controller('common/footer');
        $data['header'] = $this->load->controller('common/header');
		$this->response->setOutput($this->load->view('common/privacy', $data));
	}
}