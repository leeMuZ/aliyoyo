<?php
class ModelLivehelpLivehelpDataWarehouse extends Model {
   public function deleteRow($row_id) {
      $this->db->query("DELETE FROM " . DB_PREFIX . "livehelp_data_warehouse WHERE row_id = '" . (int) $row_id . "'");
   }
   
   public function getRows($data = array()) {
      $sql = "SELECT * FROM " . DB_PREFIX . "livehelp_data_warehouse WHERE 1";
      
      if (!is_null($data['filter_message'])) {
         $msg_string = str_replace("'", "", html_entity_decode($data['filter_message']));
         
         $sql .= " AND MATCH(`message`) AGAINST('" . $msg_string . "' IN BOOLEAN MODE)";
      }
      
      if (!is_null($data['filter_thread_id'])) {
         $sql .= " AND thread_id = '" . (int) $data['filter_thread_id'] . "'";
      }
      
      if (!is_null($data['filter_customer_name'])) {
         $sql .= " AND customer_name LIKE '%" . $this->db->escape($data['filter_customer_name']) . "%'";
      }
      
      if (!is_null($data['filter_operator_name'])) {
         $sql .= " AND operator_name LIKE '" . $this->db->escape($data['filter_operator_name']) . "%'";
      }
      
      $sort_data = array(
         'thread_id',
         'customer_name',
         'operator_name'
      );
      
      if (is_null($data['filter_message'])) {
         if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
            $sql .= " ORDER BY " . $data['sort'];
         } else {
            $sql .= " ORDER BY thread_id";
         }
         
         if (isset($data['order']) && ($data['order'] == 'DESC')) {
            $sql .= " DESC";
         } else {
            $sql .= " ASC";
         }
      }
      
      if (isset($data['start']) || isset($data['limit'])) {
         if ($data['start'] < 0) {
            $data['start'] = 0;
         }
         
         if ($data['limit'] < 1) {
            $data['limit'] = 20;
         }
         
         $sql .= " LIMIT " . (int) $data['start'] . "," . (int) $data['limit'];
      }
      
      $query = $this->db->query($sql);
      
      return $query->rows;
   }
   
   public function getTotalRows($data = array()) {
      $sql = "SELECT COUNT(*) AS total FROM " . DB_PREFIX . "livehelp_data_warehouse WHERE 1";
      
      if (!is_null($data['filter_message'])) {
         $msg_string = str_replace("'", "", html_entity_decode($data['filter_message']));
         
         $sql .= " AND MATCH(`message`) AGAINST('" . $msg_string . "' IN BOOLEAN MODE)";
      }
      
      if (!is_null($data['filter_thread_id'])) {
         $sql .= " AND thread_id = '" . (int) $data['filter_thread_id'] . "'";
      }
      
      if (!is_null($data['filter_customer_name'])) {
         $sql .= " AND customer_name LIKE '%" . $this->db->escape($data['filter_customer_name']) . "%'";
      }
      
      if (!is_null($data['filter_operator_name'])) {
         $sql .= " AND operator_name LIKE '" . $this->db->escape($data['filter_operator_name']) . "%'";
      }
      
      $query = $this->db->query($sql);
      
      return $query->row['total'];
   }
   
   public function getThreads() {
      $query = $this->db->query("SELECT DISTINCT thread_id, CONCAT('(', thread_id, ') ', customer_name, ' - ', operator_name) AS name FROM " . DB_PREFIX . "livehelp_data_warehouse");
      
      return $query->rows;
   }
}
?>