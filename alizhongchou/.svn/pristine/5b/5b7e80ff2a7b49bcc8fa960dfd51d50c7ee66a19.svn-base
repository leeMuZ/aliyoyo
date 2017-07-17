<?php
class ModelAccountreward extends Model {
	
	//add by liuxuewen at 20170408 获取未使用优惠券信息
	 public function getcouponno() {

	    $query = $this->db->query("SELECT  a.balance,a.days,b.customer_id,b.status FROM ".DB_PREFIX."coupon as a left join ".DB_PREFIX."mycoupon as b on a.coupon_id=b.coupon_id where b.status=0 AND '".date('Y-m-d H:i:s',time())."' < a.days AND b.customer_id=". (int)$this->customer->getId());
		return $query->rows;

     }

     
     //add by liuxuewen at 20170408 获取已使用优惠券信息
	 public function getcouponpass() {

	    $query = $this->db->query("SELECT  a.balance,a.days,b.customer_id,b.status FROM ".DB_PREFIX."coupon as a left join ".DB_PREFIX."mycoupon as b on a.coupon_id=b.coupon_id where b.status=1 AND '".date('Y-m-d H:i:s',time())."' < a.days AND b.customer_id=". (int)$this->customer->getId());
		return $query->rows;

     }

   
    //add by liuxuewen at 20170408 获取过期优惠券信息
	 public function getcouponinvalid () {

	    $query = $this->db->query("SELECT  a.balance,a.days,b.customer_id,b.status FROM ".DB_PREFIX."coupon as a left join ".DB_PREFIX."mycoupon as b on a.coupon_id=b.coupon_id where b.status=0 AND '".date('Y-m-d H:i:s',time())."' > a.days AND b.customer_id=". (int)$this->customer->getId());
		return $query->rows;



     }

}

