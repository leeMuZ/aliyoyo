<?php
class ModelProjectRewards extends Model {
    public function getRewards($funding_id) {
        $query = $this->db->query("SELECT
		     rewards_id,
		     crowdfunding_name,
		     pledge_amount,
		     name,
		     description,
		     backers,
		     shipping_method,
             shipping_postage,
		     estimated_delivery,
		     limit_availability,
             limit_backer_availability,
             limit_time_availability,
		     limit_backer,
		     DATE_FORMAT(limit_time_begin,'%Y-%m-%d') as limit_time_begin,
             DATE_FORMAT(limit_time_end,'%Y-%m-%d') as limit_time_end,
		     stock
		     FROM " . DB_PREFIX . "crowdfunding_rewards WHERE funding_id = '" . $funding_id . "'");
        return $query->rows;
    }
    
    public function getRewardBacker($reward_id) {
        $query = $this->db->query("SELECT customer_id FROM " . DB_PREFIX . "rewards_backers WHERE reward_id = '" . $reward_id . "'");
        return $query->rows;
    }
    
    public function getRewardName($reward_id) {
        $query = $this->db->query("SELECT name FROM " . DB_PREFIX . "crowdfunding_rewards WHERE reward_id = '" . $reward_id . "'");
        return $query->row;
    }
    
    public function getRewardShipping($reward_id) {
        $query = $this->db->query("SELECT shipping_id,country_id,Postage,country_name FROM " . DB_PREFIX . "rewards_shipping WHERE rewards_id = '" . $reward_id . "' ORDER BY shipping_id ASC");
        return $query->rows;
    }
    
    public function deleteReward($reward_id){
        $this->db->query("DELETE FROM " . DB_PREFIX . "crowdfunding_rewards where rewards_id='".$reward_id."'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "rewards_shipping where rewards_id='".$reward_id."'");
    }
    public function deleteShipping($shipping_id){
        $this->db->query("DELETE FROM " . DB_PREFIX . "rewards_shipping where shipping_id='".$shipping_id."'");
    }
    
}