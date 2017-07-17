<?php
class ModelAccountreturn extends Model {
	
	//add by liuxuewen at 20170408 获取订单信息
	 public function getreturn($data) {
		if (isset($data['start']) || isset($data['limit'])) {
			if ($data['start'] < 0) {
				$data['start'] = 0;
			}

			if ($data['limit'] < 1) {
				$data['limit'] = 1;
			}
		}
	    $query = $this->db->query("SELECT a.return_id,b.name,a.date_added,a.order_id FROM ".DB_PREFIX."return as a left join ".DB_PREFIX."return_status as b on b.return_status_id=a.return_status_id                                  
                                     WHERE a.customer_id = " . (int)$this->customer->getId()." LIMIT " . (int)$data['start'] . "," . (int)$data['limit']);
		return $query->rows;
	}
		public function getTotalreturn() {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM ".DB_PREFIX."return");

		return $query->row['total'];
	}
}
