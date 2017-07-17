<?php
class ControllerLocationLocation extends Controller {
	private $error = array();

	public function index(){
        $json=array();
  	    $this->load->model('localisation/region');
  	    $json['location'] = $this->model_localisation_region->getRegionsByProveinceCode($this->request->post['code']);
  	    $this->response->addHeader('Content-Type: application/json');
  	    $this->response->setOutput(json_encode($json));
	}
	
	public function getCountries(){
	    $json=array();
	    $this->load->model('localisation/country');
	    $json['countries'] = $this->model_localisation_country->getCountries();
	    $this->response->addHeader('Content-Type: application/json');
	    $this->response->setOutput(json_encode($json));
	}
	
	
	

}
