<?php
class ControllerAccountLogout extends Controller {
	private $error = array();

	public function index() {

	    if ($this->customer->isLogged()) {
	        $this->customer->logout();
	    }
	    $this->response->redirect($this->url->link('common/home', '', true));
	}
	
}
