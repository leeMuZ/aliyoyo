<?php
class ModelCatalogCategory extends Model {
	public function addCategory($data) {
	    $this->db->query("INSERT INTO " . DB_PREFIX . "model_category SET  `name` = '" . $this->db->escape($data['name']) . "', language_id = '" . (int)$language_id ."',description = '" . $this->db->escape($data['description']) ."',sort_order = '" . (int)$data['sort_order'] . "', status = '" . (int)$data['status'] . "', date_added = NOW()");
		$category_id = $this->db->getLastId();
		$this->db->query("INSERT INTO " . DB_PREFIX . "url_alias SET query = 'model_category_id=" . (int)$category_id . "', keyword = '" . $this->db->escape($data['keyword']) . "'");
		$this->cache->delete('category');
		return $category_id;
	}

	public function editCategory($category_id, $data) {
		$this->db->query("UPDATE " . DB_PREFIX . "model_category SET name='".$this->db->escape($data['name'])."',description='".$this->db->escape($data['description'])."', sort_order = '" . (int)$data['sort_order'] . "', status = '" . (int)$data['status'] . "'  WHERE model_category_id = '" . (int)$category_id . "'");

		$this->db->query("DELETE FROM " . DB_PREFIX . "url_alias WHERE query = 'model_category_id=" . (int)$category_id . "'");

		if ($data['keyword']) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "url_alias SET query = 'model_category_id=" . (int)$category_id . "', keyword = '" . $this->db->escape($data['keyword']) . "'");
		}

		$this->cache->delete('category');
	}

	public function deleteCategory($category_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "model_category WHERE model_category_id = '" . (int)$category_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "model WHERE model_category_id = '" . (int)$category_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "url_alias WHERE query = 'model_category_id =" . (int)$category_id . "'");
	
		$this->cache->delete('category');
	}


	public function getCategory($category_id) {
		$query = $this->db->query("SELECT *,(SELECT DISTINCT keyword FROM " . DB_PREFIX . "url_alias WHERE query = 'model_category_id=" . (int)$category_id . "')AS keyword FROM ".DB_PREFIX."model_category ca  where ca.model_category_id='".$category_id."'");
		return $query->row;
	}
	
	
	public function getCategories($data = array()) {
		$sql = "SELECT * FROM ".DB_PREFIX."model_category ";
		if (!empty($data['filter_name'])) {
			$sql .= " AND name LIKE '" . $this->db->escape($data['filter_name']) . "%'";
		}

		$sql .= " GROUP BY model_category_id";

		$sort_data = array(
			'name',
			'sort_order'
		);

		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];
		} else {
			$sql .= " ORDER BY sort_order";
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


	public function getTotalCategories() {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "model_category");

		return $query->row['total'];
	}
	
}
