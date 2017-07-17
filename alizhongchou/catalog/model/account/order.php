<?php
class ModelAccountorder extends Model {
	
	//add by liuxuewen at 20170408 获取订单信息
	public function getorder($data) {
		if (isset($data['start']) || isset($data['limit'])) {
			if ($data['start'] < 0) {
				$data['start'] = 0;
			}

			if ($data['limit'] < 1) {
				$data['limit'] = 6;
			}
		}
		$query = $this->db->query("SELECT a.order_id,c.crowdfunding_name,c.name,d.image,d.funding_id,a.order_status_id,a.total,b.shipping_price,a.date_added,e.name as ename FROM ".DB_PREFIX."order as a left join ".DB_PREFIX."order_total as b on b.order_id=a.order_id
                                     left join ".DB_PREFIX."crowdfunding_rewards as c on c.rewards_id=b.rewards_id 
									 left join ".DB_PREFIX."crowdfunding as d on d.funding_id=c.funding_id 
									 left join ".DB_PREFIX."order_status as e on a.order_status_id=e.order_status_id
                                     WHERE a.order_status_id !=0 and a.customer_id = '" . (int)$this->customer->getId() . "'"." LIMIT " . (int)$data['start'] . "," . (int)$data['limit']);
          
		return $query->rows;
	}
		public function getTotalOrders() {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM ".DB_PREFIX."order WHERE order_status_id !=0 and customer_id = " . (int)$this->customer->getId());

		return $query->row['total'];
	}
     //add by liuxuewen at 20170413 删除订单
	public function deleorder($id) {
		$this->db->query("DELETE FROM ".DB_PREFIX."order WHERE customer_id = '" . (int)$this->customer->getId() . "' AND order_id = '" . (int)$id . "'");
	}	
}
