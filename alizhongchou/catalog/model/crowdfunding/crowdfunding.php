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

                                  "crowdfunding_description AS cd ON c.funding_id=cd.funding_id LEFT JOIN ". DB_PREFIX.

                                  "customer as c2 ON c.customer_id=c2.customer_id LEFT JOIN ". DB_PREFIX.
                                  "crowdfunding_rewards AS cr ON c.funding_id=cr.funding_id WHERE c.funding_id=".$id);
        return $query->rows;

    }

    public function changeTime($time,$type=0)
    {
        if ($time)
        {
            $array=explode('-', $time);
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

        }else{
            return 'END';
        }



    }

    public function getProjectUpdate($id)
    {
        $query = $this->db->query("SELECT * FROM ". DB_PREFIX ."crowdfunding_updates WHERE funding_id=".$id);
        $array = $query->rows;
        foreach ($array as $k=>$v)
        {
           $query = $this->db->query("SELECT a.*, b.firstname, b.lastname, b.image, c3.image AS di, c3.firstname AS df, c3.lastname AS dl, a.target_comment_id, a.comment_id FROM ". DB_PREFIX . "update_comment AS a".
                                     " INNER JOIN ".DB_PREFIX."customer AS b ON a.customer_id=b.customer_id ".
                                     " INNER JOIN ".DB_PREFIX."crowdfunding_updates AS cu ON a.update_id=cu.update_id".
                                     " INNER JOIN ".DB_PREFIX."crowdfunding AS c1 ON c1.funding_id=cu.funding_id".
                                     " INNER JOIN ".DB_PREFIX."customer AS c3 ON c1.customer_id=c3.customer_id".
                                     " WHERE a.update_id=".$v['update_id']);
            $result= $query->rows;
            $array[$k]['now_comment'] = $result;
        }

        return $array;
    }

    public function getPost($reward_id, $status=0)
    {
        if ($status==2)
        {
            $query = $this->db->query("SELECT rs.*, c.name FROM ".DB_PREFIX."rewards_shipping AS rs INNER JOIN ".DB_PREFIX.
                "country AS c ON rs.country_id=c.country_id WHERE rs.rewards_id=".$reward_id);
            $result= $query->rows;
            $string = "(";
            foreach ($result as $k=>$v)
            {
                $string .= $v['country_id'].',';

            }
            $string  = rtrim($string,',');
            $string .= ")";
            $other_rows = $this->db->query("SELECT country_id AS other_country_id, name AS other_names FROM ".DB_PREFIX."country WHERE country_id NOT IN ".$string);
            $take_out = $other_rows->rows;
            $result['others_rows'] = $take_out;
        } elseif ($status==1){

            $query = $this->db->query("SELECT rs.*, c.name FROM ".DB_PREFIX."rewards_shipping AS rs INNER JOIN ".DB_PREFIX.
                "country AS c ON rs.country_id=c.country_id WHERE rs.rewards_id=".$reward_id);
            $result= $query->rows;

        } else {
            $query = $this->db->query("SELECT country_id AS other_country_id, name AS other_names FROM ".DB_PREFIX."country");
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
                                   DB_PREFIX."customer AS c ON cc.customer_id=c.customer_id INNER JOIN ".
                                   DB_PREFIX."crowdfunding AS c2 ON cc.funding_id=c2.funding_id INNER JOIN ".
                                   DB_PREFIX."customer AS c1 ON c2.customer_id=c1.customer_id WHERE cc.funding_id=".$id);

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
                                  "rewards_backers AS a INNER JOIN ".DB_PREFIX."customer AS b ON a.customer_id=b.customer_id".
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
        $query = $this->db->query("SELECT * FROM ". DB_PREFIX ."crowdfunding_rewards WHERE funding_id=".$funding_id." AND stock>0 AND UNIX_TIMESTAMP(limit_time_begin) < UNIX_TIMESTAMP(now()) AND UNIX_TIMESTAMP(limit_time_end) > UNIX_TIMESTAMP(now())");
        return $query->rows;
    }

    public function selectGoodMessage($funding_id, $reward_id=0)
    {
        if ($reward_id==0)
        {
            $query = $this->db->query("SELECT name, image FROM " . DB_PREFIX ."crowdfunding AS c WHERE funding_id=".$funding_id);
        }else{
            $query = $this->db->query("SELECT c.name, c.image, cr.name AS rewade_name, cr.shipping_method AS reward FROM " . DB_PREFIX .
                                      "crowdfunding AS c INNER JOIN ".DB_PREFIX.
                                      "crowdfunding_rewards AS cr WHERE c.funding_id=".$funding_id." AND cr.rewards_id=".$reward_id);
        }
        return $query->row;
    }

    public function select_my_address($customer_id, $country_id)
    {
        $query = $this->db->query("SELECT a.*, c.name AS country, z.name AS zone_name FROM ". DB_PREFIX ."address AS a INNER JOIN ".DB_PREFIX.
                                  "country AS c ON c.country_id=a.country_id LEFT JOIN ".DB_PREFIX.
                                  "zone AS z ON a.zone_id=z.zone_id".
                                  " WHERE customer_id=".$customer_id." AND a.country_id=".$country_id);
        return $query->rows;
    }

    public function select_counties()
    {
        $query = $this->db->query("SELECT * FROM ".DB_PREFIX."country");
        $countries = $query->rows;
        foreach ($countries as $k=>$country)
        {
            $result = $this->db->query("SELECT * FROM ".DB_PREFIX."zone WHERE country_id=".$country['country_id']);
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
        $this->db->query("INSERT INTO ". DB_PREFIX. "address ".$string."VALUES".$value);
        return $this->db->getLastId();
    }

    public function takePost($shipping_id)
    {
        $query = $this->db->query("SELECT Postage,country_id FROM ".DB_PREFIX."rewards_shipping WHERE shipping_id=".$shipping_id);
        $result= $query->row;
        return $result;
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

    public function insertOrderMoney($data)
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
        $this->db->query("INSERT INTO ". DB_PREFIX. "order_total ".$string."VALUES".$value);
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
        $this->db->query("UPDATE ".DB_PREFIX."order SET ".$string." WHERE order_id='".$this->db->escape($order_id)."'");
    }

    public function SelectMoneyCode($id)
    {
        //先按美元来处理
        $query = $this->db->query("SELECT  currency_id, code, value FROM ".DB_PREFIX."currency WHERE currency_id=".$id);

        return $query->row;
    }

    public function show_request_address($address_id=0)
    {
        if ($address_id)
        {
            $query = $this->db->query("SELECT telephone AS shipping_telephone, firstname AS shipping_firstname, lastname AS shipping_lastname, address_1 AS shipping_address_1, address_2 AS shipping_address_2, city AS shipping_city, c.name AS shipping_country, z.name AS shipping_zone FROM ".
                DB_PREFIX."address AS a INNER JOIN ".DB_PREFIX."country AS c ON a.country_id=c.country_id".
                " INNER JOIN ".DB_PREFIX."zone AS z ON z.zone_id=a.zone_id".
                " WHERE address_id=".$address_id);
            return $query->row;
        }

    }

    public function check_ticket($ticket, $customers_id)
    {
        //$query = $this->db->query("SELECT * ");//返回数组折扣和优惠状态
        $query = $this->db->query("SELECT * FROM ".DB_PREFIX."coupon WHERE coupon_id=".$ticket);
        if (!empty($query->row))
        {
            if ($query_check=$this->db->query("SELECT * FROM ".DB_PREFIX."coupon_history WHERE coupon_id=".$ticket." AND customer_id=".$customers_id))
            {
                if (!empty($query_check->row))
                {
                    return 2;
                }

            }
            $time = time();
            $end  = strtotime($query->row['date_end']);
            $start= strtotime($query->row['date_start']);
            if (!$time>=$start && !$time<=$end)
            {
                return 2;
            }
            return $query->row;
        }else{
            return 0;
        }

    }

    public function take_recommend_category()
    {
        $query = $this->db->query("SELECT * FROM ".DB_PREFIX."category WHERE parent_id = 0 LIMIT 0,7");
        return $query->rows;
    }


    public function find_crowdfunding_result($funding_id)
    {
        $query = $this->db->query("SELECT current_goal, total_goal, date_ended, introduce FROM ".DB_PREFIX."crowdfunding WHERE funding_id=".$funding_id);

        $result= $query->row;
        if ($result)
        {
            $now = time();
            $before = strtotime($result['date_ended']);
            $long = $before - $now;
            $day = floor($long / (3600 * 24));
            $hour = floor(($long - ($day * (3600 * 24))) / 3600);
            $left = $day . " day " . $hour . " hours left";
            $array = array(
                'now_pay' => $result['current_goal'],
                'percent' => ($result['current_goal'] / $result['total_goal']) * 100,
                'left' => $left,
                'introduce' => strlen($result['introduce'])>=35?substr($result['introduce'],0,36).'...':$result['introduce'],
                'all_introduce' => $result['introduce']
            );
            return $array;
        }else{
            return '';
        }
    }

    public function getOwner($funding_id)
    {
        $query = $this->db->query("SELECT a.customer_id, b.email FROM ".DB_PREFIX."crowdfunding AS a INNER JOIN ".
                                  DB_PREFIX."customer AS b ON a.customer_id=b.customer_id WHERE a.funding_id=".$funding_id);

        return $query->row;

    }

    public function getAloneOrder($customer_id, $funding_id, $reward_id)
    {
        if (!empty($reward_id)) {
            $check = $this->db->query("SELECT limit_backer_availability, limit_backer FROM " . DB_PREFIX . "crowdfunding_rewards WHERE rewards_id=" . $reward_id);
            $result = $check->row;
            if ($result['limit_backer_availability'] == 1) {
                $query = $this->db->query("SELECT count(backer_id) AS num FROM " . DB_PREFIX . "rewards_backers WHERE rewards_id=" . $reward_id . " AND funding_id=" . $funding_id . " AND customer_id=" . $customer_id);
                $my_buy = $query->row;
                if (($my_buy['num'] + 1) > $result['limit_backer']) {
                    return 0;
                } else {
                    return 1;
                }

            } else {
                return 1;
            }
        } else {
            return 1;
        }

    }

    public function selectSortReward($reward_id)
    {
        $query  = $this->db->query("SELECT stock FROM ".DB_PREFIX."crowdfunding_rewards WHERE rewards_id=".$reward_id);
        $result = $query->row;
        if ($result['stock']==0)
        {
            return 0;
        } else {
            // $this->db->query("UPDATE ".DB_PREFIX."crowdfunding_rewards SET stock=stock-1 WHERE rewards_id=".$reward_id);
             return 1;
        }
    }

    public function getLoginEmail($customer_id)
    {
        $query = $this->db->query("SELECT email FROM ".DB_PREFIX."customer WHERE customer_id=".$customer_id);

        return $query->row['email'];

    }

    public function byYouCoupon($order_id, $code)
    {
        $query = $this->db->query("SELECT * FROM ".DB_PREFIX."coupon WHERE coupon_code='".$this->db->escape($code)."'");
        $down  = $this->db->query("SELECT mycoupon_id FROM ".DB_PREFIX."mycoupon WHERE customer_id=".$this->session->data['customer_id']." AND coupon_code='".$code."'");
        if ($down->row['mycoupon_id'])
        {
            $mycoupon_id =  $down->row['mycoupon_id'];
        }

        $result= $query->row;
        if ($result)
        {
            $this->db->query("UPDATE ".DB_PREFIX."order SET total=total-".$result['balance']." WHERE order_id=".$order_id);
            $this->db->query("UPDATE ".DB_PREFIX."order_total SET mycoupon_id=".$mycoupon_id.", discount=".$result['balance'].", total=total-".$result['balance']." WHERE order_id=".$order_id);
        }
        return true;
       /* $query = $this->db->query("SELECT * FROM ".DB_PREFIX."coupon WHERE coupon_id=".$coupon_id);
        $result= $query->row;
        $order_query = $this->db->query("SELECT total FROM ".DB_PREFIX."order WHERE order_id=".$order_id);
        $order_result= $order_query->row;
        if ($result['total']>=$order_result['total'])
        {
             $this->db->query("UPDATE ".DB_PREFIX."order SET total=total-".$result['discount']." WHERE order_id=".$order_id);
             $this->db->query("UPDATE ".DB_PREFIX."order_total SET coupon_id=".$coupon_id.", discount=".$result['discount'].", total=total-".$result['discount']." WHERE order_id=".$order_id);
             return true;
        }else{
            return false;
        }*/
    }

    public function TakeMyOrder()
    {
        $query_total = $this->db->query("SELECT * FROM ".DB_PREFIX."order_total WHERE order_id=". $this->session->data['order_id']);

        $data = array();
        $data['total'] = $query_total->row;
        $data['old_total'] = $data['total']['total'];
        if (isset($this->session->data['coupon']))
        {
            $data['old_total'] =  $data['total']['total']+$data['total']['discount'];
        }

        $data['total']['title'] = array(
            'back Price',
            'Shipping',
            'Total'
        );

        $data['total']['text'] = array(
            $data['total']['back_price'],
            $data['total']['shipping_price'],
            $data['total']['total']
        );
        if (isset($this->session->data['coupon']))
        {
            foreach ($data['total']['title'] as $k=>$v)
            {
                if ($k==2)
                {
                    $data['total']['title'][$k] = 'coupon';
                    $data['total']['title'][$k+1] = $v;
                }
            }

            foreach ($data['total']['text'] as $k=>$v)
            {
                if ($k==2)
                {
                    $data['total']['text'][$k] = '-'.$data['total']['discount'];
                    $data['total']['text'][$k+1] = $v;
                }
            }

        }
        $query_product=$this->db->query("SELECT c.name, cr.name AS reward_model FROM ".DB_PREFIX."crowdfunding AS c INNER JOIN ".DB_PREFIX.
                                        "crowdfunding_rewards AS cr WHERE c.funding_id=". $this->session->data['funding_id'].(isset($this->session->data['reward_id'])?" AND cr.rewards_id=".$this->session->data['reward_id']:""));
        $data['product'] = $query_product->row;

        return $data;
    }

    public function searchProject($funding_id)
    {
        $query = $this->db->query("SELECT funding_id FROM ".DB_PREFIX."crowdfunding WHERE status=15 AND funding_id=".$funding_id);
        $result= $query->row;
        if (isset($result['funding_id']))
        {
            return true;
        }else{
            return false;
        }
    }

    public function showPick($funding_id)
    {
        $query = $this->db->query("SELECT * FROM ".DB_PREFIX."crowdfunding WHERE funding_id <>".$funding_id." AND status=15 AND UNIX_TIMESTAMP(date_ended) > UNIX_TIMESTAMP(now())");
        $result= $query->rows;
        foreach ($result as $k=>$v)
        {
            if ($v['current_goal']!=0)
            {
                $result[$k]['sale'] = ($v['current_goal']/$v['total_goal'])*100;
            }else{
                $result[$k]['sale'] = 0;
            }
            $result[$k]['url'] = $this->url->link('crowdfunding/campaign', 'funding_id='.$v['funding_id']);
            $now = time();
            $before = strtotime($v['date_ended']);
            $long = $before - $now;
            $day = floor($long / (3600 * 24));
            $hour = floor(($long - ($day * (3600 * 24))) / 3600);
            $result[$k]['date_end'] = $day . " day " . $hour . " hours left";
            $result[$k]['introduce']= strlen($result[$k]['introduce'])>=35?substr($result[$k]['introduce'],0,36).'...':$result[$k]['introduce'];
        }
        return $result;
       /* $array = array_rand($result,3);
        $array[0] = $result[$array[0]];
        $array[1] = $result[$array[1]];
        $array[2] = $result[$array[2]];
        foreach ($array as $k=>$v)
        {
            if ($v['current_goal']!=0)
            {
                $array[$k]['sale'] = ($v['current_goal']/$v['total_goal'])*100;
            }else{
                $array[$k]['sale'] = 0;
            }
            $array[$k]['link'] = $this->url->link('crowdfunding/campaign', 'funding_id='.$v['funding_id']);
        }
        return $array;*/

    }

    public function select_my_coupon($customer_id, $total)
    {
        $query = $this->db->query("SELECT coupon_id, balance, minbalance, coupon_code FROM ".DB_PREFIX."mycoupon WHERE customer_id=".$customer_id." AND minbalance <= ".$total." AND  UNIX_TIMESTAMP(totime) >= UNIX_TIMESTAMP(NOW()) AND status=0 ");
        return $query->rows;
    }
   
   public function select_all_address($customer_id)
    {
        $query = $this->db->query("SELECT a.*, c.name AS country, z.name AS zone_name FROM ". DB_PREFIX ."address AS a INNER JOIN ".DB_PREFIX.
            "country AS c ON c.country_id=a.country_id LEFT JOIN ".DB_PREFIX.
            "zone AS z ON a.zone_id=z.zone_id".
            " WHERE customer_id=".$customer_id);
        return $query->rows;
    }

}