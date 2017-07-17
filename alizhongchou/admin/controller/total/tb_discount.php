<?php 
error_reporting(E_ALL);
ini_set('display_errors', 'on');
class ControllerTotalTbDiscount extends Controller { 
	private $error = array(); 
	 
	public function index() {
            
                                    $this->language->load('total/tb_discount');
		

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('setting/setting');
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && ($this->validate())) {
			$this->model_setting_setting->editSetting('tb_discount', $this->request->post);
		
			$this->session->data['success'] = $this->language->get('text_success');
			
			$this->response->redirect($this->url->link('extension/total', 'token=' . $this->session->data['token'], 'SSL'));
		}
		
		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');
		$data['text_edit'] = $this->language->get('text_edit');
		
		$data['entry_heading'] = $this->language->get('entry_heading');
		$data['entry_status'] = $this->language->get('entry_status');
		$data['entry_sort_order'] = $this->language->get('entry_sort_order');
                				
		$data['entry_discount_type'] = $this->language->get('entry_discount_type');		
		
                                      $data['entry_percentage'] = $this->language->get('entry_percentage');
                                      $data['entry_quantity'] = $this->language->get('entry_quantity');
		$data['entry_discount'] = $this->language->get('entry_discount');
					
		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');
                
                                    $this->load->model('localisation/language');
                                    $data['languages'] = $this->model_localisation_language->getLanguages();

 		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

   		$data['breadcrumbs'] = array();

   		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_total'),
			'href'      => $this->url->link('extension/total', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
   		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('total/tb_discount', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
		$data['action'] = $this->url->link('total/tb_discount', 'token=' . $this->session->data['token'], 'SSL');
		
		$data['cancel'] = $this->url->link('extension/total', 'token=' . $this->session->data['token'], 'SSL');

		if (isset($this->request->post['tb_discount_heading'])) {
			$data['tb_discount_heading'] = $this->request->post['tb_discount_heading'];
		} else {
			$data['tb_discount_heading'] = $this->config->get('tb_discount_heading');
		}

		if (isset($this->request->post['tb_discount_status'])) {
			$data['tb_discount_status'] = $this->request->post['tb_discount_status'];
		} else {
			$data['tb_discount_status'] = $this->config->get('tb_discount_status');
		}

		if (isset($this->request->post['tb_discount_sort_order'])) {
			$data['tb_discount_sort_order'] = $this->request->post['tb_discount_sort_order'];
		} else {
			$data['tb_discount_sort_order'] = $this->config->get('tb_discount_sort_order');
		}
		
		if (isset($this->request->post['tb_discount_type'])) {
			$data['tb_discount_type'] = $this->request->post['tb_discount_type'];
		} else {
			$data['tb_discount_type'] = $this->config->get('tb_discount_type');
		}
		
                                    	if (isset($this->request->post['tb_discount_rate'])) {
				$data['tb_discount_rates'] = $this->request->post['tb_discount_rate'];
			} elseif($this->config->get('tb_discount_rate')) {
				$data['tb_discount_rates'] = $this->config->get('tb_discount_rate');
			}else{ 
                                                                            $data['tb_discount_rates'] = array("from"=>array(""),"to"=>array(""),"charge"=>array(""));
                                                        }	
                
		
                		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('total/tb_discount.tpl', $data));
	}

	private function validate() {
		if (!$this->user->hasPermission('modify', 'total/tb_discount')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}		                                       
                
                                       if($this->request->post['tb_discount_type'] == 0){
                                           $rates = $this->request->post['tb_discount_rate'];
                                           foreach($rates['charge'] as $charge){                                           
                                               if($charge > 100){ 
                                               $this->error['warning'] = $this->language->get('error_percentage_charge');
                                           }
                                           }
                                       }else{
                                            $rates = $this->request->post['tb_discount_rate'];
                                            foreach($rates['charge'] as $key => $charge){    
                                                if($charge > $rates['from'][$key]){
                                                     $this->error['warning'] = $this->language->get('error_value_charge');
                                                }
                                            }
                                          
                                       }
                                       
                                       $rates = $this->request->post['tb_discount_rate'];
                                       foreach($rates['charge'] as $key=>$charge){
                                           if(!is_numeric($charge) || !is_numeric($rates['from'][$key]) || !is_numeric($rates['to'][$key])){
                                                 $this->error['warning'] = $this->language->get('error_not_numeric');
                                           }
                                       }
                                      
		if (!$this->error) {
			return true;
		} else {
			return false;
		}	
	}
}
?>