<?php
abstract class Controller {
	protected $registry;

	public function __construct($registry) {
	    // add by yagami s3 20161206 begin
	    if (version_compare(VERSION, '2.0.3.1', '<=')) {
	        $registry->get('load')->library('amazons3');
	    }
	    $amazons3 = new AmazonS3($registry);
	    $registry->set('amazons3', $amazons3);
	    // add by yagami s3 20161206 end
	    	  
		$this->registry = $registry;
	}

	public function __get($key) {
		return $this->registry->get($key);
	}

	public function __set($key, $value) {
		$this->registry->set($key, $value);
	}
}