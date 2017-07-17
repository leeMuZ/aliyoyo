<?php
class ControllerCommonListHeader extends Controller {
	public function index() {
	    $this->load->model('account/follow');
	    $this->load->model('account/customer');
	    $this->load->model('account/collection');
	    $this->load->model('blog/article');
	    $this->load->model('tool/image');
	    
	    $collection_id= isset($this->request->get['collection']) ? $this->request->get['collection'] : 0;
	    $data['collection_data'] = $this->model_account_collection->getCollection($collection_id);
	    
	    if(!empty($data['collection_data'])){

		    $customer_id = $data['collection_data']['customer_id'];
		    if(isset($this->request->get['route'])){
		        $data['route'] = $this->request->get['route'];
		    }
		    if($customer_id && $this->customer->isLogged()){
		        $data['myHome'] = ((int)$this->customer->getId() === (int)$customer_id) ? 1 : 0;
		    }else{
		        $data['myHome'] = 0;
		    }
		    //text
		    $data['text_follow'] = $this->language->get('text_follow');
		    
		    //link
		    $data['url_userHome'] = $this->url->link('account/userHome', '', true);
		    //data   image,nickname AS name,description,wishlist_count,list_count
		    
		    $user_data = $this->model_account_customer->getUserHome($customer_id);
		    
		    if(empty($user_data['image'])){
		        $user_data['image'] = 'no_image.jpg';
		    }
		    
		    $data['user_data'] = array(
		        'image'              =>   $this->model_tool_image->profileResize($user_data['image'], 100, 100),
		        'name'               =>   $user_data['name'],
		        'customer_id'        =>   $customer_id,
		        'url_user'           =>   $user_data['customer_group_id'] == 5 ? $this->url->link('account/storeHome', 'customer_id=' . $customer_id) : $this->url->link('account/userHome', 'customer_id=' . $customer_id),
		        'url_follower'       =>   $this->url->link('account/follow/getCollectionFollower', 'collection=' . $collection_id)
		    );
		    if($this->customer->isLogged()){
		        $data['customer_group_id'] = $this->customer->getGroupId();
		    }
		    $data['collection_id'] = $collection_id;
		    $data['is_follow'] = ($this->customer->isLogged()) ? ($this->model_account_collection->isFollowCollection($collection_id)) : 0;
		    return $this->load->view('account/listheader', $data);

	    }else{
	    	return null;
	    }
	}
}
