<?php
class ModelLivehelpLivehelpBan extends Model {
	public function addBan($data) {
		$sql = "INSERT INTO " . DB_PREFIX . "livehelp_ban" . 
				" SET " . 
				" user_name = '" . $this->db->escape($data['user_name']) . "'," .
				" comment = '" . $this->db->escape($data['comment']) . "'," .
				" date_added = '" . strtotime(date('Y-m-d')) . "'," .
				" date_expired = '" . ($data['date_expired'] ? strtotime($data['date_expired']) : "-1") . "'," . 
				" ip = '" . $this->db->escape($data['ip']) . "'";

		$this->db->query($sql);
	}
	
	public function editBan($ban_id, $data) {
		$sql = "UPDATE " . DB_PREFIX . "livehelp_ban" . 
				" SET " . 
				" user_name = '" . $this->db->escape($data['user_name']) . "'," .
				" comment = '" . $this->db->escape($data['comment']) . "'," .
				" date_expired = '" . ($data['date_expired'] ? strtotime($data['date_expired']) : "-1") . "'," . 
				" ip = '" . $this->db->escape($data['ip']) . "'" .
				" WHERE `ban_id` = '" . (int)$ban_id . "'";

		$this->db->query($sql);
	}
	
	public function deleteBan($ban_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "livehelp_ban WHERE ban_id = '" . (int)$ban_id . "'");
	}

	public function getBan($ban_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "livehelp_ban WHERE ban_id = '" . (int)$ban_id . "'");
		
		return $query->row;
	}
		
	public function getBans($data = array()) {
		$sql = "SELECT * FROM " . DB_PREFIX . "livehelp_ban WHERE 1";
		
		if(!is_null($data['filter_date_added'])) {
			$sql .= " AND date_added = '" . (int) strtotime($data['filter_date_added']) . "'";
		}

		if(!is_null($data['filter_date_expired'])) {
			$sql .= " AND date_expired = '" . (int) strtotime($data['filter_date_expired']) . "'";
		}

		$sort_data = array(
			'user_name',
			'date_added',
			'date_expired'
		);	
		
		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];	
		} else {
			$sql .= " ORDER BY user_name";	
		}
		
		if (isset($data['order']) && ($data['order'] == 'DESC')) {
			$sql .= " DESC";
		} else {
			$sql .= " ASC";
		}
		
		if (isset($data['start']) || isset($data['limit'])) {
			if ($data['start'] < 0) {
				$data['start'] = 0;
			}					

			if ($data['limit'] < 1) {
				$data['limit'] = 20;
			}	
		
			$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
		}		
		
		$query = $this->db->query($sql);

		return $query->rows;
	}
	
	public function getTotalBans($data = array()) {
        $sql = "SELECT COUNT(*) AS total FROM " . DB_PREFIX . "livehelp_ban WHERE 1";

		if(!is_null($data['filter_date_added'])) {
			$sql .= " AND date_added = '" . (int) strtotime($data['filter_date_added']) . "'";
		}

		if(!is_null($data['filter_date_expired'])) {
			$sql .= " AND date_expired = '" . (int) strtotime($data['filter_date_expired']) . "'";
		}

        $query = $this->db->query($sql);
		
		return $query->row['total'];
	}
} 
?>