<?php
class ControllerProjectCrowdFund extends Controller {
	private $error = array();
	
	public function index() {
	    
	    $this->document->addStyle('catalog/view/stylesheet/css/crowdfund.css');
	    $data['personal'] = $this->url->link('project/crowdfund/createProject','type=0');
	    $data['company'] = $this->url->link('project/crowdfund/createProject','type=1');
	    $data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');
	    $this->response->setOutput($this->load->view('project/crowdfund',$data));
	}
	
	public function createProject(){
	    //personal type 0 ,company type 1 
	  if($this->customer->isLogged()){
	    $this->load->model('project/crowdfund');
	    $funding_id = $this->model_project_crowdfund->creatProject($this->request->get['type']);
	    if($this->request->get['type']){
	        $this->response->redirect($this->url->link('project/crowdfund/company', 'funding_id='.$funding_id, true));
	    }else{
	        $this->response->redirect($this->url->link('project/crowdfund/personal', 'funding_id='.$funding_id, true));
	    }
	  }else{
	        $this->session->data['redirect'] = $this->url->link('project/crowdfund', '', true);
	        $this->response->redirect($this->url->link('account/login', '', true));
	  }
	}
	public function company(){
	    //后续补全安全校验 
	    $this->document->addStyle('catalog/view/stylesheet/css/crowdfund.css');
	    $this->document->addStyle('catalog/view/javascript/summernote/summernote.css');
	    $this->document->addScript('catalog/view/javascript/summernote/summernote.js');
	    $this->document->addScript('catalog/view/javascript/laydate/laydate.js');
	    $this->document->addScript('catalog/view/stylesheet/js/jquery.countdown.js');
	    $this->load->model('localisation/region');
	    $this->load->model('localisation/country');
	    $this->load->model('project/category');
	    $this->load->model('project/crowdfund');
	    $this->load->model('crowdfunding/crowdfunding');
	    $this->load->model('project/rewards');
	    $this->load->model('tool/image');
	    $funding_id = isset($this->request->get['funding_id'])?$this->request->get['funding_id'] : '';
	    $data['project'] = $this->model_project_crowdfund->getCrowdFunding($funding_id);

		if (isset($this->session->data['project_name'])) {
            $data['project']['image_src']=!isset($this->session->data['project_name']['project_image']) ? HTTP_Aliyoyo.'image/cache/no_image-700x420.jpg' : HTTP_Aliyoyo.'image/cache/'.$this->session->data['project_name']['project_image'];
			$data['name']=!isset($this->session->data['project_name']['project_name']) ? '' : $this->session->data['project_name']['project_name'];
			$data['introduce']=!isset($this->session->data['project_name']['project_introduce']) ? '' : $this->session->data['project_name']['project_introduce'];
		    $data['project']['date_start']=!isset($this->session->data['project_name']['date_start']) ? '' : $this->session->data['project_name']['date_start'];
		    $data['project']['date_ended']=!isset($this->session->data['project_name']['date_ended']) ? '' : $this->session->data['project_name']['date_ended'];
			$data['project']['total_goal']=!isset($this->session->data['project_name']['total_goal']) ? '' : $this->session->data['project_name']['total_goal'];
		}elseif(!empty($data['project'])){
			$data['name']= $data['project']['name'];
			$data['introduce']=$data['project']['introduce'];
			$data['date_start']=$data['project']['date_start'];
			$data['date_ended']=$data['project']['date_ended'];
			$data['total_goal']=$data['project']['total_goal'];
		}else{
			$data['name']='';
		}
		
		if($this->customer->isLogged){
	    if(!empty($data['project'])&&$data['project']['customer_id']==$this->customer->getId()){
	    $data['project_form'] = 1;
	    $data['description_form'] = 1;
	    $data['companyInfo_form']= 1;
	    $data['rewards_form'] = 1;
	    $data['customer_name'] = $this->customer->getNickname();
	    $data['customer_description'] = $this->customer->getDescription();
	    $data['image'] = $this->model_tool_image->profileResize($this->customer->getImage(),110,110);
	    //form validate
	    if($data['project']['name']==""||$data['project']['introduce']==""||$data['project']['total_goal']==0||$data['project']['image']==""||$data['project']['category_id']==0||$data['project']['date_start']=="0000-00-00"||$data['project']['date_ended']=="0000-00-00"){
	        $data['project_form'] = 0;
	    }
	    if($data['project']['image']==''){
	      $data['project']['image_src'] = $this->model_tool_image->profileResize('image/picture.jpg',700,420);
	    }else{
   	      $data['project']['image_src'] = $this->model_tool_image->profileResize($data['project']['image'],700,420);
	    }
	    if($data['project']['date_start']=="0000-00-00"){
	        $data['project']['date_start']='';
	    }
	    if($data['project']['date_ended']=="0000-00-00"){
	        $data['project']['date_ended']='';
	    }
	    if($data['project']['total_goal']==0){
	        $data['project']['total_goal']='';
	    }
	    $data['project']['percent'] = $data['project']['current_goal']>0 ? round($data['project']['current_goal']/$data['project']['total_goal']*100,2) : "0";
	    $data['projectDescription'] = $this->model_project_crowdfund->getCrowdFundingDescription($funding_id);
		
		if (isset($this->session->data['ris_description'])) {
			$data['risk_description']=$this->session->data['ris_description'];
		}elseif(!empty($data['projectDescription'])){
			$data['risk_description']= $data['projectDescription']['risk_description'];
		}else{
			$data['risk_description']='';
		} 

	    $data['projectDescription']['description'] =  html_entity_decode($data['projectDescription']['description'], ENT_QUOTES, 'UTF-8');
	    //form validate
	    if($data['project']['viedo']==""||$data['projectDescription']['description']==""||$data['projectDescription']['risk_description']==""){
	        $data['description_form'] = 0;
	    }
        $aresult = $this->model_project_rewards->getRewards($funding_id);//estimated_delivery			
		
		if(!empty($this->session->data['tile'])){

			$rresult=array();
			foreach($aresult as $vv){
			 foreach($this->session->data['tile'] as $k=>$v){
			  $rresult[$k]['name']=$v['tile'];	
			  $rresult[$k]['rewards_id']= !isset($v['rewards_id']) ? 1 :$v['rewards_id'] ;
			  $rresult[$k]['pledge_amount']=$v['pledge_amount'];
			  $rresult[$k]['description']=$v['description'];
			  $rresult[$k]['shipping_method']=!isset($v['limit_availability']) ? 0 : $v['shipping_method'];
			  $rresult[$k]['estimated_delivery']=$v['estimated_delivery_year']."-".$v['estimated_delivery_month'];
			  $rresult[$k]['shipping_postage']=$v['shipping_postage'];
			  $rresult[$k]['limit_availability']=!isset($v['limit_availability']) ? 0 : $v['limit_availability'];
			  $rresult[$k]['backers']=$vv['backers'];
			  $rresult[$k]['limit_backer']= !isset($v['limit_backer']) ? 0 : $v['limit_backer'] ;
			  $rresult[$k]['limit_time_end']= !isset($v['limit_time_end']) ? 0 : $v['limit_time_end'];
              $rresult[$k]['limit_time_begin']= !isset($v['limit_time_begin']) ? 0 :$v['limit_time_begin'];
			  $rresult[$k]['limit_backer_availability']= !isset($v['limit_backer_availability']) ? 0 : $v['limit_backer_availability'] ;
			  $rresult[$k]['limit_time_availability']= !isset($v['limit_time_availability']) ? 0 : $v['limit_time_availability'];
			  $rresult[$k]['stock']= $vv['stock'];
			  $rresult[$k]['crowdfunding_name']= $vv['crowdfunding_name'];
			 }
			}

		}
		if(!empty($rresult)){
			$data['rewards']=$rresult;	
		}else{
	        $data['rewards'] = $aresult;			
		}
		if(empty($data['rewards'])){
	        $data['rewards_form'] = 0;
	    }
	    foreach ($data['rewards'] as $k=>$v){
	        if($v['pledge_amount']==0){
	            $data['rewards'][$k]['pledge_amount'] = '';
	        }
	        $data['rewards'][$k]['description'] = html_entity_decode($v['description'], ENT_QUOTES, 'UTF-8');
	        $data['rewards'][$k]['delivery'] = $this->model_crowdfunding_crowdfunding->changeTime($v['estimated_delivery']);
	        $shippings = $this->model_project_rewards->getRewardShipping($v['rewards_id']);
	        if($v['name']==""||$v['pledge_amount']==0||substr($v['estimated_delivery'],0,4)==""||substr($v['estimated_delivery'],5,2)==""||($v['limit_backer_availability']==1 && $v['limit_backer']==0)||($v['limit_time_availability']==1 && ($v['limit_time_begin']=="0000-00-00" || $v['limit_time_begin']=="0000-00-00"))){
	            $data['rewards_form'] = 0;
	        }
	        if($v['shipping_method']!=0){
	        foreach ($shippings as $shipping){
	            if($shipping['country_id']==0){
	                $data['rewards_form'] = 0;
	                break;
	            }
	        }
	        }
	        $data['rewards'][$k]['shippings'] = $shippings;
	        $data['rewards'][$k]['estimated_year'] = substr($v['estimated_delivery'],0,4);
	        $data['rewards'][$k]['estimated_month'] = substr($v['estimated_delivery'],5,2);
	    }
	    $data['reward_row'] =count($data['rewards']);
	    $data['estimated_setting']['years'] = ['2017','2018','2019','2020','2021','2022'];
	    $data['estimated_setting']['months'] = ['01','02','03','04','05','06','07','08','09','10','11','12'];
	    $data['companyInfo'] = $this->model_project_crowdfund->getCompanyInfo($funding_id);
	    if($data['companyInfo']['name']==""||$data['companyInfo']['identity_image_face']==""||$data['companyInfo']['identity_image_back']==""||$data['companyInfo']['phone']==""||$data['companyInfo']['email']==""||$data['companyInfo']['businessLicence']==""||$data['companyInfo']['organizationCode']==""||$data['companyInfo']['company_name']==""||$data['companyInfo']['registeredTime']=="0000-00-00"||$data['companyInfo']['payee']==""||$data['companyInfo']['company_description']==""||$data['companyInfo']['payee_phone']==""||$data['companyInfo']['bank_card']==""||$data['companyInfo']['bank_name']==""||$data['companyInfo']['province_id']==0||$data['companyInfo']['city_id']==0||$data['companyInfo']['area_id']==0||$data['companyInfo']['address']==""){
	        $data['companyInfo_form'] = 0;
	    }
	    if($data['companyInfo']['identity_image_face']==''){
	      $data['companyInfo']['identity_image_face_src'] = $this->model_tool_image->profileResize('image/picture.jpg',145,160);
	    }else{
   	      $data['companyInfo']['identity_image_face_src'] = $this->model_tool_image->profileResize($data['companyInfo']['identity_image_face'],145,160);
	    }
	    if($data['companyInfo']['identity_image_back']==''){
	        $data['companyInfo']['identity_image_back_src'] = $this->model_tool_image->profileResize('image/picture.jpg',145,160);
	    }else{
	        $data['companyInfo']['identity_image_back_src'] = $this->model_tool_image->profileResize($data['companyInfo']['identity_image_back'],145,160);
	    }
	    if($data['companyInfo']['businessLicence']==''){
	        $data['companyInfo']['businessLicence_src'] = $this->model_tool_image->profileResize('image/picture.jpg',145,160);
	    }else{
	        $data['companyInfo']['businessLicence_src'] = $this->model_tool_image->profileResize($data['companyInfo']['businessLicence'],145,160);
	    }
	    if($data['companyInfo']['organizationCode']==''){
	        $data['companyInfo']['organizationCode_src'] = $this->model_tool_image->profileResize('image/picture.jpg',145,160);
	    }else{
	        $data['companyInfo']['organizationCode_src'] = $this->model_tool_image->profileResize($data['companyInfo']['organizationCode'],145,160);
	    }
	    if($data['companyInfo']['taxRegCertificate']==''){
	        $data['companyInfo']['taxRegCertificate_src'] = $this->model_tool_image->profileResize('image/picture.jpg',145,160);
	    }else{
	        $data['companyInfo']['taxRegCertificate_src'] = $this->model_tool_image->profileResize($data['companyInfo']['taxRegCertificate'],145,160);
	    }
	    if($data['companyInfo']['bankAccPermits']==''){
	        $data['companyInfo']['bankAccPermits_src'] = $this->model_tool_image->profileResize('image/picture.jpg',145,160);
	    }else{
	        $data['companyInfo']['bankAccPermits_src'] = $this->model_tool_image->profileResize($data['companyInfo']['bankAccPermits'],145,160);
	    }
	    if($data['companyInfo']['registeredTime']=="0000-00-00"){
	        $data['companyInfo']['registeredTime']='';
	    }
	    $data['editUrl'] = $this->url->link('project/crowdfund/edit','funding_id=' . $data['project']['funding_id']);
	    //publish
	    if($data['project']['status']==10){
	        $data['publishUrl'] = $this->url->link('project/crowdfund/publish','funding_id=' . $data['project']['funding_id']);
	    }
	    $data['provinces'] = $this->model_localisation_region->getProvinces();
	    $data['citys'] = $this->model_localisation_region->getRegionsByProveinceCode($data['companyInfo']['province_id']);
	    $data['areas'] = $this->model_localisation_region->getRegionsByProveinceCode($data['companyInfo']['city_id']);
	    $data['categories'] = $this->model_project_category->getAllCategory();
	    $data['countries'] =  $this->model_localisation_country->getCountries();
	    $data['footer'] = $this->load->controller('common/footer');
	    $data['header'] = $this->load->controller('common/header');
		if(isset($this->session->data['error_name'])){ 
		  $data['error_name']=$this->session->data['error_name'];
		}
		if(isset($this->session->data['error_introduce'])){
		  $data['error_introduce']=$this->session->data['error_introduce'];
		}
		if(isset($this->session->data['reward'])){
		  $data['error_tile']=$this->session->data['reward'];
		}
		if(isset($this->session->data['risk_de'])){
		  $data['risk_de']=$this->session->data['risk_de'];
	    }
		if(isset($this->session->data['pledge_amount'])){
		  $data['error_pledge_amount']=$this->session->data['pledge_amount'];
		}
		if(isset($this->session->data['s_reward'])){
		  $data['error_s_reward']=$this->session->data['s_reward'];
		}
		$this->response->setOutput($this->load->view('project/company',$data));
	    }else{
	        $data['continue'] = $this->url->link('common/home');
	        $this->response->addHeader($this->request->server['SERVER_PROTOCOL'] . ' 404 Not Found');
	        $data['footer'] = $this->load->controller('common/footer');
	        $data['header'] = $this->load->controller('common/header');
	        $this->response->setOutput($this->load->view('error/not_found', $data));
	        
	    }
		}else{
		   $this->response->redirect($this->url->link('account/login', '', true));
		}
	        
	}
	
