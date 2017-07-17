<?php
class ModelCustomerCollection extends Model {
    public function getCollections($data = array()) {
		$sql = "SELECT c.nickname,cc.collection_id,cc.collection_name,cc.follow_count FROM " . DB_PREFIX . "customer_collection cc LEFT JOIN " . DB_PREFIX . "customer c ON (cc.customer_id = c.customer_id) WHERE cc.status=0 AND cc.product_count > 0";

		if (!empty($data['filter_name'])) {
			$sql .= " AND cc.collection_name LIKE '%" . $this->db->escape($data['filter_name']) . "%'";
		}


		if (isset($data['sort'])) {
			$sql .= " ORDER BY " . $data['sort'];
		} else {
			$sql .= " ORDER BY cc.follow_count";
		}

		if (isset($data['order']) && ($data['order'] == 'ASC')) {
			$sql .= " ASC";
		} else {
			$sql .= " DESC";
		}

		if (isset($data['start']) || isset($data['limit'])) {
			if ($data['start'] < 0) {
				$data['start'] = 0;
			}

			if ($data['limit'] < 1) {
				$data['limit'] = 5;
			}

			$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
		}

		$query = $this->db->query($sql);

		return $query->rows;
	}

	public function getCollection($collection_id) {
	    $sql = "SELECT c.nickname,cc.collection_id,cc.collection_name,cc.follow_count FROM " . DB_PREFIX . "customer_collection cc LEFT JOIN " . DB_PREFIX . "customer c ON (cc.customer_id = c.customer_id) WHERE cc.collection_id ='".$collection_id."'";
	
	    $query = $this->db->query($sql);
	
	    return $query->row;
	}






}
