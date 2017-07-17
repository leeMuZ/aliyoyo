<?php
class ControllerCommonFooter extends Controller {
	public function index() {
	    $data['title'] = $this->document->getTitle();
	    $data['createProject'] = $this->url->link("project/crowdfund");
	    $data['faq'] = $this->url->link('common/faq');
	    $data['howitwork'] = $this->url->link('common/howitwork');
	    $data['partner'] = $this->url->link('common/partner');
		$data['login'] = $this->url->link('account/register');
		$data['aboutUs'] = $this->url->link('common/aboutUs');
		$data['trustsafety'] = $this->url->link('common/trustsafety');
		$data['termsuse'] = $this->url->link('common/termsuse');
		$data['privacy'] = $this->url->link('common/privacy');
		return $this->load->view('common/footer', $data);
	}
}
