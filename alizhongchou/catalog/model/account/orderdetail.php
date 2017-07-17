<?php
class ModelAccountorderdetail extends Model {
	
	//add by liuxuewen at 20170408 获取订单详细信息
	public function getorderdetail($id) {
		$query = $this->db->query("SELECT a.order_id,c.crowdfunding_name,c.name,d.image,d.funding_id,f.balance,c.shipping_method,a.order_status_id,a.total,b.shipping_price,a.date_added,e.name as ename FROM ".DB_PREFIX."order as a left join ".DB_PREFIX."order_total as b on b.order_id=a.order_id
                                     left join ".DB_PREFIX."crowdfunding_rewards as c on c.rewards_id=b.rewards_id 
									 left join ".DB_PREFIX."crowdfunding as d on d.funding_id=c.funding_id 
									 left join ".DB_PREFIX."order_status as e on a.order_status_id=e.order_status_id
                                     left join ".DB_PREFIX."mycoupon as f on b.mycoupon_id=f.mycoupon_id
									 WHERE a.order_status_id !=0 and a.order_id = ".$id);
		return $query->rows;
	}
	public function getOrderHistories($order_id) {
		$query = $this->db->query("SELECT oh.date_added, os.name AS status, oh.comment, oh.notify FROM " . DB_PREFIX . "order_history oh LEFT JOIN " . DB_PREFIX . "order_status os ON oh.order_status_id = os.order_status_id WHERE oh.order_id = " . $order_id ." ORDER BY oh.date_added DESC limit 1");
		return $query->rows;
	}
	public function getOrderHistorie($order_id) {
		$query = $this->db->query("SELECT oh.date_added, os.name AS status, oh.comment, oh.notify FROM " . DB_PREFIX . "order_history oh LEFT JOIN " . DB_PREFIX . "order_status os ON oh.order_status_id = os.order_status_id WHERE oh.order_id = " . $order_id ." ORDER BY oh.date_added DESC");
		return $query->rows;
	}
	public function getOrder($order_id) {
		$order_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "order WHERE order_id = '" .$order_id . "'");
		if ($order_query->num_rows) {
			return $order_query->rows;
		} else {
			return;
		}
	}
}
