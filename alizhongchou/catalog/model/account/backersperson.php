<?php
class ModelAccountbackersperson extends Model {
	
	//add by liuxuewen at 20170408 获取订单信息
	public function getdatepage($id,$data) {
			if (isset($data['start']) || isset($data['limit'])) {
			if ($data['start'] < 0) {
				$data['start'] = 0;
			}

			if ($data['limit'] < 1) {
				$data['limit'] = 15;
			}
		}

		$query = $this->db->query("SELECT  a.name,c.shipping_firstname,c.shipping_lastname,c.shipping_country,c.shipping_telephone,c.email,c.date_added,c.total,c.order_id FROM ".DB_PREFIX."crowdfunding_rewards as a left join ".DB_PREFIX."order_total as b on b.rewards_id=a.rewards_id
                                     left join ".DB_PREFIX."order as c on c.order_id=b.order_id where a.funding_id=".$id." order by c.order_id desc limit ".(int)$data['start'] . "," . (int)$data['limit']);
         
		return $query->rows;
	}
	
		public function getTotalOrders($id) {

         $query = $this->db->query("SELECT  COUNT(*) AS total FROM ".DB_PREFIX."crowdfunding_rewards as a left join ".DB_PREFIX."order_total as b on b.rewards_id=a.rewards_id
                                     left join ".DB_PREFIX."order as c on c.order_id=b.order_id where a.funding_id=".$id);        
		 return $query->row['total'];
	}
		public function getname($id) {

         $query = $this->db->query("SELECT rewards_id,name FROM ".DB_PREFIX."crowdfunding_rewards where funding_id=".$id);        
		 return $query->rows;
	}
	
		public function getchange($data,$id) {

		$query = $this->db->query("SELECT  a.name,c.shipping_firstname,c.shipping_lastname,c.shipping_country,c.shipping_telephone,c.email,c.date_added,c.total,c.order_id FROM ".DB_PREFIX."crowdfunding_rewards as a left join ".DB_PREFIX."order_total as b on b.rewards_id=a.rewards_id
                                     left join ".DB_PREFIX."order as c on c.order_id=b.order_id where a.funding_id=".$data." AND a.rewards_id=".$id." AND a.rewards_id=".$id);
         
		return $query->rows;
	}

}
