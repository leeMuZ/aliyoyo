<?php
class ControllerCommonHowItWork extends Controller {
	public function index() {
	    $this->document->addStyle('catalog/view/stylesheet/css/faq.css');
        $data['footer'] = $this->load->controller('common/footer');
        $data['header'] = $this->load->controller('common/header');
		$this->response->setOutput($this->load->view('common/howitwork', $data));
	}
}