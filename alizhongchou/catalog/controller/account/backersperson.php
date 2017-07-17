<?php
class ControllerAccountbackersperson extends Controller {
   
	public function index() {
		if (!$this->customer->isLogged()) {
			$this->session->data['redirect'] = $this->url->link('account/backersperson', '', true);

			$this->response->redirect($this->url->link('account/login', '', true));
		}
		$this->document->addStyle('catalog/view/stylesheet/css/backersperson.css');
		
		$this->document->addScript('catalog/view/javascript/jquery/datetimepicker/moment.js');
		$this->document->addScript('catalog/view/javascript/js/profile.js');
		$this->document->addScript('catalog/view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.js');
		$this->document->addStyle('catalog/view/stylesheet/css/profile.css');
		$this->load->model('account/backersperson');
		  if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		  } else {
			$page = 1;
		  }
		  $filter_data = array(
			'start' => ($page - 1) * 15,
			'limit' => $this->config->get('config_limit_admin')
		);
        if (isset($this->request->get['src'])) {
          $name = $this->model_account_backersperson->getname($this->request->get['src']);
		  $data['name']=$name;
		  $result = $this->model_account_backersperson->getdatepage($this->request->get['src'],$filter_data);
		  $data['result']=$result;
		  $order_total = $this->model_account_backersperson->getTotalOrders($this->request->get['src']);

	    }
		$pagination = new Pagination();
		$pagination->total = $order_total;
		$pagination->page = $page;
		$pagination->limit = 15;
		$pagination->url = $this->url->link('account/backersperson', 'page={page}&src='.$this->request->get['src'],true);
		$data['pagination'] = $pagination->render();

	    $this->document->setTitle('backersperson');
		$this->document->setDescription($this->config->get('config_meta_description'));
		$this->document->setKeywords($this->config->get('config_meta_keyword'));
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');
		$data['href']= $this->request->get['src'];
		$this->response->setOutput($this->load->view('account/backersperson', $data));
	}
	
	 public function getinfo() {
		$this->load->model('account/backersperson');
		$str='';
		if (isset($this->request->get['sid']) && isset($this->request->get['href'])) {
		$arr = $this->model_account_backersperson->getchange($this->request->get['href'],$this->request->get['sid']); 
		foreach($arr as $v){
			if(!empty($v['shipping_telephone'])){
			$str.="<tr><td>".$v['shipping_firstname'].$v['shipping_lastname']."</td>".
			"<td>$".floatval($v['total'])."</td>"."<td>".$v['name']."</td>".
			"<td>".$v['shipping_country']."</td>".
			"<td>".$v['shipping_telephone']."</td>".
			"<td>".$v['email']."</td>".
			"<td>".date('Y-m-d',time($v['date_added']))."</td>".
			"<td class='center-td faeye'  onclick=fun('".$v['name']."',".$v['order_id'].") ><i class='fa fa-eye'></i></td></tr>";
			}
		}
		}
	   $str.='<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">

									</div>';
       $json['success'] = $str;
	   $this->response->setOutput(json_encode($json));
		  
	}
	
}