	public function personal(){
	    $data['b'] = $this->request->post;
	    $this->document->addStyle('catalog/view/stylesheet/css/crowdfund.css');
	    $data['footer'] = $this->load->controller('common/footer');
	    $data['header'] = $this->load->controller('common/header');
	   // $this->response->setOutput($this->load->view('project/personal',$data));
	}
	
	public function upload(){
	    $json = Array();
	    $this->load->model("tool/image");
	    $path = 'crowdfund/project/'.$this->customer->getId();
	    $data = $this->model_tool_image->upload(['files' => $this->request->files['image'], 'directory' => $path,'limit_size' =>5242880]);
	    if(isset($data['images'][0]['success'])){
	       if(isset($this->request->post['large'])){
	        $data['images'][0]['image_url'] =  $this->model_tool_image->profileResize($data['images'][0]['url'],700,420);
	       } else{
	        $data['images'][0]['image_url'] =  $this->model_tool_image->profileResize($data['images'][0]['url'],145,160);
	       }
	    }
	    $this->response->addHeader('Content-Type:application/json');
	    $this->response->setOutput(json_encode($data)); 
	}
	
	public function summernoteUpload(){
	    $json = Array();
	    $this->load->model("tool/image");
	    $path = 'crowdfund/project/'.$this->customer->getId();
	    $data = $this->model_tool_image->upload(['files' => $this->request->files['image'], 'directory' => $path,'limit_size' =>5242880]);
	foreach ($data['images'] as $key=>$image){
	        if(isset($image['success'])){
	        $img_px =  getimagesize(DIR_IMAGE . $image['url']);
	        if($img_px[0] > $img_px[1] && $img_px[0]>600 ){
	        $data['images'][$key]['url'] =   $this->model_tool_image->resize($image['url'],600,ceil(600*$img_px[1]/$img_px[0]));
	        }
	        elseif($img_px[1]>$img_px[0] && $img_px[1]>600){
	         $data['images'][$key]['url'] =  $this->model_tool_image->resize($image['url'],ceil(600*$img_px[0]/$img_px[1]),600);
	        }else{
	            $data['images'][$key]['url'] = HTTP_Aliyoyo."image/". $image['url'];
	        }
	        }
	    	
	    }
	    $this->response->addHeader('Content-Type:application/json');
	    $this->response->setOutput(json_encode($data));
	}
	
