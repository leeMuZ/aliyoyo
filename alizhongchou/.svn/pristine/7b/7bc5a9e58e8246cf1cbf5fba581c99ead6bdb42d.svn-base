<?php
class ControllerAccountdatepage extends Controller {
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
	}
	public function index() {
		if (!$this->customer->isLogged()) {
			$this->session->data['redirect'] = $this->url->link('account/datepage', '', true);

			$this->response->redirect($this->url->link('account/login', '', true));
		}
		if (isset($this->session->data['success'])) {
		    $data['success'] = $this->session->data['success'];
		
		    unset($this->session->data['success']);
		} else {
		    $data['success'] = '';
		}
		 $this->document->addStyle('catalog/view/stylesheet/css/datapage.css');
		 $this->document->addStyle('catalog/view/javascript/summernote/summernote.css');
		 $this->load->model('account/datepage');
		
          if (isset($this->request->get['url'])) {
			 $result = $this->model_account_datepage->getdatepage($this->request->get['url']);
			 $update = $this->model_account_datepage->getupdate($this->request->get['url']);
		      
			 $data['result']=$result;
			 $arr=array();
			 foreach($update as $v){
				 $arr['update_id']=$v['update_id'];
				 $arr['title']=$v['title'];
				 $arr['content']=$v['content'];
				 $arr['post_type']=$v['post_type'];
			 }
			 $data['update']=$arr;
		  }
        $data['src']= $this->request->get['url'];

		//提交update详情
        if (($this->request->server['REQUEST_METHOD'] == 'POST')) {
			  $result = $this->model_account_datepage->getadd($this->request->post);		
			  $this->session->data['success'] = $this->language->get('text_success');
			  $this->response->redirect($this->url->link('account/datepage', '&url='.$this->request->post['funding_id'], true));
	    }
	    $this->document->setTitle('datapage');
		$this->document->setDescription($this->config->get('config_meta_description'));
		$this->document->setKeywords($this->config->get('config_meta_keyword'));
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');
		$data['href']= $this->url->link('account/backersperson');
		$data['src']= $this->request->get['url'];
		$data['action'] = $this->url->link('account/datepage', '', true);
		$this->response->setOutput($this->load->view('account/datepage', $data));
	}
	
		public function info() {
		$this->load->model('account/datepage');
		$str='';
		if (isset($this->request->get['oid']) && isset($this->request->get['rel'])) {
		$arr = $this->model_account_datepage->getone($this->request->get['oid']); 
		foreach($arr as $v){
			$str.="<div class='modal-dialog eyedialog' role='document'>
									    	<div class='modal-content'>
									      		<div class='modal-header'>
									        		<button type='button' class='close' data-dismiss='modal' aria-label='Close'>
									        			<span aria-hidden='true'>
									        				<i class='fa fa-close'></i>
									        			</span>
									        		</button>
									       			<h4 class='modal-title' id='myModalLabel'>View supporters information</h4>
									      		</div>
										        <div class='modal-body'>
										        	<p class='pxinxi'>
										        		<span class='spanicon'>
										        			<i class='fa fa-user'></i>Name：
										        		</span>
										        		<span>". $v['shipping_firstname'].$v['shipping_lastname']."</span>
										        	</p>
										        	<p class='pxinxi'>
										        		<span class='spanicon'>
										        			<i class='fa fa-money'></i>Money：
										        		</span>
										        		<span>$". floatval($v['total'])."</span>
										        	</p>
										        	<p class='pxinxi'>
										        		<span class='spanicon'>
										        			<i class='fa fa-tag'></i>Type：
										        		</span>
										        		<span>".$this->request->get['rel']."</span>
										        	</p>
										        	<p class='pxinxi'>
										        		<span class='spanicon'>
										        			<i class='fa fa-map-marker'></i>Phone：
										        		</span>
										        		<span>".$v['shipping_telephone']."</span>
										        	</p>
										        	<p class='pxinxi'>
										        		<span class='spanicon'>
										        			<i class='fa fa-phone'></i>Email：
										        		</span>
										        		<span>".$v['email']."</span>
										        	</p>
										        	<p class='pxinxi'>
										        		<span class='spanicon'>
										        			<i class='fa fa-envelope'></i>Date：
										        		</span>
										        		<span>".$v['date_added']."AM</span>
										        	</p>
										        	<p class='pxinxi'>
										        		<span class='spanicon'>
										        			<i class='fa fa-calendar'></i>Location：
										        		</span>
										        		<span><i class='redmap'></i>".$v['shipping_address_1'].','.$v['shipping_address_2'].','.$v['shipping_city'].','.$v['shipping_country']."</span>
										        	</p>
										        </div>
											</div>
									  	</div>";
		}
		}
       $json['success'] = $str;
	   $this->response->setOutput(json_encode($json));
		  
	}
}
