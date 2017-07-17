<?php
class ModelLocalisationRegion extends Model {
	public function getProvinces() {
	    $province_data = $this->cache->get('province.catalog');
	    if (!$province_data) {
		$query = $this->db->query("SELECT `code`,`fullName` AS `name` FROM " . DB_PREFIX . "regions WHERE type = '1'");
		$province_data = $query->rows;
		$this->cache->set('province.catalog', $province_data);
	    }
	    return $province_data;
	}
	
	public function getRegionsByProveinceCode($code) {
	    $regions_data = $this->cache->get('zone.' . (int)$code);
	    if (!$regions_data) {
	    $query = $this->db->query("SELECT `code`,`fullName` AS `name` FROM " . DB_PREFIX . "regions WHERE parentCode = '".$code."'");
	    $regions_data = $query->rows;
	    
	    $this->cache->set('zone.' . (int)$code, $regions_data);
	    }
	    
	    return $regions_data;
	}
	
	
	
}