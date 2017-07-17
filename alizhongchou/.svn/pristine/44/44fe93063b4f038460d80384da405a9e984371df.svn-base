<?php
class ModelLivehelpLivehelpStatus extends Model {

	public function addStatus($data) {
		$this->db->query("INSERT INTO " . DB_PREFIX . "livehelp_status SET color = " . ($data['color'] ? "'" . $this->db->escape($data['color']) . "'" : "NULL"));
	
		$status_id = $this->db->getLastId();

		foreach ($data['status_text'] as $language_id => $value) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "livehelp_status_text SET status_id = '" . (int)$status_id . "', language_id = '" . (int)$language_id . "', name = '" . $this->db->escape($value['name']) . "', text = '" . $this->db->escape($value['text']) . "'");
		}
	}
	
	public function editStatus($status_id, $data) {
		$this->db->query("UPDATE " . DB_PREFIX . "livehelp_status SET color = " . ($data['color'] ? "'" . $this->db->escape($data['color']) . "'" : "NULL") . " WHERE status_id = '" . (int)$status_id . "'");
	
		$this->db->query("DELETE FROM " . DB_PREFIX . "livehelp_status_text WHERE status_id = '" . (int)$status_id . "'");
		
		foreach ($data['status_text'] as $language_id => $value) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "livehelp_status_text SET status_id = '" . (int)$status_id . "', language_id = '" . (int)$language_id . "', name = '" . $this->db->escape($value['name']) . "', text = '" . $this->db->escape($value['text']) . "'");
		}
	}

	public function deleteStatus($status_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "livehelp_status WHERE status_id = '" . (int)$status_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "livehelp_status_text WHERE status_id = '" . (int)$status_id . "'");
	}


	public function getStatus($status_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "livehelp_status WHERE status_id = '" . (int)$status_id . "'");
		
		return $query->row;
	}
		
	public function getStatuses($data = array()) {
		$sql = "SELECT * FROM " . DB_PREFIX . "livehelp_status AS ls LEFT JOIN " . DB_PREFIX . "livehelp_status_text AS lst ON (lst.status_id = ls.status_id) WHERE lst.language_id = '" . $this->config->get('config_language_id') . "'";
		
		$sort_data = array(
			'lst.name'
		);	
		
		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];	
		} else {
			$sql .= " ORDER BY lst.name";	
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
	
	public function getStatusText($status_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "livehelp_status_text WHERE status_id = '" . (int)$status_id . "'");
		
		$statuses = array();

		foreach ($query->rows as $status) {
			$statuses[$status['language_id']] = array(
				'name' => $status['name'],
				'text' => $status['text']
				);
		}

		return $statuses;
	}

	public function getTotalStatuses($data = array()) {
        $query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "livehelp_status");
		
		return $query->row['total'];
	}
} 
?>