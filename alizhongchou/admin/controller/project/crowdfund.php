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
		$email = isset($this->request->get['email'])?$this->request->get['email'] : '';
		$data['email']=$email;
		if (($this->request->server['REQUEST_METHOD'] == 'POST')) {
		  $add = $this->model_project_crowdfund->add($this->request->post);
          $this->response->redirect($this->url->link('catalog/reviews','token=' . $this->session->data['token'],true));
		}

	    $funding_id = isset($this->request->get['funding_id'])?$this->request->get['funding_id'] : '';
	    $info = $this->model_project_crowdfund->info($funding_id);

		$data['info'] = $info;
		$data['project'] = $this->model_project_crowdfund->getCrowdFunding($funding_id);
	    if(!empty($data['project'])){
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
	   $data['projectDescription']['description'] =  html_entity_decode($data['projectDescription']['description'], ENT_QUOTES, 'UTF-8');
	    //form validate
	    if($data['project']['viedo']==""||$data['projectDescription']['description']==""||$data['projectDescription']['risk_description']==""){
	        $data['description_form'] = 0;
	    }
	    $data['rewards'] = $this->model_project_rewards->getRewards($funding_id);//estimated_delivery
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
		//$data['index_good']  = $this->load->controller('crowdfunding/goods');
	    $data['editUrl'] = $this->url->link('project/crowdfund/edit','funding_id=' . $data['project']['funding_id']);
	    $data['action'] = $this->url->link('project/crowdfund/company', 'token=' . $this->session->data['token'] . $url, true);
		$data['funding_id'] = $this->request->get['funding_id'];
		$data['provinces'] = $this->model_localisation_region->getProvinces();
	    $data['citys'] = $this->model_localisation_region->getRegionsByProveinceCode($data['companyInfo']['province_id']);
	    $data['areas'] = $this->model_localisation_region->getRegionsByProveinceCode($data['companyInfo']['city_id']);
	    $data['categories'] = $this->model_project_category->getAllCategory();
	    $data['countries'] =  $this->model_localisation_country->getCountries();
	    $data['footer'] = $this->load->controller('common/footer');
		$data['column_left'] = $this->load->controller('common/column_left');
	    $data['header'] = $this->load->controller('common/header');
		
	    $this->response->setOutput($this->load->view('project/company',$data));
	    }else{

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
	    $path = 'project/'.$this->customer->getId().'/';
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
	    $path = 'project/'.$this->customer->getId().'/';
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
	            $data['images'][$key]['url'] = HTTP_CATALOG."image/". $image['url'];
	        }
	        }
	    	
	    }
	    $this->response->addHeader('Content-Type:application/json');
	    $this->response->setOutput(json_encode($data));
	}


}
