<?php
class ControllerCommonUserHomePage extends Controller {
	public function index() {
	    $this->load->language('account/userHome');
	    $this->load->model('account/follow');
	    $this->load->model('account/collection');
	    $this->load->model('account/customer');
	    $this->load->model('blog/article');
	    $this->load->model('tool/image');
		$customer_id = isset($this->request->get['customer_id']) ? $this->request->get['customer_id'] : $this->customer->getId();
	    if(isset($this->request->get['customer_id'])){
	        $data['myHome'] = $this->customer->getId() == $this->request->get['customer_id'] ? 1 : 0;
	    }else{
	        $data['myHome'] = 1;
	    }
	    if(isset($this->request->get['route'])){
	        $data['route'] = $this->request->get['route'];
	    }
	    //text
	    $data['text_like'] = $this->language->get('text_like');
	    $data['text_list'] = $this->language->get('text_list');
	    $data['text_store'] = $this->language->get('text_store');
	    $data['text_evaluation'] = $this->language->get('text_evaluation');
	    $data['text_follow'] = $this->language->get('text_follow');
	    $data['text_following'] = $this->language->get('text_following');
	    $data['text_follower'] = $this->language->get('text_follower');
	    $data['text_followers'] = $this->language->get('text_followers');
	    $data['text_editAccount'] = $this->language->get('text_editAccount');
	    //link
	    $data['url_edit'] = $this->url->link('account/edit', '', true);
	    $data['url_userHome'] = $this->url->link('account/userHome', 'customer_id=' . $customer_id);
	    $data['url_follow'] = $this->url->link('account/follow/follow','customer_id=' . $customer_id);
	    $data['url_following'] = $this->url->link('account/follow/getFollow','customer_id=' . $customer_id);
	    $data['url_followers'] = $this->url->link('account/follow/getFollower','customer_id=' . $customer_id);
	    $data['url_list'] = $this->url->link('account/collection','customer_id=' . $customer_id);
	    $data['url_store'] = $this->url->link('account/follow/getFollowStore','customer_id=' . $customer_id);
	    $data['url_evaluation'] = $this->url->link('account/evaluation','customer_id=' . $customer_id);
	    //data   image,nickname AS name,description,wishlist_count,list_count
	    
	    $user_data = $this->model_account_customer->getUserHome($customer_id);	    
	    $totalFollow=$this->model_account_follow->getTotalFollow($customer_id);
	    $totalFollower=$this->model_account_follow->getTotalFollower($customer_id);
	    $totalFollowStore=$this->model_account_follow->getTotalFollowStore($customer_id);
	    $totalCustomerEva=$this->model_blog_article->getTotalCustomerEvaluation($customer_id);
	    
	    $data['collection_count'] = $this->model_account_collection->getCollectionsCount($customer_id);
	    $data['fav_collection_count'] = $this->model_account_collection->getFollowedCollectionsCount($customer_id);
	    if(empty($user_data['background_image'])){
	        $user_data['background_image'] = 'no_image.jpg';
	    }
	    $img_px =  getimagesize(DIR_IMAGE.$user_data['background_image']);
	    
	    if($this->model_account_follow->isCustomerFollow($customer_id)){
	        $data['fancy'] = 1;
	    }else{
	        $data['fancy'] = 0;
	    }
	    $data['user_data'] = array(
	        'image'              =>   $this->model_tool_image->profileResize($user_data['image'], 100, 100),
	        'name'               =>   $user_data['name'],
	        'description'        =>   strip_tags(html_entity_decode($user_data['description'], ENT_QUOTES, 'UTF-8')),
	        'background_image'   =>   $this->model_tool_image->resize($user_data['background_image'], $img_px[0], $img_px[1]),
	        'wishlist_count'     =>   $user_data['wishlist_count'],
	        'list_count'         =>   $data['collection_count'] + $data['fav_collection_count'],
	        'totalFollow'        =>   $totalFollow,
	        'totalFollower'      =>   $totalFollower,
	        'totalFollowStore'   =>   $totalFollowStore,
	        'totalCustomerEva'   =>   $totalCustomerEva
	    
	    );
	    if($this->customer->isLogged() && $this->customer->getId()==$customer_id){
	    
	        $data['reward_total'] = (int)$this->customer->getRewardPoints();
	    
	    }
	    if($this->customer->isLogged()){
	        $data['customer_group_id'] = $this->customer->getGroupId();
	    }
	    return $this->load->view('new_elements/userHome_top.tpl', $data);  
	}
	
	
}
