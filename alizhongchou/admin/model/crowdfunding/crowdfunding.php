<?php
/**
 * Created by PhpStorm.
 * User: alice
 * Date: 2017/4/7
 * Time: 16:28
 */
class ModelCrowdfundingCrowdfunding extends Model
{
    public function getSingle($id)
    {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX ."crowdfunding WHERE funding_id = ".$id." AND status=15");
        return $query->row;
    }

    public function getMetaMessage($id)
    {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX ."crowdfunding_description WHERE funding_id = ".$id);
        return $query->row;

    }

    public function getReward($id)
    {
        $query = $this->db->query("SELECT cr.rewards_id, cr.shipping_postage, c.backers AS all_man, cd.*, c2.image,c2.firstname, c2.lastname, c2.nickname, c2.description AS word, ".
                                  " cr.pledge_amount, cr.description AS award, cr.name, cr.backers, cr.shipping_method, cr.limit_availability, cr.limit_backer, cr.limit_time_begin, cr.limit_time_end, cr.stock, cr.estimated_delivery ".
                                  "FROM " . DB_PREFIX .
                                  "crowdfunding AS c INNER JOIN ".DB_PREFIX .
                                  "crowdfunding_description AS cd ON c.funding_id=cd.funding_id INNER JOIN ". DB_SHARE_PREFIX.
                                  "customer as c2 ON c.customer_id=c2.customer_id LEFT JOIN ". DB_PREFIX.
                                  "crowdfunding_rewards AS cr ON c.funding_id=cr.funding_id WHERE c.funding_id=".$id);
        return $query->rows;

    }

    public function changeTime($time,$type=0)
    {
        $array=explode('-', $time);
        //var_dump($array);exit;
        if ($type==1)
        {
            $year = $array[0];
        }
        switch ($array[1])
        {
            case "1":
                $new = 'Jan.';
                break;
            case "2":
                $new = 'Feb.';
                break;
            case "3":
                $new = 'Mar.';
                break;
            case "4":
                $new = 'Apr.';
                break;
            case "5":
                $new = 'May';
                break;
            case "6":
                $new = 'Jun.';
                break;
            case "7":
                $new = 'Jul.';
                break;
            case "8":
                $new = 'Aug.';
                break;
            case "9":
                $new = 'Sept.';
                break;
            case "10":
                $new = 'Oct.';
                break;
            case "11":
                $new = 'Nov.';
                break;
            case "12":
                $new = 'Dec.';
                break;
            default:
                $new = '';
        }
        if (empty($array)){

            return 'END';
        }else{

            if ($type==1)
            {
                $last = explode(" ",$array[2]);
                return $new.' '.$last[0].' '.$year;
            }else{
                return $new.' '.$array[0];
            }

        }


    }

    public function getProjectUpdate($id)
    {
        $query = $this->db->query("SELECT * FROM ". DB_PREFIX ."crowdfunding_updates WHERE funding_id=".$id);
        $array = $query->rows;
        foreach ($array as $k=>$v)
        {
           $query = $this->db->query("SELECT a.*, b.firstname, b.lastname, b.image, c3.image AS di, c3.firstname AS df, c3.lastname AS dl, a.target_comment_id, a.comment_id FROM ". DB_PREFIX . "update_comment AS a".
                                     " INNER JOIN ".DB_SHARE_PREFIX."customer AS b ON a.customer_id=b.customer_id ".
                                     " INNER JOIN ".DB_PREFIX."crowdfunding_updates AS cu ON a.update_id=cu.update_id".
                                     " INNER JOIN ".DB_PREFIX."crowdfunding AS c1 ON c1.funding_id=cu.funding_id".
                                     " INNER JOIN ".DB_SHARE_PREFIX."customer AS c3 ON c1.customer_id=c3.customer_id".
                                     " WHERE a.update_id=".$v['update_id']);
            $result= $query->rows;
            $array[$k]['now_comment'] = $result;
        }

        return $array;
    }

    public function getPost($reward_id, $status=0)
    {
        if ($status==1)
        {
            $query = $this->db->query("SELECT rs.*, c.name FROM ".DB_PREFIX."rewards_shipping AS rs INNER JOIN ".DB_SHARE_PREFIX.
                "country AS c ON rs.country_id=c.country_id WHERE rs.rewards_id=".$reward_id);
            $result= $query->rows;
            $string = "(";
            foreach ($result as $k=>$v)
            {
                $string .= $v['country_id'].',';

            }
            $string  = rtrim($string,',');
            $string .= ")";
            $other_rows = $this->db->query("SELECT country_id AS other_contry_id, name AS other_names FROM ".DB_SHARE_PREFIX."country WHERE country_id NOT IN ".$string);
            $take_out = $other_rows->rows;
            $result['others_rows'] = $take_out;
        } else {
            $query = $this->db->query("SELECT country_id AS other_contry_id, name AS other_names FROM ".DB_SHARE_PREFIX."country");
            $result = $query->rows;
        }
        return $result;
    }

    public function getPostage($reward_id)
    {
        $query = $this->db->query("SELECT shipping_postage AS Postage FROM ".DB_PREFIX."crowdfunding_rewards WHERE rewards_id=".$reward_id);

        return $query->row['Postage'];
    }
    public function take_out_id($id)
    {
        $query = $this->db->query("SELECT customer_id FROM ". DB_PREFIX ."crowdfunding WHERE funding_id = ".$id);
        return $query->row;
    }
    public function insertComment($data)
    {
        $string = "(";
        $value  = "(";
        foreach ($data as $k=>$v)
        {
            $string .= $k.",";
            $value  .= "'".$v."'".",";
        }
        $string = rtrim($string, ',').')';
        $value  = rtrim($value, ',').')';
        $this->db->query("INSERT INTO ". DB_PREFIX. "update_comment ".$string."VALUES".$value);

    }

    public function getBackers($id)
    {
        $query  = $this->db->query("SELECT c.image, c.firstname, c.lastname, c1.firstname AS tarfirst, c1.lastname AS tarlast, cc.content, cc.STATUS, cc.date_added, cc.customer_id AS wait_id ,cc.comment_id, cc.target_comment_id FROM ".
                                   DB_PREFIX."crowdfunding_comment AS cc INNER JOIN ".
                                   DB_SHARE_PREFIX."customer AS c ON cc.customer_id=c.customer_id INNER JOIN ".
                                   DB_PREFIX."crowdfunding AS c2 ON cc.funding_id=c2.funding_id INNER JOIN ".
                                   DB_SHARE_PREFIX."customer AS c1 ON c2.customer_id=c1.customer_id WHERE cc.funding_id=".$id);

        return $query->rows;
    }

    public function checkCustomer($customer_id, $funding_id)
    {
        $query = $this->db->query("SELECT customer_id FROM ". DB_PREFIX ."rewards_backers WHERE funding_id=".$funding_id);
        $result= $query->rows;
        $array = array();
        foreach ($result as $v)
        {
            $array[] = $v['customer_id'];
        }

        if(in_array($customer_id, $array))
        {
            return true;
        }else{
            return false;
        }

    }

    public function insertSelfComment($data)
    {
        if(!isset($data['target_comment_id'])){
            //$customer_id = $this->db->query("SELECT customer_id FROM " .DB_PREFIX. "crowdfunding WHERE funding_id=".$data['funding_id']);
            //$result = $customer_id->row;
            $data['target_comment_id'] = 0;
        }
        $data['date_added'] = date("Y-m-d: H:i:s", time());
        $string = "(";
        $value  = "(";
        foreach ($data as $k=>$v)
        {
            $string .= $k.",";
            $value  .= "'".$v."'".",";
        }
        $string = rtrim($string, ',').')';
        $value  = rtrim($value, ',').')';
        $this->db->query("INSERT INTO ". DB_PREFIX. "crowdfunding_comment ".$string."VALUES".$value);


    }

    public function findPerson($id)
    {
        $query = $this->db->query("SELECT a.customer_id, b.firstname, b.lastname, b.image, a.pledge_amount FROM ". DB_PREFIX .
                                  "rewards_backers AS a INNER JOIN ".DB_SHARE_PREFIX."customer AS b ON a.customer_id=b.customer_id".
                                  " WHERE funding_id=".$id." LIMIT 0,8");

        $result = $query->rows;
        foreach ($result as $k=>$v)
        {
            $query = $this->db->query("SELECT COUNT(funding_id) AS projects FROM ".DB_PREFIX."rewards_backers WHERE customer_id=".$v['customer_id']);
            $result[$k]['projects'] = $query->row;
        }

        return $result;
    }

    public function take_reward($funding_id)
    {
        $query = $this->db->query("SELECT * FROM ". DB_PREFIX ."crowdfunding_rewards WHERE funding_id=".$funding_id);
        return $query->rows;
    }

    public function selectGoodMessage($funding_id, $reward_id=0)
    {
        if ($reward_id==0)
        {
            $query = $this->db->query("SELECT name, image FROM " . DB_PREFIX ."crowdfunding AS c WHERE funding_id=".$funding_id);
        }else{
            $query = $this->db->query("SELECT c.name, c.image, cr.name, cr.shipping_method AS reward FROM " . DB_PREFIX .
                                      "crowdfunding AS c INNER JOIN ".DB_PREFIX.
                                      "crowdfunding_rewards AS cr WHERE c.funding_id=".$funding_id." AND cr.rewards_id=".$reward_id);
        }
        return $query->row;
    }

    public function select_my_address($customer_id)
    {
        $query = $this->db->query("SELECT a.*, c.name AS country, z.name AS zone_name FROM ". DB_SHARE_PREFIX ."address AS a INNER JOIN ".DB_SHARE_PREFIX.
                                  "country AS c ON c.country_id=a.country_id INNER JOIN ".DB_SHARE_PREFIX.
                                  "zone AS z ON c.country_id=z.country_id".
                                  " WHERE customer_id=".$customer_id);
        return $query->rows;
    }

    public function select_counties()
    {
        $query = $this->db->query("SELECT * FROM ".DB_SHARE_PREFIX."country");
        $countries = $query->rows;
        foreach ($countries as $k=>$country)
        {
            $result = $this->db->query("SELECT * FROM ".DB_SHARE_PREFIX."zone WHERE country_id=".$country['country_id']);
            $countries[$k]['zone'] = $result->rows;
        }

        return $countries;
    }

    public function insertAddress($data)
    {
        $string = "(";
        $value  = "(";
        foreach ($data as $k=>$v)
        {
            $string .= $k.",";
            $value  .= "'".$v."'".",";
        }
        $string = rtrim($string, ',').')';
        $value  = rtrim($value, ',').')';
        $this->db->query("INSERT INTO ". DB_SHARE_PREFIX. "address ".$string."VALUES".$value);
        return $this->db->getLastId();
    }

    public function takePost($shipping_id)
    {
        $query = $this->db->query("SELECT Postage FROM ".DB_PREFIX."rewards_shipping WHERE shipping_id=".$shipping_id);
        $result= $query->row;
        return $result['Postage'];
    }

    public function insertOrderBasic($data)
    {
        $string = "(";
        $value  = "(";
        foreach ($data as $k=>$v)
        {
            $string .= $k.",";
            $value  .= "'".$v."'".",";
        }
        $string = rtrim($string, ',').')';
        $value  = rtrim($value, ',').')';
        $this->db->query("INSERT INTO ". DB_PREFIX. "order ".$string."VALUES".$value);
        return $this->db->getLastId();
    }

    public function updateOrderMessage($data, $order_id)
    {

        $string = "";
        foreach ($data as $k=>$v)
        {
            $string .= $k."="."'".$v."',";
        }
        $string = rtrim($string,",");
        $this->db->query("UPDATE ".DB_SHARE_PREFIX."order SET ".$string." WHERE order_id='".$this->db->escape($order_id)."'");
    }

    public function show_request_address($address_id)
    {
        $query = $this->db->query("SELECT telephone AS shipping_telephone, firstname AS shipping_firstname, lastname AS shipping_lastname, address_1 AS shipping_address_1, address_2 AS shipping_address_2, city AS shipping_city, c.name AS shipping_country, z.name AS shipping_zone FROM ".
                                  DB_SHARE_PREFIX."address AS a INNER JOIN ".DB_PREFIX."country AS c ON a.country_id=c.country_id".
                                            " INNER JOIN ".DB_PREFIX."zone AS z ON z.zone_id=a.zone_id".
                                            " WHERE address_id=".$address_id);
        return $query->row;

    }

    public function check_ticket($ticket)
    {
        //$query = $this->db->query("SELECT * ");//返回数组折扣和优惠状态

    }

    public function take_recommend_category()
    {
        $query = $this->db->query("SELECT * FROM ".DB_PREFIX."category WHERE parent_id = 0 LIMIT 0,7");
        return $query->rows;
    }

    public function find_aliyoyo_price($product_id)
    {
        $query = $this->db->query("SELECT price FROM ".DB_SHARE_PREFIX."product WHERE product_id=".$product_id);
        return $query->row;
    }

    public function find_crowdfunding_result($funding_id)
    {
        $query = $this->db->query("SELECT current_goal, total_goal, date_ended, introduce FROM ".DB_PREFIX."crowdfunding WHERE funding_id=".$funding_id);

        $result= $query->row;
        $now   = time();
        $before= strtotime($result['date_ended']);
        $long  = $now-$before;
        $day   = floor($long/(3600*24));
        $hour  = floor(($long-($day*(3600*24)))/3600);
        $left  = $day. " day " .$hour. " hours left";
        $array = array(
            'now_pay'  => $result['current_goal'],
            'percent'  => ($result['current_goal']/$result['total_goal'])*100,
            'left'     => $left,
            'introduce'=> $result['introduce']
        );
        return $array;
    }

    public function getOwner($funding_id)
    {
        $query = $this->db->query("SELECT a.customer_id, b.email FROM ".DB_PREFIX."crowdfunding AS a INNER JOIN ".
                                  DB_SHARE_PREFIX."customer AS b ON a.customer_id=b.customer_id WHERE a.funding_id=".$funding_id);

        return $query->row;

    }

    public function getAloneOrder($customer_id, $funding_id, $reward_id)
    {
        $check  = $this->db->query("SELECT limit_backer_availability, limit_backer FROM ".DB_SHARE_PREFIX."crowdfunding_rewards WHERE rerewards_id=".$reward_id);
        $result = $check->row;
        if ($result['limit_backer_availability']==1)
        {
            $query  = $this->db->query("SELECT count(baker_id) AS num FROM ".DB_PREFIX."rewards_backers WHERE rewards_id=".$reward_id." AND funding_id=".$funding_id." AND customer_id=".$customer_id);
            $my_buy = $query->row;
            if (($my_buy['num']+1)>$result['limit_backer'])
            {
                return 1;
            } else {

                return 0;
            }

        }else{
            return 1;
        }

    }

    public function selectSortReward($reward_id)
    {
        $query  = $this->db->query("SELECT stock FROM ".DB_SHARE_PREFIX."crowdfunding_rewards WHERE rewards_id=".$reward_id);
        $result = $query->row;
        if ($result['stock']==0)
        {
            return 0;
        } else {
             $this->db->query("UPDATE ".DB_SHARE_PREFIX."crowdfunding_rewards SET stock=stock-1 WHERE rewards_id=".$reward_id);
             return 1;
        }
    }

}