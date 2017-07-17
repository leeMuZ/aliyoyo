<?php
class ModelLivehelpLivehelpSetting extends Model {
	public function getSetting() {
		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "livehelp_setting`");

		$settings = array();

		foreach ($query->rows as $setting) {
			$settings[$setting['key']] = ($setting['serialized'] ? unserialize($setting['value']) : $setting['value']);
		}

		return $settings;
	}

	public function setSetting($data) {
		$this->db->query("DELETE FROM `" . DB_PREFIX . "livehelp_setting`");

		foreach ($data AS $key => $value) {
			if(is_array($value)) {
				$serialized = 1;
				$value = serialize($value);
			} else {
				$serialized = 0;
			}

			$this->db->query("INSERT INTO `" . DB_PREFIX . "livehelp_setting` SET `key` = '" . $this->db->escape($key) . "', `value` = '" . $this->db->escape($value) . "', `serialized` = '" . (int)$serialized . "'");
		}
	}
} 
?>