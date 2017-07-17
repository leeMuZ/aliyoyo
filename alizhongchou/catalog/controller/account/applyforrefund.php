<?php
class ControllerAccountapplyforrefund extends Controller {
   
	public function index() {
		if (!$this->customer->isLogged()) {
			$this->session->data['redirect'] = $this->url->link('account/order', '', true);

			$this->response->redirect($this->url->link('account/login', '', true));
		}
		$this->document->addStyle('catalog/view/stylesheet/applyforrefund.css');
		$this->load->model('account/applyforrefund');
		//退款页		
		if(!empty($this->request->get['uid'])){
			$result = $this->model_account_applyforrefund->getxinxi($this->request->get['uid']);
			$data['result']=$result;
			$data['name']=$this->request->get['name'];

		}
			//提交退款信息
		    if (($this->request->server['REQUEST_METHOD'] == 'POST')) {
				$pro = $this->model_account_applyforrefund->getpro($this->request->post['order']);
				$user = $this->model_account_applyforrefund->getcustomer();
				$arr=array();
			    foreach($pro as $v){
				  $arr['order_id']=$v['order_id'];
				  $arr['rewards_id']=$v['rewards_id'];
				  $arr['name']=$v['name'];
				  $arr['crowdfunding_name']=$v['crowdfunding_name'];
			   }
			   foreach($user as $v){
				   $arr['firstname']=$v['firstname'];
				   $arr['lastname']=$v['lastname'];
				   $arr['email']=$v['email'];
				   $arr['telephone']=$v['telephone'];
				   
				   
			   }
			    $return_id = $this->model_account_applyforrefund->addReturn($this->request->post,$arr);
				if(!empty($return_id)){
					$this->response->redirect($this->url->link('account/edit', '', true));
				}
			  
		     }


	
	    //$this->document->addScript('catalog/view/theme/' . $this->config->get($this->config->get('config_theme') . '_directory') . '/js/imagesloaded.pkgd.min.js');
	    //$this->document->addStyle('view/stylesheet/livehelp.css');
	    $this->document->setTitle($this->config->get('config_meta_title'));
		$this->document->setDescription($this->config->get('config_meta_description'));
		$this->document->setKeywords($this->config->get('config_meta_keyword'));
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');
		$data['action'] = $this->url->link('account/applyforrefund', '', true);
		$this->response->setOutput($this->load->view('account/applyforrefund', $data));
	}
	

}
