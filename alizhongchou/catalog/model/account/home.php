<?php
class ModelAccountHome extends Model
{

    //add by liuxuewen at 20170408 删除收藏过的商品
    public function deleteWishlist($funding_id)
    {
        $this->db->query("DELETE FROM " . DB_PREFIX . "crowdfunding_remind WHERE  funding_id = " . $funding_id);
    }

    //add by liuxuewen at 20170408 取消自己添加的商品
    public function deleteproduct($funding_id)
    {
        $this->db->query("DELETE FROM " . DB_PREFIX . "crowdfunding WHERE customer_id = '" . (int)$this->customer->getId() . "' AND funding_id = '" . $funding_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "crowdfunding_description WHERE  funding_id = " . $funding_id);
        $this->db->query("DELETE FROM " . DB_PREFIX . "crowdfunding_rewards WHERE  funding_id = " . $funding_id);
        $this->db->query("DELETE FROM " . DB_PREFIX . "crowdfunding_updates WHERE  funding_id = " . $funding_id);

    }


    //add by liuxuewen at 20170408 收藏过的商品
    public function getcrowdfunding()
    {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "crowdfunding_remind as a left join " . DB_PREFIX . "crowdfunding as b on b.funding_id=a.funding_id where b.status=15 and a.customer_id = '" . (int)$this->customer->getId() . "'");

        return $query->rows;
    }

    public function customer($uid)
    {
        $total = $this->db->query("SELECT COUNT(*) AS total from " . DB_PREFIX . "customer WHERE customer_id=" . $uid);
        return $total->row['total'];
    }

    //add by liuxuewen at 20170408 用户发布过的商品
    public function getcrowdfundings($uid)
    {
		if(empty($uid) || $uid==$this->customer->getId()){
          $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "crowdfunding   WHERE customer_id = '" . (int)$uid . "'");
        }else{
		  $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "crowdfunding   WHERE status=15 and customer_id = '" . (int)$uid . "'");
		}
        return $query->rows;
    }

    //add by liuxuewen at 20170408 获取众筹的商品
    public function getproduct()
    {
        $query = $this->db->query("SELECT d.name,d.image,d.recommend,d.current_goal,d.total_goal,d.introduce,d.funding_id,a.order_status_id,d.status,d.date_ended,d.date_start FROM " . DB_PREFIX . "order as a left join " . DB_PREFIX . "order_total as b on b.order_id=a.order_id
                                     left join " . DB_PREFIX . "crowdfunding_rewards as c on c.rewards_id=b.rewards_id 
									 left join " . DB_PREFIX . "crowdfunding as d on d.funding_id=c.funding_id 
                                     WHERE a.order_status_id=15 and a.customer_id = '" . (int)$this->customer->getId() . "'");

        return $query->rows;
    }

    public function getCustomer($customer_id)
    {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "customer WHERE customer_id = '" . (int)$customer_id . "'");
        return $query->row;
    }

    //add by liuxuewen at 20170511 关注的商品的数量
    public function total()
    {
        $query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "crowdfunding_remind as a left join " . DB_PREFIX . "crowdfunding as b on b.funding_id=a.funding_id where b.status=15 and a.customer_id = '" . (int)$this->customer->getId() . "'");
        return $query->row['total'];
    }

    //add by liuxuewen at 20170511 众筹的商品的数量
    public function total1()
    {
        $query = $this->db->query("SELECT COUNT(c.rewards_id) AS total FROM " . DB_PREFIX . "order as a left join " . DB_PREFIX . "order_total as b on b.order_id=a.order_id
                                     left join " . DB_PREFIX . "crowdfunding_rewards as c on c.rewards_id=b.rewards_id 
									 left join " . DB_PREFIX . "crowdfunding as d on d.funding_id=c.funding_id 
                                     WHERE a.order_status_id=15 and a.customer_id = '" . (int)$this->customer->getId() . "'");
        return $query->row['total'];
    }

    //add by liuxuewen at 20170511 发布的商品的数量
    public function total2($uid)
    {
        $query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "crowdfunding where  customer_id = " . (int)$uid);
        return $query->row['total'];
    }

    public function categoryMessage()
    {
        $query = $this->db->query("SELECT category_id, name FROM ".DB_PREFIX."category");
        $result= $query->rows;
        foreach ($result as $k=>$v)
        {
            $result[$k]['category_link'] = $this->url->link("account/assortment","url=".$v['category_id']);
        }
        return $result;
    }
}
