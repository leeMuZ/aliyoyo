<?php
class ModelReportCollection extends Model {
    public function getCollectionLists($data=array()){
    	$sql="SELECT cc.collection_id,cc.collection_name,c.nickname,cgd.`name`,cc.product_count,cc.follow_count,cc.date_added FROM " . DB_PREFIX . "customer_collection cc JOIN " . DB_PREFIX . "customer c ON cc.customer_id = c.customer_id JOIN " . DB_PREFIX . "customer_group_description cgd ON cgd.customer_group_id = c.customer_group_id WHERE collection_id > 0";
    	if (!empty($data['list_name'])) {
    		$sql .= " AND cc.collection_name LIKE '%" . $this->db->escape($data['list_name']) . "%'";
    	}
    	if (!empty($data['filter_date_start'])) {
    		$sql .= " AND DATE(cc.date_added) = '" . $data['filter_date_start'] . "'";
    	}
    	if (!empty($data['like_customerGroup_id'])) {
    		$sql .= " AND cgd.customer_group_id = ".$data['like_customerGroup_id'];
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
    public function getCollectionListsTotal($data=array()){
    	$sql="SELECT COUNT(*) AS total FROM " . DB_PREFIX . "customer_collection cc JOIN " . DB_PREFIX . "customer c ON cc.customer_id = c.customer_id JOIN " . DB_PREFIX . "customer_group_description cgd ON cgd.customer_group_id = c.customer_group_id WHERE collection_id > 0";
    	if (!empty($data['list_name'])) {
    		$sql .= " AND cc.collection_name LIKE '%" . $this->db->escape($data['list_name']) . "%'";
    	}
    	if (!empty($data['filter_date_start'])) {
    		$sql .= " AND DATE(cc.date_added) = '" . $data['filter_date_start'] . "'";
    	}
    	if (!empty($data['like_customerGroup_id'])) {
    		$sql .= " AND cgd.customer_group_id = ".$data['like_customerGroup_id'];
    	}
    	$query = $this->db->query($sql);
    	 
    	return $query->row['total'];
    }
}
