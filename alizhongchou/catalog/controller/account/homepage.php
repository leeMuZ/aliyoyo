<?php
class ControllerAccountHomepage extends Controller {
   
	public function index() {
		if (!$this->customer->isLogged()) {
			$this->session->data['redirect'] = $this->url->link('account/order', '', true);

			$this->response->redirect($this->url->link('account/login', '', true));
		}
		$this->load->model('account/homepage');
		$this->load->model('account/home');
		$uid =  isset($this->request->get['customer_id']) ? $this->request->get['customer_id'] : $this->customer->getId();
		$category = $this->model_account_homepage->getcategory();
        //去除重复值
		foreach ($category as $v){
		  $v=implode(',',$v);
		  $temp[]=$v;
		}
		$temp=array_unique($temp);
		foreach ($temp as $k => $v){
		  $temp[$k]=explode(',',$v);
		}

		$data['category']=$temp;
		//分类
		if(!empty($this->request->get['show'])){
		   $limit=$this->request->get['show'];
		   $data['show']=$this->request->get['show'];
		}else{
		   $limit=12;
		   $data['show']='';
		}
		
	    if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}
		$filter_data = array(
			'start' => ($page - 1) * $limit,
			'limit' => $limit
		);
        $result = $this->model_account_homepage->getproduct($filter_data,$uid);
		$order_total = $this->model_account_homepage->getTotalproduct($uid);		
        
		//分类
		if(!empty($this->request->get['category_id'])){
           $result = $this->model_account_homepage->getproducts($filter_data,$this->request->get['category_id']);
		   $order_total = $this->model_account_homepage->getTotalcategory($this->request->get['category_id']);
		   $data['category_id']=$this->request->get['category_id'];
		}else{
		   $data['category_id']='';
		}	
		
		//排序
		if(!empty($this->request->get['sort_by'])){

           $result = $this->model_account_homepage->getsort($filter_data,$this->request->get['sort_by']);
		   $order_total = $this->model_account_homepage->getTotalproduct($uid);		
		   $data['sort_by']=$this->request->get['sort_by'];
		}else{
		   $data['sort_by']='';
		}
		if(!empty($this->request->get['category_id']) && !empty($this->request->get['sort_by'])){

		   $result = $this->model_account_homepage->getcate_sort($filter_data,$this->request->get['category_id'],$this->request->get['sort_by']);
		   $order_total = $this->model_account_homepage->getTotalcategory($this->request->get['category_id']);
		   $data['category_id']=$this->request->get['category_id'];
		}
		
        $pagination = new Pagination();
		$pagination->total = $order_total;
		$pagination->page = $page;
		$pagination->limit = $limit;
		if($data['category_id']!=null && $data['sort_by']!=null && $data['show']!=null){
		   $pagination->url = $this->url->link('account/homepage', 'page={page}'.'&category_id='.$data['category_id'].'&sort_by='.$data['sort_by'].'&show='.$data['show'], true);				    
		}elseif($data['category_id']!=null && $data['sort_by']!=null){
		   $pagination->url = $this->url->link('account/homepage', 'page={page}'.'&category_id='.$data['category_id'].'&sort_by='.$data['sort_by'], true);				    
		}elseif($data['sort_by']!=null && $data['show']!=null){
		   $pagination->url = $this->url->link('account/homepage', 'page={page}'.'&sort_by='.$data['sort_by'].'&show='.$data['show'], true);				    
		}elseif($data['category_id']!=null && $data['show']!=null){
		   $pagination->url = $this->url->link('account/homepage', 'page={page}'.'&category_id='.$data['category_id'].'&show='.$data['show'], true);				    
		}elseif($data['category_id']!=null){
		   $pagination->url = $this->url->link('account/homepage', 'page={page}'.'&category_id='.$data['category_id'], true);
		}elseif($data['sort_by']!=null){
		   $pagination->url = $this->url->link('account/homepage', 'page={page}'.'&sort_by='.$data['sort_by'], true);
		}elseif($data['show']!=null){
		   $pagination->url = $this->url->link('account/homepage', 'page={page}'.'&show='.$data['show'], true);			
	    }else{
		   $pagination->url = $this->url->link('account/homepage', 'page={page}', true);
			
		}
		$data['pagination'] = $pagination->render();
	    $this->document->setTitle($this->config->get('config_meta_title'));
		$this->document->setDescription($this->config->get('config_meta_description'));
		$this->document->setKeywords($this->config->get('config_meta_keyword'));
		$customer_info = $this->model_account_home->getCustomer($this->customer->getId());

		//add by yagami at 20170705 
		if (isset($this->request->post['avatar'])){
		    $data['photo'] = $this->request->post['avatar'];
		} elseif (!empty($customer_info)) {
		    $this->load->model('tool/image');
		    $data['photo'] = $this->model_tool_image->profileResize($customer_info['image'],100,100);
		} else {
		    $data['photo'] = '';
		}
		$data['result'] = $result;
		$data['customer_info']=$customer_info;
		$data['curl'] = $this->url->link('account/homepage');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');
		$this->response->setOutput($this->load->view('account/homepage', $data));
	}
}
