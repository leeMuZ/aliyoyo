<?php
class ModelAccountHomepage extends Model {
	
	//add by liuxuewen at 20170706
	 public function getproduct($data,$uid) {
        if (isset($data['start']) || isset($data['limit'])) {
			if ($data['start'] < 0) {
				$data['start'] = 0;
			}

			if ($data['limit'] < 1) {
				$data['limit'] = 1;
			}
		}
	    $query = $this->db->query("SELECT * FROM ". DB_PREFIX ."product where customer_id=".$uid." limit ". (int)$data['start'] . "," . (int)$data['limit']);
		return $query->rows;
	}
	public function getTotalproduct($uid) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM ".DB_PREFIX."product WHERE customer_id = ".$uid);

		return $query->row['total'];
	}
	
	//add by liuxuewen at 20170706
	 public function getcategory() {
        $query = $this->db->query("SELECT d.name,d.model_category_id FROM " . DB_PREFIX . "product as a left join " . DB_PREFIX . "product_image as b on a.product_id=b.product_id
                                     left join " . DB_PREFIX . "model as c on b.model_id=c.model_id 
									 left join " . DB_PREFIX . "model_category as d on d.model_category_id=c.model_category_id
                                     WHERE a.customer_id = '" . (int)$this->customer->getId() . "'");
        $category=array();
		foreach($query->rows as $k=>$v){
			        $querys = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "product as a left join " . DB_PREFIX . "product_image as b on a.product_id=b.product_id
                                     left join " . DB_PREFIX . "model as c on b.model_id=c.model_id 
                                     WHERE c.model_category_id=".$v['model_category_id']." and a.customer_id = '" . (int)$this->customer->getId() . "'");
		 $category[$k][]=$v['name'];
		 $category[$k][]=$v['model_category_id'];		
		 $category[$k][]=$querys->row['total'];
		}
        return $category;
	}
	
	//add by liuxuewen at 20170706 分类
	 public function getproducts($data,$cid) {
        if (isset($data['start']) || isset($data['limit'])) {
			if ($data['start'] < 0) {
				$data['start'] = 0;
			}

			if ($data['limit'] < 1) {
				$data['limit'] = 1;
			}
		}
        $query = $this->db->query("SELECT a.name,a.product_image,a.price FROM " . DB_PREFIX . "product as a left join " . DB_PREFIX . "product_image as b on a.product_id=b.product_id
                                     left join " . DB_PREFIX . "model as c on b.model_id=c.model_id 
                                     WHERE c.model_category_id=".$cid." and a.customer_id = " . (int)$this->customer->getId()." limit ". (int)$data['start'] . "," . (int)$data['limit']);

        return $query->rows;
	}
	//add by liuxuewen at 20170707 分类数目
	 public function getTotalcategory($cid) {
        $query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "product as a left join " . DB_PREFIX . "product_image as b on a.product_id=b.product_id
                                     left join " . DB_PREFIX . "model as c on b.model_id=c.model_id 
                                     WHERE c.model_category_id=".$cid." and a.customer_id = '" . (int)$this->customer->getId() . "'");

        return $query->row['total'];
	}
    //add by liuxuewen at 20170707 排序
	 public function getsort($data,$id) {
        if (isset($data['start']) || isset($data['limit'])) {
			if ($data['start'] < 0) {
				$data['start'] = 0;
			}

			if ($data['limit'] < 1) {
				$data['limit'] = 1;
			}
		}
		if($id=='desc'){
	    $query = $this->db->query("SELECT * FROM ". DB_PREFIX ."product where customer_id=".$this->customer->getId()." order by price desc limit ". (int)$data['start'] . "," . (int)$data['limit']);
		}
		return $query->rows;
	}
	
	//add by liuxuewen at 20170706 分类 + 排序
	 public function getcate_sort($data,$cid,$sid) {
        if (isset($data['start']) || isset($data['limit'])) {
			if ($data['start'] < 0) {
				$data['start'] = 0;
			}

			if ($data['limit'] < 1) {
				$data['limit'] = 1;
			}
		}
		if($sid=='desc'){
          $query = $this->db->query("SELECT a.name,a.product_image,a.price FROM " . DB_PREFIX . "product as a left join " . DB_PREFIX . "product_image as b on a.product_id=b.product_id
                                     left join " . DB_PREFIX . "model as c on b.model_id=c.model_id 
                                     WHERE c.model_category_id=".$cid." and a.customer_id = " . (int)$this->customer->getId()." order by price desc limit ". (int)$data['start'] . "," . (int)$data['limit']);
        }
        return $query->rows;
	}
}
