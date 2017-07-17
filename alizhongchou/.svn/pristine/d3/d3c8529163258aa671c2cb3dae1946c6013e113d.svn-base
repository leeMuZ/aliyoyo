<?php
class ModelLivehelpLivehelp extends Model {

  public function install() {
  	$sql = array();

  	// Table.Livehelp_ban
  	$sql[] = "CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "livehelp_ban` (
			 `ban_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
			 `user_name` varchar(40) NOT NULL,
			 `comment` varchar(255) DEFAULT NULL,
			 `date_added` int(11) NOT NULL,
			 `date_expired` int(11) NOT NULL DEFAULT '-1',
			 `ip` varchar(200) NOT NULL,
			 UNIQUE KEY `user_id` (`ban_id`)
			) ENGINE=MyISAM DEFAULT CHARSET=utf8";

  	// Table.Livehelp_ban
  	$sql[] = "CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "livehelp_data_warehouse` (
			 `row_id` int(20) NOT NULL AUTO_INCREMENT,
			 `thread_id` int(11) NOT NULL,
			 `customer_name` varchar(64) NOT NULL,
			 `customer_id` int(11) NOT NULL DEFAULT '0',
			 `operator_id` int(11) NOT NULL,
			 `operator_name` varchar(64) NOT NULL,
			 `date_thread_added` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
			 `date_thread_closed` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
			 `customer_ip` varchar(250) DEFAULT NULL,
			 `customer_agent` varchar(250) DEFAULT NULL,
			 `initiator` int(4) NOT NULL,
			 `message` text NOT NULL,
			 `date_message_added` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
			 PRIMARY KEY (`row_id`),
			 KEY `thread_id` (`thread_id`,`customer_id`,`operator_id`), 
			 FULLTEXT KEY `message` (`message`)
			) ENGINE=MyISAM DEFAULT CHARSET=utf8";

  	// Table.Livehelp_message
  	$sql[] = "CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "livehelp_message` (
			 `message_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
			 `thread_id` int(11) unsigned NOT NULL,
			 `initiator` int(4) unsigned NOT NULL COMMENT '1-Created by User, 2-Created by Operator, 3-Created by bot',
			 `message` text,
			 `action` varchar(250) DEFAULT NULL,
			 `data` text,
			 `date_added` int(11) NOT NULL DEFAULT '0',
			 PRIMARY KEY (`message_id`)
			) ENGINE=MyISAM DEFAULT CHARSET=utf8";

  	// Table.Livehelp_operator
  	$sql[] = "CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "livehelp_operator` (
			 `operator_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
			 `name` varchar(64) NOT NULL,
			 `user_id` int(11) unsigned NOT NULL,
			 `description` varchar(255) NOT NULL,
			 `image` varchar(255) DEFAULT NULL,
			 `date_added` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
			 `status` tinyint(1) NOT NULL,
			 `status_id` int(11) unsigned DEFAULT NULL,
			 `last_activity` int(11) DEFAULT '0',
			 `is_logged` tinyint(1) NOT NULL DEFAULT '0',
			 PRIMARY KEY (`operator_id`),
			 UNIQUE KEY `user_id` (`user_id`)
			) ENGINE=MyISAM DEFAULT CHARSET=utf8";

  	// Table.Livehelp_setting
  	$sql[] = "CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "livehelp_setting` (
			 `setting_id` int(11) NOT NULL AUTO_INCREMENT,
			 `key` varchar(64) NOT NULL,
			 `value` text NOT NULL,
			 `serialized` tinyint(1) NOT NULL,
			 PRIMARY KEY (`setting_id`)
			) ENGINE=MyISAM DEFAULT CHARSET=utf8";

		// Setting required values to be set
		$sql[] = "INSERT INTO `" . DB_PREFIX . "livehelp_setting` (`setting_id`, `key`, `value`, `serialized`) VALUES
				(1, 'absolute_path', '/', 0),
				(2, 'text_max_length', '500', 0),
				(6, 'offline_form', '1', 0),
				(8, 'spam_filter_status', '1', 0),
				(9, 'spam_filter_score_limit', '10', 0),
				(10, 'spam_filter_penalty', '60', 0),
				(11, 'spam_filter_range', '20', 0),
				(12, 'admin_refresh_rate', '6000', 0),
				(13, 'admin_inactive_timeout', '1200', 0),
				(14, 'admin_inactive_action', '-1', 0),
				(20, 'store_refresh_rate', '4500', 0),
				(21, 'store_inactive_timeout', '600', 0),
				(22, 'cart_update_interval', '10', 0);";

  	// Table.Livehelp_status
  	$sql[] = "CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "livehelp_status` (
			 `status_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
			 `color` varchar(10) DEFAULT NULL COMMENT 'hex',
			 PRIMARY KEY (`status_id`)
			) ENGINE=MyISAM DEFAULT CHARSET=utf8";

  	// Table.Livehelp_status_text
  	$sql[] = "CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "livehelp_status_text` (
			 `status_id` int(11) unsigned NOT NULL,
			 `language_id` int(11) unsigned NOT NULL,
			 `name` varchar(64) NOT NULL,
			 `text` text NOT NULL,
			 PRIMARY KEY (`status_id`,`language_id`)
			) ENGINE=MyISAM DEFAULT CHARSET=utf8";

  	// Table.Livehelp_thread
  	$sql[] = "CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "livehelp_thread` (
			 `thread_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
			 `user_id` varchar(32) NOT NULL,
			 `user_name` varchar(64) NOT NULL,
			 `utoken` int(11) unsigned NOT NULL,
			 `customer_id` int(11) unsigned NOT NULL DEFAULT '0',
			 `operator_id` int(11) unsigned NOT NULL DEFAULT '0',
			 `date_added` int(11) NOT NULL DEFAULT '0',
			 `date_modified` int(11) NOT NULL DEFAULT '0',
			 `date_closed` int(11) NOT NULL DEFAULT '0',
			 `user_readed` int(11) NOT NULL DEFAULT '0',
			 `operator_readed` int(11) NOT NULL DEFAULT '0',
			 `user_ip` varchar(250) DEFAULT NULL,
			 `user_agent` varchar(255) DEFAULT NULL,
			 `user_cart` text COMMENT 'serialized',
			 `referer` text,
			 `language_id` int(11) unsigned NOT NULL,
			 `user_ping` int(11) unsigned NOT NULL DEFAULT '0',
			 `kicked` tinyint(1) NOT NULL DEFAULT '0',
			 PRIMARY KEY (`thread_id`),
			 KEY `utoken` (`utoken`)
			) ENGINE=MyISAM DEFAULT CHARSET=utf8";

	foreach ($sql as $sq) {
		$this->db->query($sq);
	}

    return true;
  }

  public function uninstall() {
  	$sql = array();

  	$sql[] = "DROP TABLE IF EXISTS `" . DB_PREFIX . "livehelp_ban`";
  	$sql[] = "DROP TABLE IF EXISTS `" . DB_PREFIX . "livehelp_data_warehouse`";
  	$sql[] = "DROP TABLE IF EXISTS `" . DB_PREFIX . "livehelp_message`";
  	$sql[] = "DROP TABLE IF EXISTS `" . DB_PREFIX . "livehelp_operator`";
  	$sql[] = "DROP TABLE IF EXISTS `" . DB_PREFIX . "livehelp_setting`";
  	$sql[] = "DROP TABLE IF EXISTS `" . DB_PREFIX . "livehelp_status`";
  	$sql[] = "DROP TABLE IF EXISTS `" . DB_PREFIX . "livehelp_status_text`";
  	$sql[] = "DROP TABLE IF EXISTS `" . DB_PREFIX . "livehelp_thread`";

  	$sql[] = "DELETE FROM `" . DB_PREFIX . "setting` WHERE `key` = 'livehelp_status'";

	foreach ($sql as $sq) {
		$this->db->query($sq);
	}

    return true;
  }
} 
?>