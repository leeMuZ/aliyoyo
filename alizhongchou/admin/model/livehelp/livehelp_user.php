<?php
class ModelLivehelpLivehelpUser extends Model {

	public function addOperator($data) {
		$this->db->query("INSERT INTO " . DB_PREFIX . "livehelp_operator SET user_id = '" . (int)$data['user_id'] . "', name = '" . $this->db->escape($data['name']) . "', description = '" . $this->db->escape($data['description']) . "', image = " . (!empty($data['image']) ? "'" . $data['image'] . "'" : "NULL") . ", status = '" . (int)$data['status'] . "'");
	}
	
	public function editOperator($operator_id, $data) {
		$this->db->query("UPDATE " . DB_PREFIX . "livehelp_operator SET user_id = '" . (int)$data['user_id'] . "', name = '" . $this->db->escape($data['name']) . "', description = '" . $this->db->escape($data['description']) . "', image = " . (!empty($data['image']) ? "'" . $data['image'] . "'" : "NULL") . ", status = '" . (int)$data['status'] . "' WHERE operator_id = '" . (int)$operator_id . "'");
	}
	
	public function deleteOperator($operator_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "livehelp_operator WHERE operator_id = '" . (int)$operator_id . "'");
	}

	public function getOperator($operator_id) {
		$query = $this->db->query("SELECT lo.*, u.username FROM " . DB_PREFIX . "livehelp_operator AS lo LEFT JOIN " . DB_PREFIX . "user AS u ON (lo.user_id = u.user_id) WHERE lo.operator_id = '" . (int)$operator_id . "'");
		
		return $query->row;
	}
		
	public function getOperators($data = array()) {
		$sql = "SELECT lo.*, u.username FROM " . DB_PREFIX . "livehelp_operator AS lo LEFT JOIN " . DB_PREFIX . "user AS u ON (lo.user_id = u.user_id) WHERE 1";
		
		$sort_data = array(
			'u.username'
		);	
		
		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];	
		} else {
			$sql .= " ORDER BY u.username";	
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
	
	public function getTotalOperators($data = array()) {
        $query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "livehelp_operator");
		
		return $query->row['total'];
	}

	public function getOperatorByUserId($user_id, $operator_id = 0) {
        if ($operator_id) {
        	$sql = "SELECT * FROM " . DB_PREFIX . "livehelp_operator WHERE user_id = '" . (int)$user_id . "' AND operator_id <> '" . (int)$operator_id . "'";
        } else {
        	$sql = "SELECT * FROM " . DB_PREFIX . "livehelp_operator WHERE user_id = '" . (int)$user_id . "'";
        }

        $query = $this->db->query($sql);
		
		return ($query->num_rows ? $query->row : false);
	}
} 
