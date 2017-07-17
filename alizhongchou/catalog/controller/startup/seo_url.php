<?php
class ControllerStartupSeoUrl extends Controller {
  	//add by nana
	private $reset=array(
		"product_id/evaluation"=>"blog/evaluation/customer",
		"product_id/evaluation/article_id"=>"blog/evaluation/getArticle",
		"product_id/review"=>"product/product/review",
		"product_id/addevaluation"=>"blog/evaluation/toAddEvaluation",
		"product_id/quickview"=>"product/quickview",
		//"faq"=>"module/faq",
		//"pcompare"=>"product/compare",
		//"bblog"=>"blog/blog",
		//"discovery"=>"discovery/discovery",
		//"pay_express"=>"payment/pp_express/express",
		//"pay_expressConfirm"=>"payment/pp_express/expressConfirm",
		//"pay_stand_back"=>"payment/pp_standard/callback",
		//"pay_credit_back"=>"payment/creditcard/callback",
		//"activity"=>"product/activity",
		"account/userHome/c&customer_id"=>"account/userHome",
		"account/storeHome/s&customer_id"=>"account/storeHome",
		"account/collection/&collection"=>"account/collection/products",
		

	);

	private $seo=array("product"=>"product_id","article"=>'article_id');
	private $pre=array("c"=>"customer_id","s"=>"customer_id");
	private $pre_id=array("/account/collection"=>"collection");
	static $ur;

