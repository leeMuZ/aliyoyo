<?php
class ModelAccountdatepage extends Model {
	
	//add by liuxuewen at 20170408 获取订单信息
	public function getdatepage($data) {

		$query = $this->db->query("SELECT  a.name,c.shipping_firstname,c.shipping_lastname,c.shipping_country,c.shipping_telephone,c.email,c.date_added,c.total,c.order_id FROM ".DB_PREFIX."crowdfunding_rewards as a left join ".DB_PREFIX."order_total as b on b.rewards_id=a.rewards_id
                                     left join ".DB_PREFIX."order as c on c.order_id=b.order_id where a.funding_id=".$data." order by c.order_id desc limit 10");
         
		return $query->rows;
	}
	
		public function getone($id) {

		$query = $this->db->query("SELECT shipping_firstname,shipping_lastname,shipping_country,shipping_telephone,email,date_added,total,order_id,shipping_address_1,shipping_address_2,shipping_city FROM ".DB_PREFIX."order WHERE order_id=".$id);
         
		return $query->rows;
	}
	    public function getadd($data) {
		  $this->db->query("INSERT INTO ".DB_PREFIX."crowdfunding_updates SET funding_id = '" .$data['funding_id']."', title = '" . $this->db->escape($data['title'])."', content = '" .$data['content']."',post_type = '" .(int)$this->db->escape($data['post_type'])."',date_added = NOW()");
          return $query->rows;
	
		}
		
		public function getupdate($id) {
			
		  $query = $this->db->query("SELECT update_id,title,content,post_type from ".DB_PREFIX."crowdfunding_updates WHERE funding_id=".$id);
          return $query->rows;
			
		}
		
		public function getchange($data) {
			
		  $this->db->query("UPDATE ".DB_PREFIX."crowdfunding_updates SET title = '" . $this->db->escape($data['title'])."', content = '" .$data['content']."', post_type = '" .(int)$this->db->escape($data['post_type'])."',date_added = NOW() WHERE update_id=".$data['update_id']);
          $return_id = $this->db->getLastId();
		  return $return_id;
			
		}


}
