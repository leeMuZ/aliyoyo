<?php
class ModelProjectCategory extends Model {
    public function getCategory($category_id) {
        $query = $this->db->query("SELECT
		    parent_id,
            name
		    FROM " . DB_PREFIX . "category WHERE category_id = '" . $category_id . "'");
        return $query->row;
    }
    
    public function getAllCategory() {
        $query = $this->db->query("SELECT
            category_id,
		    parent_id,
            name
		    FROM " . DB_PREFIX . "category ");
        return $query->rows;
    }
    
    public function getCrowdFundingByCid($category_id) {
        $query = $this->db->query("SELECT
		    funding_id
		    FROM " . DB_PREFIX . "crowdfunding_to_category WHERE category_id = '" . $category_id . "'");
        return $query->rows;
    }
    
}