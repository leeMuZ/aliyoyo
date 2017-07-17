<?php
class ControllerAccountReward extends Controller {
   
	public function index() {
		if (!$this->customer->isLogged()) {
			$this->session->data['redirect'] = $this->url->link('account/reward', '', true);

			$this->response->redirect($this->url->link('account/login', '', true));
		}
        $this->load->model('account/reward');
		$result = $this->model_account_reward->getcouponno();
		$pass = $this->model_account_reward->getcouponpass();
		$invalid = $this->model_account_reward->getcouponinvalid();
		print_r($invalid);
		die;
		
	    $this->document->setTitle('coupon');
		$this->document->setDescription($this->config->get('config_meta_description'));
		$this->document->setKeywords($this->config->get('config_meta_keyword'));
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');
		$this->response->setOutput($this->load->view('account/reward', $data));
	}

}