	public function index() {
		// Add rewrite to url class
		if ($this->config->get('config_seo_url')) {
			$this->url->addRewrite($this);
		}
		// Decode URL   
		
		if (isset($this->request->get['_route_'])) {
		    
		    $ul = explode(".html",$this->request->get['_route_']);
		    $parts = explode('/',$ul[0]);
		    
			// remove any empty arrays from trailing
			if (utf8_strlen(end($parts)) == 0) {
				array_pop($parts);
			}

			foreach ($parts as $k=> $part) {
				
				$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE keyword = '" . $this->db->escape($part) . "'");
             //add by nana at 2017.4.6;
				if ($query->num_rows) {
				   if(($parts[0]=='faq' || $parts[0]=='pcompare' || $parts[0]=='bblog' || $parts[0]=='discovery' || $parts[0]=='pay_express' || $parts[0]=='pay_expressConfirm' || $parts[0]=='pay_stand_back' || $parts[0]=='pay_credit_back' || $parts[0]=='activity' || $parts[0]=='contact') && $k>=1 && $parts[$k]==$query->row['keyword']){
					    $this->request->get['route'] = 'error/not_found';
						break;
				    }
					if($k>=2 && $parts[$k]==$query->row['keyword'] && strlen($parts[0])>20){ 
						$this->request->get['route'] = 'error/not_found';
						break;
								
					}else{
			        $url = explode('=', $query->row['query']);
					if(in_array($url[0],$this->seo)){
						//add by nana at 2016.10.31;
						$this->request->get[$url[0]]=$url[1];
						self::$ur.="/".$url[0];
						if(count($parts) == ($k+1)){

							self::$ur=substr(self::$ur,1);
							if(array_key_exists(self::$ur,$this->reset)){
								$this->request->get['route']= $this->reset[self::$ur];
							}
						}
					}
				    }
					if ($url[0] == 'product_id') {	
						$this->request->get['product_id'] = $url[1];
					}
					
					if ($url[0] == 'article_id') {
					    $this->request->get['article_id'] = $url[1];
					}
						
					
					if ($url[0] == 'blog_category_id') {
					    if (!isset($this->request->get['path'])) {
					        $this->request->get['path'] = $url[1];
					    } else {
					        if($this->request->get['path']){
					            $this->request->get['path'] .= '_' . $url[1];
					        }else{
					           $this->request->get['path'] .= $url[1];
					        }
					    }
					}

					if ($url[0] == 'category_id') {
						if (!isset($this->request->get['path'])) {
							$this->request->get['path'] = $url[1];
						} else {
							$this->request->get['path'] .= '_' . $url[1];
						}
					}
					if ($url[0] == 'manufacturer_id') {
						$this->request->get['manufacturer_id'] = $url[1];
					}

					if ($url[0] == 'information_id') {
						$this->request->get['information_id'] = $url[1];
					}
					
					if ($url[0] == 'information_contact_id') {
					    $this->request->get['information_contact_id'] = $url[1];
					}
					if ($url[0] == 'module_faq_id') {
					    $this->request->get['module_faq_id'] = $url[1];
					}
					if ($url[0] == 'product_compare_id') {
					    $this->request->get['product_compare_id'] = $url[1];
					}
					if ($url[0] == 'blog_blog_id') {
					    $this->request->get['blog_blog_id'] = $url[1];
					}
					if ($url[0] == 'blog_blog_id') {
					    $this->request->get['blog_blog_id'] = $url[1];
					}
					if ($url[0] == 'discovery_discovery_id') {
					    $this->request->get['discovery_discovery_id'] = $url[1];
					}
					if ($url[0] == 'payment_pp_express_expressConfirm_id') {
					    $this->request->get['payment_pp_express_expressConfirm_id'] = $url[1];
					}if ($url[0] == 'payment_pp_standard_callback_id') {
					    $this->request->get['payment_pp_standard_callback_id'] = $url[1];
					}
					if ($url[0] == 'payment_creditcard_callback_id') {
					    $this->request->get['payment_creditcard_callback_id'] = $url[1];
					}
					if ($url[0] == 'activity') {
					    $this->request->get['activity'] = $url[1];
					}
					/*if ($url[0] == 'product_product_review_id') {
					    $this->request->get['product_product_review_id'] = $url[1];
					}*/
					if ($url[0] == 'blog_evaluation_getArticle_id') {
					    $this->request->get['blog_evaluation_getArticle_id'] = $url[1];
					}
					/*if ($url[0] == 'blog_evaluation_customer_id') {
					    $this->request->get['blog_evaluation_customer_id'] = $url[1];
					}*/

					if ($query->row['query'] && $url[0] != 'information_id' && $url[0] != 'manufacturer_id' && $url[0] != 'category_id' && $url[0] != 'product_id'&& $url[0] != 'blog_category_id' && $url[0] != 'article_id' && $url[0] !='information_contact_id' && $url[0] !='module_faq_id'&& $url[0] !='product_compare_id' && $url[0] !='blog_blog_id' && $url[0] !='discovery_discovery_id'
						&& $url[0] !='payment_pp_express_expressConfirm_id' && $url[0] !='payment_pp_standard_callback_id'  && $url[0] !='payment_creditcard_callback_id'
						&& $url[0] !='activity'/* && $url[0] !='product_product_review_id' */&& $url[0] !='blog_evaluation_getArticle_id' /*&& $url[0]!='blog_evaluation_customer_id'*/ ) {
						$this->request->get['route'] = $query->row['query'];
					}
				}else {
					if(array_key_exists($part,$this->seo)){
						self::$ur.="/".$this->seo[$part];
					}else{
						foreach (array_keys($this->pre) as $per){
							if(strpos($part,$per)===0){
								if(is_numeric(str_replace($per,null,$part))){
									$a=$per."&".$this->pre[$per];
									$this->request->get[$this->pre[$per]] =(int) str_replace($per,null,$part);
								}
							};
						}
						
						if(isset($a)){
							self::$ur.="/".$a;
						}else{
							if(in_array(self::$ur,array_keys($this->pre_id))&&is_numeric($part)){
								$this->request->get[$this->pre_id[self::$ur]] =(int) $part;
								self::$ur.="/&".$this->pre_id[self::$ur];
							}else{
								self::$ur.="/".$part;
							}

						}

					}
                    
					if(count($parts) == ($k+1)){

						self::$ur=substr(self::$ur,1);
						//echo self::$ur;
						if(array_key_exists(self::$ur,$this->reset)){
							$this->request->get['route']= $this->reset[self::$ur];
						}else{
							$this->request->get['route'] = 'error/not_found';
							break;
						}
					}
				}
				
			}
			
			 if($parts[0]=="product_search"){
			   $this->request->get['route'] = "product/search";
			   
			}
			
			if($parts[0]=="home"){
			    
			        $this->request->get['route'] = "common/home";
			    
			
			}
			
			
			if($parts[0]=="checkout"|| ($parts[0]=="account" && $this->request->get['route']=="error/not_found")){
			    $this->request->get['route']= $this->request->get['_route_'];
			}
			
			if (!isset($this->request->get['route'])) {
				if (isset($this->request->get['product_id'])) {
					$this->request->get['route'] = 'product/product';
				} elseif (isset($this->request->get['article_id'])) {
					$this->request->get['route'] = 'blog/article';
				}
				elseif ($parts[0] != 'blog' && isset($this->request->get['path'])) {
					$this->request->get['route'] = 'product/category';
				} elseif (isset($this->request->get['manufacturer_id'])) {
					$this->request->get['route'] = 'product/manufacturer/info';
				} elseif (isset($this->request->get['information_id'])) {
					$this->request->get['route'] = 'information/information';
				} elseif ($parts[0] == 'blog' && isset($this->request->get['path'])) {
					$this->request->get['route'] = 'blog/blog';
				}elseif (isset($this->request->get['information_contact_id'])) {
				    $this->request->get['route'] = 'information/contact';
				}elseif (isset($this->request->get['module_faq_id'])) {
				    $this->request->get['route'] = 'module/faq';
				}elseif (isset($this->request->get['product_compare_id'])) {
				    $this->request->get['route'] = 'product/compare';
				}elseif (isset($this->request->get['blog_blog_id'])) {
				    $this->request->get['route'] = 'blog/blog';
				}elseif (isset($this->request->get['discovery_discovery_id'])) {
				    $this->request->get['route'] = 'discovery/discovery';
				}elseif (isset($this->request->get['payment_pp_express_expressConfirm_id'])) {
				    $this->request->get['route'] = 'payment/pp_express/expressConfirm';
				}elseif (isset($this->request->get['payment_pp_standard_callback_id'])) {
				    $this->request->get['route'] = 'payment/pp_standard/callback';
				}elseif (isset($this->request->get['payment_creditcard_callback_id'])) {
				    $this->request->get['route'] = 'payment/creditcard/callback';
				}elseif (isset($this->request->get['activity'])) {
				    $this->request->get['route'] = 'product/activity';
				}/*elseif (isset($this->request->get['product_product_review_id'])) {
				    $this->request->get['route'] = 'product/product/review';
				}*/elseif (isset($this->request->get['blog_evaluation_getArticle_id'])) {
				    $this->request->get['route'] = 'blog/evaluation/getArticle';
				}/*elseif (isset($this->request->get['blog_evaluation_customer_id'])) {
				    $this->request->get['route'] = 'blog/evaluation/customer';
				}*/
			}
			if (isset($this->request->get['route'])) {
				return new Action($this->request->get['route']);
			}
		}
	}
	