	public function project(){
	  if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->valuedate()) {
	    $data = $this->request->post;
	    $this->load->model('project/crowdfund');
	    $json = $this->model_project_crowdfund->editProject($data);

	  }
	    $this->session->data['funding_id']=$this->request->post['funding_id'];
	    if (isset($this->error['project_name'])) {
			$this->session->data['error_name'] = $this->error['project_name'];
		} else {
			$this->session->data['error_name'] = '';
		}
	    if (isset($this->error['project_introduce'])) {
			$this->session->data['error_introduce'] = $this->error['project_introduce'];
		} else {
			$this->session->data['error_introduce'] = '';
		}
		
		if (isset($this->request->post)) {
			$this->session->data['project_name']= $this->request->post;
		} else {
			$this->session->data['project_name'] = '';
		}
		
	    $this->response->redirect($this->url->link('project/crowdfund/company','funding_id=' .$this->session->data['funding_id']).'#project');
	  
	}
	
	public function rewards(){
	  if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->valuerdate()) {
	    $data = $this->request->post;
	    $this->load->model('project/crowdfund');
	    $this->model_project_crowdfund->editRewards($data);
	  }

	    $this->session->data['funding_id']=$this->request->post['funding_id'];
	    if (!empty($this->error['reward'])) {
			$this->session->data['reward'] = $this->error['reward'];
		} else {
			$this->session->data['reward'] = '';
		}

		if (isset($this->request->post['reward'])) {
			$this->session->data['tile']= $this->request->post['reward'];
		} else {
			$this->session->data['tile'] = '';
		}
		
		if (isset($this->error['pledge_amount'])) {
			$this->session->data['pledge_amount'] = $this->error['pledge_amount'];
		} else {
			$this->session->data['pledge_amount'] = '';
		}

		$this->response->redirect($this->url->link('project/crowdfund/company','funding_id=' .$this->session->data['funding_id']).'#reward');
	}
	
	public function description(){
	  if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->valueddate()) {
	    $json = Array();
	    $data = $this->request->post;
	    $this->load->model('project/crowdfund');
	    $this->model_project_crowdfund->editDescription($data);
	  }

	    if (isset($this->error['risk_de'])) {
			$this->session->data['risk_de'] = $this->error['risk_de'];
		 } else {
			$this->session->data['risk_de'] = '';
		}
		
		if (isset($this->request->post['risk_description'])) {
			$this->session->data['ris_description']= $this->request->post['risk_description'];
		} else {
			$this->session->data['ris_description'] = '';
		}
		
	    $this->response->redirect($this->url->link('project/crowdfund/company','funding_id=' .$this->session->data['funding_id']).'#description');
	 
	}
	
	public function companyAccount(){
	    $json = Array();
	    $data = $this->request->post;
	    $this->load->model('project/crowdfund');
	    $this->model_project_crowdfund->editCompanyAccount($data);
	    $this->response->redirect($this->url->link('project/crowdfund/company','funding_id=' . $data['funding_id']).'#account');
	
	}
	public function delete_rewards(){
	    $json = Array();
	    $this->load->model('project/rewards');
	    $this->model_project_rewards->deleteReward($this->request->post['reward_id']);
	    $this->response->addHeader('Content-Type:application/json');
	    $this->response->setOutput(json_encode($json));
	}
	public function delete_shipping(){
	    $json = Array();
	    $this->load->model('project/rewards');
	    $this->model_project_rewards->deleteShipping($this->request->post['shipping_id']);
	    $this->response->addHeader('Content-Type:application/json');
	    $this->response->setOutput(json_encode($json));
	}
	
	public function review(){
	    $json = Array();
	    $this->load->model('project/crowdfund');
	    $this->model_project_crowdfund->review($this->request->post['funding_id']);
	    $this->response->addHeader('Content-Type:application/json');
	    $this->response->setOutput(json_encode($json));
	}
	public function edit(){
	    $this->load->model('project/crowdfund');
	    $this->model_project_crowdfund->edit($this->request->get['funding_id']);
	    $this->response->redirect($this->url->link('project/crowdfund/company','funding_id=' . $this->request->get['funding_id']));
	}
	
	public function publish(){
	    $this->load->model('project/crowdfund');
	    $this->model_project_crowdfund->publish($this->request->get['funding_id']);
	    $this->response->redirect($this->url->link('crowdfunding/campaign','funding_id=' . $this->request->get['funding_id']));
	}
	
	public function validate(){
	    $json = Array();
	    $this->load->model('project/crowdfund');
	    $this->load->model('project/rewards');
	    $funding_id = $this->request->post['funding_id'];
	    $data['project'] = $this->model_project_crowdfund->getCrowdFunding($funding_id);
	    $data['projectDescription'] = $this->model_project_crowdfund->getCrowdFundingDescription($funding_id);
	    $data['rewards'] = $this->model_project_rewards->getRewards($funding_id);
	    $data['companyInfo'] = $this->model_project_crowdfund->getCompanyInfo($funding_id);
	    
	    if($data['project']['name']==""||$data['project']['introduce']==""||$data['project']['total_goal']==0||$data['project']['image']==""||$data['project']['category_id']==0||$data['project']['date_start']=="0000-00-00"||$data['project']['date_ended']=="0000-00-00"){
	        $json['project'] = 1;
	    }
	    if($data['project']['viedo']==""||$data['projectDescription']['description']==""||$data['projectDescription']['risk_description']==""){
	        $json['description'] = 1;
	    }
	    foreach($data['rewards'] as $reward){
	        $shpping = $this->model_project_rewards->getRewardShipping($reward['reward_id']);
	       if($reward['name']==""||$reward['pledge_amount']==0||substr($reward['estimated_delivery'],0,4)==""||substr($reward['estimated_delivery'],5,2)==""||($reward['limit_backer_availability']==1 && $reward['limit_backer']==0)||($reward['limit_time_availability']==1 && ($reward['limit_time_begin']=="0000-00-00" || $reward['limit_time_begin']=="0000-00-00"))||$shpping['country_id']==0||$shpping['Postage']==0){
	           $json['rewards'] = 1;
	           break;
	         }
	    }
	    if($data['companyInfo']['name']==""||$data['companyInfo']['identity_image_face']==""||$data['companyInfo']['identity_image_back']==""||$data['companyInfo']['phone']==""||$data['companyInfo']['email']==""||$data['companyInfo']['businessLicence']==""||$data['companyInfo']['organizationCode']==""||$data['companyInfo']['company_name']==""||$data['companyInfo']['registeredTime']=="0000-00-00"||$data['companyInfo']['payee']==""||$data['companyInfo']['company_description']==""||$data['companyInfo']['payee_phone']==""||$data['companyInfo']['bank_card']==""||$data['companyInfo']['bank_name']==""||$data['companyInfo']['province_id']==0||$data['companyInfo']['city_id']==0||$data['companyInfo']['area_id']==0||$data['companyInfo']['address']==""){
	        $json['companyInfo'] = 1;
	    }
	    $this->response->addHeader('Content-Type:application/json');
	    $this->response->setOutput(json_encode($json));
	}
	
		protected function valuedate() {

		if (!preg_match ("/^[a-z\d\. \x21-\x7e]+$/i", $this->request->post['project_name']) && (utf8_strlen($this->request->post['project_name']) <=80 )) {
			$this->error['project_name'] = '不能包含中文字符';
		}
		
		if (!preg_match ("/^[a-z\d\. \x21-\x7e]+$/i", $this->request->post['project_introduce']) && (utf8_strlen($this->request->post['project_introduce']) <=135 )) {
			$this->error['project_introduce'] = '不能输入中文，且字符长度小于等于135';
		}


		return !$this->error;
	}
	
	protected function valuerdate() {
		foreach($this->request->post['reward'] as $k=>$v){
		  if (!preg_match ("/^[a-z\d\. \x21-\x7e]+$/i", $this->request->post['reward'][$k]['tile'])  && (utf8_strlen($this->request->post['reward'][$k]['tile']) <=135 )) {
			$this->error['reward'][] = '标题不能输入中文_'.$k;
		  }
		}
        foreach($this->request->post['reward'] as $k=>$v){		
		  if (!preg_match ("/^[a-z\d\. \x21-\x7e]+$/i", $this->request->post['reward'][$k]['description']) && (utf8_strlen($this->request->post['reward'][$k]['description']) <=135 )) {
			$this->error['pledge_amount'][] = '描述不能输入中文，且字符长度小于等于135_'.$k;
		  }
		}		
		return !$this->error;
	}
	
	protected function valueddate() { 

		if (!preg_match ("/^[a-z\d\. \x21-\x7e]+$/i", $this->request->post['risk_description']) && (utf8_strlen($this->request->post['risk_description']) <=135 )) {
			$this->error['risk_de'] = '不能输入中文，且字符长度小于等于135';
		}
		return !$this->error;
	}

}
