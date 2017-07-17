<?php
class ControllerTotalCoupon extends Controller {
	public function index() {
		if ($this->config->get('coupon_status')) {
			$this->load->language('total/coupon');

			$data['heading_title'] = $this->language->get('heading_title');

			$data['text_loading'] = $this->language->get('text_loading');

			$data['entry_coupon'] = $this->language->get('entry_coupon');

			$data['button_coupon'] = $this->language->get('button_coupon');

			if (isset($this->session->data['coupon'])) {
				$data['coupon'] = $this->session->data['coupon'];
			} else {
				$data['coupon'] = '';
			}

			return $this->load->view('total/coupon', $data);
		}
	}

	public function coupon() {
		$this->load->language('total/coupon');

		$json = array();

		$this->load->model('total/coupon');

		if (isset($this->request->post['coupon'])) {
			$coupon = $this->request->post['coupon'];
		} else {
			$coupon = '';
		}

		$coupon_info = $this->model_total_coupon->getCoupon($coupon);
		if (empty($this->request->post['coupon'])) {
			$json['error'] = $this->language->get('error_empty');

			unset($this->session->data['coupon']);
		} elseif (is_array($coupon_info)) {
			$this->session->data['coupon'] = $this->request->post['coupon'];
			$json['coupon'] = $coupon_info;
			$this->session->data['success'] = $this->language->get('text_success');
            
		} else {
		        $this->session->data['coupon'] = $coupon;
			    if($coupon_info==0){
			        $json['error'] = $this->language->get('error_coupon_invalid');
			    }
			    if($coupon_info==-2){
			        $json['error'] = $this->language->get('error_coupon_coupontime');
			    }
			    if($coupon_info==-3){
			        $json['error'] = $this->language->get('error_coupon_nolog');
			    }
			    if($coupon_info==-4){
			        $json['error'] = $this->language->get('error_coupon_customertime');
			    }
			    if($coupon_info==-5){
			        $json['error'] = $this->language->get('error_coupon_product');
			    }
			}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
}
