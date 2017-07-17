<?php
class ControllerAccountassortment extends Controller {
   
	public function index() {

		$this->load->model('account/assortment');
		$data['src1']='';
		$data['name']='';
		$data['rname']='';
		$data['surl']='';
		$data['rurl']='';
		$data['sname']='';
		 if (!empty($this->request->get['url'])) {
			 $arr=$this->model_account_assortment->getcategory($this->request->get['url']);
			 $data['arr'] = $arr;
			 $name=$this->model_account_assortment->getname($this->request->get['url']);
			 $data['name'] = $name;
			 $result=$this->model_account_assortment->getproducts($this->request->get['url']);
			 $data['result'] = $result;
			  
				  if(!empty($this->request->get['surl'])){
					  $data['surl']=$this->request->get['surl'];
					  $data['rname'] = $this->request->get['rname'];
					  $result=$this->model_account_assortment->getproducte($this->request->get['url'],$this->request->get['surl']);		
					  $data['result'] = $result;
				      if(!empty($this->request->get['rurl'])){
				         $data['rurl']= $this->request->get['rurl'];
						 $data['sname'] = $this->request->get['sname'];
						 $result=$this->model_account_assortment->getproductr($this->request->get['url'],$this->request->get['surl'],$this->request->get['rurl']);
						 $data['result'] = $result;

				     }
				  }else{
					  if(!empty($this->request->get['rurl'])){
				         $data['rurl']= $this->request->get['rurl'];
						 $data['sname'] = $this->request->get['sname'];
						 $result=$this->model_account_assortment->getproductf($this->request->get['url'],$this->request->get['rurl']);
						 $data['result'] = $result;					     
					  }
				  }

				  
		      }else{
				 $arr=$this->model_account_assortment->getcategory($this->request->get['url']);
			     $data['arr'] = $arr;
			     $name=$this->model_account_assortment->getname($this->request->get['url']);
			     $data['name'] = $name;
				 $result=$this->model_account_assortment->getproducts($this->request->get['url']);
			     $data['result'] = $result;
				 if(!empty($this->request->get['surl'])){
                     $data['rname'] = $this->request->get['rname'];
					 $data['surl']=$this->request->get['surl'];
					 $result=$this->model_account_assortment->getproducta($this->request->get['surl'],$this->request->get['url']); 
					 $data['result'] = $result;

					 if(!empty($this->request->get['rurl'])){
                     $data['sname'] = $this->request->get['sname'];
					 $data['rurl']=$this->request->get['rurl'];
					 $result=$this->model_account_assortment->getproductd($this->request->get['surl'],$this->request->get['rurl'],$this->request->get['url']); 
					 $data['result'] = $result;				 

				     }
				 }else{
					 if(!empty($this->request->get['rurl'])){
                      $data['sname'] = $this->request->get['sname'];
					  $data['rurl']=$this->request->get['rurl'];
					  $result=$this->model_account_assortment->getproductj($this->request->get['rurl']); 
					  $data['result'] = $result;	
					 }
				 }

			}
		$this->document->addStyle('catalog/view/stylesheet/individual.css');
		$this->document->addStyle('catalog/view/stylesheet/assortment.css');

	    $this->document->setTitle($this->config->get('config_meta_title'));
		$this->document->setDescription($this->config->get('config_meta_description'));
		$this->document->setKeywords($this->config->get('config_meta_keyword'));
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');
		$data['src'] = $this->url->link('account/assortment');
		$data['href'] = $this->url->link('crowdfunding/campaign');
		$data['url'] = $this->request->get['url'];
        
		$this->response->setOutput($this->load->view('account/assortment', $data));
	}
}
