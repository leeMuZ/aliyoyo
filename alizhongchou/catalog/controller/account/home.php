<?php
class ControllerAccountHome extends Controller {
   
   //add by liuxuewen at 20170408 个人中心展示
	public function index() {

		if (!$this->customer->isLogged()) {
			$this->session->data['redirect'] = $this->url->link('account/home', '', true);

			$this->response->redirect($this->url->link('account/login', '', true));
		}

	    $uid =  isset($this->request->get['customer_id']) ? $this->request->get['customer_id'] : $this->customer->getId();
		 if(!is_numeric($uid)){
			$this->response->redirect($this->url->link('common/error'));
			die;			
		 }
		 
		$data['self']=$this->customer->getId();
		$this->document->addStyle('catalog/view/stylesheet/individual.css');
		$this->load->model('account/home');
		//关注商品的数量
		$total = $this->model_account_home->total();
	    $data['total']=$total;	
		//购买商品的数量
		$total1 = $this->model_account_home->total1();
	    $data['total1']=$total1;
		//我发布过的商品
		$total2 = $this->model_account_home->total2($uid);
	    $data['total2']=$total2;
		if(!empty($this->request->get['url'])){			
		 $url = $this->request->get['url'];
		  //收藏过的商品
		 if ($url==1 ) {
			  $result = $this->model_account_home->getcrowdfunding();
			  $data['result']=$result;
			  $data['url']=1;
			  $data['uid']=$uid;
		}elseif($url==2 ){
			    $result = $this->model_account_home->getproduct();
				$data['result']=$result;
				$data['url']=2;
                $data['uid']=$uid;
		}elseif($url==3 ){
			  //用户发布过的商品
			  $result = $this->model_account_home->getcrowdfundings($uid);
			  $data['result']=$result;
			  $data['url']=3;
			  $data['uid']=$uid;
		}
		}else{		
		  if($uid != $this->customer->getId()){
			$num = $this->model_account_home->customer($uid);
			if($num>0){
				$result = $this->model_account_home->getcrowdfundings($uid);
				$customer_info1 = $this->model_account_home->getCustomer($uid);
				if (!empty($customer_info1)) {
		        $this->load->model('tool/image');
		        $data['img'] = $this->model_tool_image->profileResize($customer_info1['image'],100,100);
		        $data['back_img'] = $this->model_tool_image->profileResize($customer_info1['background_image'],100,100);
				}
				$data['name1'] = $customer_info1;
				$data['result']=$result;
				$data['url']=3;
				$data['uid']=$uid;
			}else{
                
				$this->response->redirect($this->url->link('common/error'));
			   
			}
		   }else{
			  //收藏过的商品
			  $customer_info1 = $this->model_account_home->getCustomer($uid);

			  if (!empty($customer_info1)) {
		        $this->load->model('tool/image');
		        $data['img'] = $this->model_tool_image->profileResize($customer_info1['image'],100,100);
		        $data['back'] = $customer_info1;
				}
			  $data['name1'] = $customer_info1;
			  $data['uid']=$uid;
			  if(isset($this->request->get['customer_id'])){
				$result = $this->model_account_home->getcrowdfundings($uid);  
				$data['result']=$result;
				$data['url']=3;					
			  }else{
				  $result = $this->model_account_home->getcrowdfunding();
				  $data['result']=$result;
				  $data['url']=1;

			  }

		   }

		}

		 //取消收藏
		 if (isset($this->request->get['remove'])) {
			// Remove home
			$this->model_account_home->deleteWishlist($this->request->get['remove']);
			$this->response->redirect($this->url->link('account/home'));
		}
		 //取消自己添加的商品
		 if (isset($this->request->get['rem'])) {
			// Remove home
			$this->model_account_home->deleteproduct($this->request->get['rem']);
			$this->response->redirect($this->url->link('account/home'));
		}
		if ($this->request->server['REQUEST_METHOD'] != 'POST') {
			$customer_info = $this->model_account_home->getCustomer($this->customer->getId());
		}
		//add by yagami at 20170408 
		if (isset($this->request->post['avatar'])){
		    $data['photo'] = $this->request->post['avatar'];
		} elseif (!empty($customer_info)) {
		    $this->load->model('tool/image');
		    $data['photo'] = $this->model_tool_image->profileResize($customer_info['image'],100,100);
		} else {
		    $data['photo'] = '';
		}

         $this->load->model('account/customer');
		 $her=$this->model_account_customer->getCustomer($this->customer->getId());
		 $data['back']=$her;
   
	    $this->document->setTitle('home');
		$this->document->setDescription($this->config->get('config_meta_description'));
		$this->document->setKeywords($this->config->get('config_meta_keyword'));
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');
		$data['href'] = $this->url->link('account/home');
		$data['href1'] = $this->url->link('account/datepage');
		$data['edit'] = $this->url->link('account/edit');
		$data['href2'] = $this->url->link('crowdfunding/campaign');
		$data['action'] = $this->url->link('account/edit', '', true);
		$data['pedit'] = $this->url->link('project/crowdfund/company', '', true);
		$data['name'] = $customer_info;


		$this->response->setOutput($this->load->view('account/home', $data));
	}

}
