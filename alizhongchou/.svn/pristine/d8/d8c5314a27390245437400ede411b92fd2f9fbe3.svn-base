<?php
class ModelCatalogModel extends Model {
	public function addCategory($data) {
	    $this->db->query("INSERT INTO " . DB_PREFIX . "model_category SET  `name` = '" . $this->db->escape($data['name']) . "', language_id = '" . (int)$language_id ."',description = '" . $this->db->escape($data['description']) ."',sort_order = '" . (int)$data['sort_order'] . "', status = '" . (int)$data['status'] . "', date_added = NOW()");
		$category_id = $this->db->getLastId();
		$this->db->query("INSERT INTO " . DB_PREFIX . "url_alias SET query = 'model_category_id=" . (int)$category_id . "', keyword = '" . $this->db->escape($data['keyword']) . "'");
		$this->cache->delete('category');
		return $category_id;
	}

	public function editCategory($category_id, $data) {}

	public function deleteCategory($category_id) {}


	public function getCategory($category_id) {}
	
	
	public function getModels($data = array()) {

	    $sql = "SELECT m.model_id,m.name,m.price,m.status,mi.image,mc.name AS category_name,mc.model_category_id FROM " . DB_PREFIX . "model m LEFT JOIN " . DB_PREFIX . "model_image mi ON m.model_id = mi.model_id LEFT JOIN " . DB_PREFIX . "model_category mc ON m.model_category_id = mc.model_category_id";
	    
	    if (!empty($data['filter_name'])) {
	        $sql .= " WHERE m.name LIKE '%" . $this->db->escape($data['filter_name']) . "%'";
	    }
	    
	    if (!empty($data['filter_category'])) {
	        $sql .= " AND m.model_category_id LIKE '%" . $this->db->escape($data['filter_category']) . "%'";
	    }
	    if (isset($data['filter_status']) && !is_null($data['filter_status'])) {
	        $sql .= " AND m.status = '" . (int)$data['filter_status'] . "'";
	    }
	    
	    $sql .= " GROUP BY m.model_id";
	    
	    $sort_data = array(
	        'm.name',
	        'm.category',
	        'm.price',
	        'm.sort_order',
	        'm.date_added'
	    );
	    
	    if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
	        $sql .= " ORDER BY " . $data['sort'];
	    } else {
	        $sql .= " ORDER BY m.name";
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


	public function getTotalModels() {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "model");

		return $query->row['total'];
	}
	
}
