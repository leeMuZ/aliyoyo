<?php
class ModelAccountapplyforrefund extends Model {
	
	//add by liuxuewen at 20170408 获取订单信息
	public function addReturn($data,$pro) {
		$this->db->query("INSERT INTO ".DB_PREFIX."return SET return_status_id = '" . (int)$data['return_status_id']  . "', customer_id = '" . (int)$this->customer->getId(). "', comment = '" . $this->db->escape($data['comment'])."', order_id = '" .(int)$pro['order_id']."', rewards_id = '" . (int)$pro['rewards_id']."', crowdfunding_name = '" .$this->db->escape($pro['crowdfunding_name'])."', rewards_name = '" . $this->db->escape($pro['name'])."', firstname = '" . $this->db->escape($pro['firstname'])."', lastname = '" . $this->db->escape($pro['lastname'])."', email = '" . $this->db->escape($pro['email'])."', telephone = '" .$pro['telephone']."', date_added = NOW(), date_modified = NOW()");
		$return_id = $this->db->getLastId();
		$this->db->query("UPDATE ".DB_PREFIX."order SET order_status_id = '4' WHERE order_id = '".$pro['order_id']."'");

		return $return_id;
	}
     //add by liuxuewen at 20170412 获取退款部分信息
    public function getpro($url) {
		$query = $this->db->query("SELECT a.order_id,c.rewards_id,c.name,c.crowdfunding_name FROM ".DB_PREFIX."order as a left join ".DB_PREFIX."order_total as b on b.order_id=a.order_id
                                     left join ".DB_PREFIX."crowdfunding_rewards as c on c.rewards_id=b.rewards_id 
									 left join ".DB_PREFIX."crowdfunding as d on d.funding_id=c.funding_id 
                                     WHERE a.order_id=".$url." and  a.customer_id = " . (int)$this->customer->getId());
         
		return $query->rows;
	}	
	//add by liuxuewen at 20170412 退款信息
    public function getxinxi($url) {
		$query = $this->db->query("SELECT a.order_id,a.total,b.shipping_price FROM ".DB_PREFIX."order as a left join ".DB_PREFIX."order_total as b on b.order_id=a.order_id                                    
                                     WHERE a.order_id=".$url." and a.customer_id = " . (int)$this->customer->getId());
		return $query->rows;
	}
	//add by liuxuewen at 20170412 获取会员信息
		public function getcustomer() {
        $query = $this->db->query("SELECT firstname,lastname,email,telephone FROM " . DB_PREFIX . "customer   WHERE customer_id = '" . (int)$this->customer->getId() . "'");

		return $query->rows;
	}

}