	public function rewrite($link) {
		
		$url_info = parse_url(str_replace('&amp;', '&', $link));
		$url = '';
         //$query = $this->db->query("SELECT  keyword FROM oc_url_alias");
        // $arr=$query->rows;
         //$last_names = array_column($arr, 'keyword');
       // print_r($last_names);
		parse_str($url_info['query'], $data);
		$seo_url=explode("/", $data['route']);

		foreach ($data as $key => $value) {
		    if (isset($data['route'])) {
		    	//START
				if (in_array($data['route'],$this->reset)){
					//add by nana at 2016.10.31 
					self::$ur ="";
					$new_url=explode('/',array_search($data['route'],$this->reset));
					foreach ($new_url as $new){
						if(in_array($new,$this->seo)){
							$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE `query` = '" . $this->db->escape($new . '=' . (int)$data[$new]) . "'");
							if ($query->num_rows && $query->row['keyword']) {
								self::$ur.="/".$query->row['keyword'];
								unset($data[$new]);
							}else{
								self::$ur.="/".array_search($new,$this->seo);
							}
						}elseif (strpos("$new","&")!==false){
							$pinjie=explode('&',$new);
							$a="";
							foreach ($pinjie as $pin){
								if(isset($data[$pin])){
									$a.="$data[$pin]";
									unset($data[$pin]);
								}else{
									if(array_key_exists($pin,$this->pre)){
										if(isset($data[$this->pre[$pin]])){
											$a.=$pin;
										}
									}
								}
							}
							self::$ur.=empty($a)? null:"/".$a;
						}else{
							self::$ur.="/".$new;
						}
					}
					$url.=self::$ur;
					unset($data[$key]);
				}
				//END
				elseif (($data['route'] == 'product/product' && $key == 'product_id') || (($data['route'] == 'product/manufacturer/info' || $data['route'] == 'product/product') && $key == 'manufacturer_id') ) {
					
				    $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE `query` = '" . $this->db->escape($key . '=' . (int)$value) . "'");
					if ($query->num_rows && $query->row['keyword']) {
						$url .= '/' . $query->row['keyword'].".html";
						
						unset($data[$key]);
					}
				}
				elseif ($data['route']=="common/home"){
				    $url ='/' . "home";
				    unset($data[$key]);
				
				
				}
				
				
				elseif ($seo_url[0]=="checkout"||$seo_url[0]=="account"){
				    $url ='/'.$data['route'];
					if(isset($url_info['fragment'])){
						$url .="#".$url_info['fragment'];
					}
				    unset($data[$key]);
				
				}
				
				elseif ( ($data['route'] == 'information/information' && $key == 'information_id')){
				    $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE `query` = '" . $this->db->escape($key . '=' . (int)$value) . "'");
				    if ($query->num_rows && $query->row['keyword']) {
				        $url .= '/' . $query->row['keyword'];
				        unset($data[$key]);
				    }
				    
				} 
				
				elseif ( ($data['route'] == 'blog/article' && $key == 'article_id')) {
				    if($url==''){
				        $url='/blog';
				    }
					$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE `query` = '" . $this->db->escape($key . '=' . (int)$value) . "'");
					if ($query->num_rows && $query->row['keyword']) {
						$url .= '/' . $query->row['keyword'].".html";
						unset($data[$key]);
					}
				}
 
				 elseif (($data['route'] == 'blog/blog' && $key == 'path')||($data['route'] == 'blog/article' && $key == 'path')) {
				      
					$categories = explode('_', $value);
					$url = '/blog';
					foreach ($categories as $category) {
						$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE `query` = 'blog_category_id=" . (int)$category . "'");

						if ($query->num_rows && $query->row['keyword']) {
							$url .= '/' . $query->row['keyword'];
						} else {
							$url = '';

							break;
						}
					}
					unset($data[$key]);
				}
				
				elseif (($data['route'] == 'product/category' && $key == 'path')||($data['route'] == 'product/product' && $key == 'path')) {
					$categories = explode('_', $value);

					foreach ($categories as $category) {
						$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE `query` = 'category_id=" . (int)$category . "'");

						if ($query->num_rows && $query->row['keyword']) {
							$url .= '/' . $query->row['keyword'];
						} else {
							$url = '';

							break;
						}
					}

					unset($data[$key]);
				}
				
				
			}
		}
		   
		if ($url) {
			unset($data['route']);
			$query = '';

			if ($data) {
				foreach ($data as $key => $value) {
					$query .= '&' . rawurlencode((string)$key) . '=' . rawurlencode((is_array($value) ? http_build_query($value) : (string)$value));
				}

				if ($query) {
					$query = '?' . str_replace('&', '&amp;', trim($query, '&'));
				}
			}

			return $url_info['scheme'] . '://' . $url_info['host'] . (isset($url_info['port']) ? ':' . $url_info['port'] : '') . str_replace('/index.php', '', $url_info['path']) . $url . $query;
		} else {
			return $link;
		}
	}
}
