<?php
class ModelAccountassortment extends Model {
	
     //add by liuxuewen at 20170425 获取分类信息
	public function getcategory() {
		$query = $this->db->query("SELECT name,category_id FROM ".DB_PREFIX."category" );
		return $query->rows;
	}
	public function getname($id) {
		$query = $this->db->query("SELECT name,category_id FROM ".DB_PREFIX."category where category_id=".$id );
		$arr=array();
		foreach($query->rows as $v){
			$arr['name']=$v['name'];
			
		}
		return $arr;
	}

   //add by liuxuewen at 20170425 获取分类商品
	/*public function getproduct($id) {
        $query = $this->db->query("SELECT * FROM ".DB_PREFIX."crowdfunding   WHERE status=15 and category_id = " . (int)$id);
		return $query->rows;
	}*/
	
    //add by liuxuewen at 20170425 获取主分类商品
	public function getproducts($id) {
		if($id==0){
           $query = $this->db->query("SELECT a.name,a.image,a.current_goal,a.total_goal,a.introduce,a.funding_id,a.status,a.date_start,a.date_ended FROM ".DB_PREFIX."crowdfunding as a  WHERE  a.status=15 ");
		}else{
           $query = $this->db->query("SELECT a.name,a.image,a.current_goal,a.total_goal,a.introduce,a.funding_id,a.status,a.date_start,a.date_ended FROM ".DB_PREFIX."crowdfunding as a  WHERE  a.status=15 and a.category_id = " . (int)$id);	
		}
		return $query->rows;
	}

   //add by liuxuewen at 20170503 获取分类商品
	public function getproducte($id,$sid) {
		$query = $this->db->query("SELECT * FROM ".DB_PREFIX."crowdfunding   WHERE status=15 and  category_id = " . (int)$id);
		$arr=array();
        if($sid==3){
		foreach($query->rows as $v){
			if((strtotime($v['date_ended'])-strtotime($v['date_start']))-(strtotime(date('Y-m-d h:i:s',time()))-strtotime($v['date_start']))>0){
			 $arr[]=$v;
			}			
		}
		return $arr;
		}elseif($sid==1){
		  foreach($query->rows as $v){
			if($v['current_goal']>=$v['total_goal']){
			 $arr[]=$v;
			}
			
		 }
		return $arr;		   
		}elseif($sid==2){
		   $query = $this->db->query("SELECT * FROM ".DB_PREFIX."crowdfunding   WHERE status=15 and category_id = " . (int)$id);
		   return $query->rows;
			
		}
	}

      public function getproducta($id,$url) {
        $query = $this->db->query("SELECT a.name,a.image,a.current_goal,a.total_goal,a.introduce,a.funding_id,a.status,a.date_start,a.date_ended FROM ".DB_PREFIX."crowdfunding as a left join ".DB_PREFIX."category as b on a.category_id=b.category_id  WHERE  a.status=15 and parent_id = " . (int)$url);
		$arr=array();
        if($id==3){
		foreach($query->rows as $v){
			if((strtotime($v['date_ended'])-strtotime($v['date_start']))-(strtotime(date('Y-m-d h:i:s',time()))-strtotime($v['date_start']))>0){
			 $arr[]=$v;
			}			
		}
		return $arr;
		}elseif($id==1){
		  foreach($query->rows as $v){
			if($v['current_goal']>=$v['total_goal']){
			 $arr[]=$v;
			}
		  }
          return $arr;		  
		}elseif($id==2){
			$query = $this->db->query("SELECT a.name,a.image,a.current_goal,a.total_goal,a.introduce,a.funding_id,a.status,a.date_start,a.date_ended FROM ".DB_PREFIX."crowdfunding as a left join ".DB_PREFIX."category as b on a.category_id=b.category_id  WHERE  a.status=15 and parent_id = " . (int)$url);
             return $query->rows;
			  
		  }       		
		  
	  }
      public function getproductr($url,$id,$sid) {
		$query = $this->db->query("SELECT * FROM ".DB_PREFIX."crowdfunding   WHERE status=15 and  category_id = " . (int)$url);
		$arr=array();
        if($id==3 && $sid==1){
		foreach($query->rows as $v){
			if((strtotime($v['date_ended'])-strtotime($v['date_start']))-(strtotime(date('Y-m-d h:i:s',time()))-strtotime($v['date_start']))>0 && ((strtotime($v['date_ended'])-strtotime($v['date_start']))-(strtotime(date('Y-m-d h:i:s',time()))-strtotime($v['date_start'])))/86400<=10 ){
			 $arr[]=$v;
			}			
		}
		return $arr;
		}elseif($id==3 && $sid==2){
		  $query = $this->db->query("SELECT * FROM ".DB_PREFIX."crowdfunding   WHERE status=15 and  category_id = " . (int)$url." order by current_goal desc");
		  $arr=array();
		  foreach($query->rows as $v){
			if((strtotime($v['date_ended'])-strtotime($v['date_start']))-(strtotime(date('Y-m-d h:i:s',time()))-strtotime($v['date_start']))>0 && (time()-strtotime($v['date_start']))/86400 < 10 ){
			 $arr[]=$v;
			}			
		  }
		  return $arr;		 
		}elseif($id==3 && $sid==3){
		  $query = $this->db->query("SELECT * FROM ".DB_PREFIX."crowdfunding   WHERE status=15 and  category_id = " . (int)$url);
		  $arr=array();
		  foreach($query->rows as $k=>$v){
			 if((strtotime($v['date_ended'])-strtotime($v['date_start']))-(strtotime(date('Y-m-d h:i:s',time()))-strtotime($v['date_start']))>0){
		      $query = $this->db->query("SELECT COUNT(*) AS total  FROM ".DB_PREFIX."order as c left join ".DB_PREFIX."order_total as b on c.order_id=b.order_id
                                     left join ".DB_PREFIX."crowdfunding_rewards as a on b.rewards_id=a.rewards_id where a.funding_id=".$v['funding_id']);
         
		      $arr[$k]['count']=$query->row['total'];
			  $arr[$k]['name']=$v['name'];
			  $arr[$k]['image']=$v['image'];
			  $arr[$k]['current_goal']=$v['current_goal'];
			  $arr[$k]['total_goal']=$v['total_goal'];
			  $arr[$k]['introduce']=$v['introduce'];
			  $arr[$k]['funding_id']=$v['funding_id'];
			  $arr[$k]['status']=$v['status'];
			  $arr[$k]['date_start']=$v['date_start'];
			  $arr[$k]['date_ended']=$v['date_ended'];
              			  
		   }
		  }
		    $sort = array(  
            'direction' => 'SORT_DESC', //排序顺序标志 SORT_DESC 降序；SORT_ASC 升序  
            'field'     => 'count',       //排序字段  
              );
		    $arrSort = array();  
            foreach($arr AS $uniqid => $row){  
                foreach($row AS $key=>$value){  
                  $arrSort[$key][$uniqid] = $value;  
               }  
            }
            if($sort['direction'] && !empty($arr)){  
                 array_multisort($arrSort[$sort['field']], constant($sort['direction']), $arr);  
             } 			
            return $arr;		  
		}elseif($id==1 && $sid==1){
		  foreach($query->rows as $v){
			if($v['current_goal']>=$v['total_goal'] && ((strtotime($v['date_ended'])-strtotime($v['date_start']))-(strtotime(date('Y-m-d h:i:s',time()))-strtotime($v['date_start'])))/86400<=10  ){
			 $arr[]=$v;
			}
		   }
		  return $arr;
		}elseif($id==1 && $sid==2){
		  $query = $this->db->query("SELECT * FROM ".DB_PREFIX."crowdfunding   WHERE status=15 and  category_id = " . (int)$url." order by current_goal desc");
		  $arr=array();
		  foreach($query->rows as $v){
			if((time()-strtotime($v['date_start']))/86400 < 10 && $v['current_goal']>=$v['total_goal']){
			 $arr[]=$v;
			}			
		  }
		  return $arr;			
		}elseif($id==1 && $sid==3){
		  $query = $this->db->query("SELECT * FROM ".DB_PREFIX."crowdfunding   WHERE status=15 and  category_id = " . (int)$url);
		  $arr=array();
		  foreach($query->rows as $k=>$v){
			 if($v['current_goal']>=$v['total_goal']){
		     $query = $this->db->query("SELECT COUNT(*) AS total  FROM ".DB_PREFIX."order as c left join ".DB_PREFIX."order_total as b on c.order_id=b.order_id
                                     left join ".DB_PREFIX."crowdfunding_rewards as a on b.rewards_id=a.rewards_id where a.funding_id=".$v['funding_id']);
         
		      $arr[$k]['count']=$query->row['total'];
			  $arr[$k]['name']=$v['name'];
			  $arr[$k]['image']=$v['image'];
			  $arr[$k]['current_goal']=$v['current_goal'];
			  $arr[$k]['total_goal']=$v['total_goal'];
			  $arr[$k]['introduce']=$v['introduce'];
			  $arr[$k]['funding_id']=$v['funding_id'];
			  $arr[$k]['status']=$v['status'];
			  $arr[$k]['date_start']=$v['date_start'];
			  $arr[$k]['date_ended']=$v['date_ended'];
              			  
		   }
		  }
		    $sort = array(  
            'direction' => 'SORT_DESC', //排序顺序标志 SORT_DESC 降序；SORT_ASC 升序  
            'field'     => 'count',       //排序字段  
              );
		    $arrSort = array();  
            foreach($arr AS $uniqid => $row){  
                foreach($row AS $key=>$value){  
                  $arrSort[$key][$uniqid] = $value;  
               }  
            }
            if($sort['direction'] && !empty($arr)){  
                 array_multisort($arrSort[$sort['field']], constant($sort['direction']), $arr);  
             } 			
            return $arr;
		}		
      }
	  public function getproductj($sid) {
        $query = $this->db->query("SELECT a.name,a.image,a.current_goal,a.total_goal,a.introduce,a.funding_id,a.status,a.date_start,a.date_ended FROM ".DB_PREFIX."crowdfunding as a  WHERE  a.status=15 ");
        $arr=array();	
		if($sid==1){
		 foreach($query->rows as $v){
			if(((strtotime($v['date_ended'])-strtotime($v['date_start']))-(strtotime(date('Y-m-d h:i:s',time()))-strtotime($v['date_start'])))/86400<=10 ){
			 $arr[]=$v;
			}			
		  }
		 
		 return $arr;
		}elseif($sid==2){	   
          $query = $this->db->query("SELECT a.name,a.image,a.current_goal,a.total_goal,a.introduce,a.funding_id,a.status,a.date_start,a.date_ended FROM ".DB_PREFIX."crowdfunding as a  WHERE  a.status=15 order by a.current_goal desc ");
		  $arr=array();
		  foreach($query->rows as $v){
			if((time()-strtotime($v['date_start']))/86400 <= 10){
			 $arr[]=$v;
			}			
		  }
		  return $arr;
		}elseif($sid==3){
          $query = $this->db->query("SELECT a.name,a.image,a.current_goal,a.total_goal,a.introduce,a.funding_id,a.status,a.date_start,a.date_ended FROM ".DB_PREFIX."crowdfunding as a  WHERE  a.status=15 ");		  
          $arr=array();
		  foreach($query->rows as $k=>$v){
			  $query = $this->db->query("SELECT COUNT(*) AS total  FROM ".DB_PREFIX."order as c left join ".DB_PREFIX."order_total as b on c.order_id=b.order_id
                                     left join ".DB_PREFIX."crowdfunding_rewards as a on b.rewards_id=a.rewards_id where a.funding_id=".$v['funding_id']);
         
		      $arr[$k]['count']=$query->row['total'];
			  $arr[$k]['name']=$v['name'];
			  $arr[$k]['image']=$v['image'];
			  $arr[$k]['current_goal']=$v['current_goal'];
			  $arr[$k]['total_goal']=$v['total_goal'];
			  $arr[$k]['introduce']=$v['introduce'];
			  $arr[$k]['funding_id']=$v['funding_id'];
			  $arr[$k]['status']=$v['status'];
			  $arr[$k]['date_start']=$v['date_start'];
			  $arr[$k]['date_ended']=$v['date_ended'];
		  }
		    $sort = array(  
            'direction' => 'SORT_DESC', //排序顺序标志 SORT_DESC 降序；SORT_ASC 升序  
            'field'     => 'count',       //排序字段  
              );
		    $arrSort = array();  
            foreach($arr AS $uniqid => $row){  
                foreach($row AS $key=>$value){  
                  $arrSort[$key][$uniqid] = $value;  
               }  
            }
            if($sort['direction'] && !empty($arr)){  
                 array_multisort($arrSort[$sort['field']], constant($sort['direction']), $arr);  
             } 			
            return $arr;
		}	  
		  
	  }
	   public function getproductf($url,$sid) {
		$query = $this->db->query("SELECT * FROM ".DB_PREFIX."crowdfunding   WHERE status=15 and  category_id = " . (int)$url);
		$arr=array();		   
		if($sid==1){
		 foreach($query->rows as $v){
			if(((strtotime($v['date_ended'])-strtotime($v['date_start']))-(strtotime(date('Y-m-d h:i:s',time()))-strtotime($v['date_start'])))/86400<=10 ){
			 $arr[]=$v;
			}			
		  }
		 
		 return $arr;
		}elseif($sid==2){
		  $query = $this->db->query("SELECT * FROM ".DB_PREFIX."crowdfunding   WHERE status=15 and  category_id = " . (int)$url." order by current_goal desc");
		  $arr=array();
		  foreach($query->rows as $v){
			if((time()-strtotime($v['date_start']))/86400 < 10){
			 $arr[]=$v;
			}			
		  }
		  return $arr;
		}elseif($sid==3){
		  $query = $this->db->query("SELECT * FROM ".DB_PREFIX."crowdfunding   WHERE status=15 and  category_id = " . (int)$url);
		  $arr=array();
		  foreach($query->rows as $k=>$v){
			  $query = $this->db->query("SELECT COUNT(*) AS total  FROM ".DB_PREFIX."order as c left join ".DB_PREFIX."order_total as b on c.order_id=b.order_id
                                     left join ".DB_PREFIX."crowdfunding_rewards as a on b.rewards_id=a.rewards_id where a.funding_id=".$v['funding_id']);
         
		      $arr[$k]['count']=$query->row['total'];
			  $arr[$k]['name']=$v['name'];
			  $arr[$k]['image']=$v['image'];
			  $arr[$k]['current_goal']=$v['current_goal'];
			  $arr[$k]['total_goal']=$v['total_goal'];
			  $arr[$k]['introduce']=$v['introduce'];
			  $arr[$k]['funding_id']=$v['funding_id'];
			  $arr[$k]['status']=$v['status'];
			  $arr[$k]['date_start']=$v['date_start'];
			  $arr[$k]['date_ended']=$v['date_ended'];
		  }
		    $sort = array(  
            'direction' => 'SORT_DESC', //排序顺序标志 SORT_DESC 降序；SORT_ASC 升序  
            'field'     => 'count',       //排序字段  
              );
		    $arrSort = array();  
            foreach($arr AS $uniqid => $row){  
                foreach($row AS $key=>$value){  
                  $arrSort[$key][$uniqid] = $value;  
               }  
            }
            if($sort['direction'] && !empty($arr)){  
                 array_multisort($arrSort[$sort['field']], constant($sort['direction']), $arr);  
             }			 
            return $arr;
		}
		   
	   }
       public function getproductd($id,$sid,$url) {
        $query = $this->db->query("SELECT a.name,a.image,a.current_goal,a.total_goal,a.introduce,a.funding_id,a.status,a.date_start,a.date_ended FROM ".DB_PREFIX."crowdfunding as a left join ".DB_PREFIX."category as b on a.category_id=b.category_id  WHERE  a.status=15 and parent_id = " . (int)$url);
		$arr=array();
        if($id==3 && $sid==1){
		foreach($query->rows as $v){
			if((strtotime($v['date_ended'])-strtotime($v['date_start']))-(strtotime(date('Y-m-d h:i:s',time()))-strtotime($v['date_start']))>0 && ((strtotime($v['date_ended'])-strtotime($v['date_start']))-(strtotime(date('Y-m-d h:i:s',time()))-strtotime($v['date_start'])))/86400<=10 ){
			 $arr[]=$v;
			}			
		}
		return $arr;		
		}elseif($id==3 && $sid==2){
         $query = $this->db->query("SELECT a.name,a.image,a.current_goal,a.total_goal,a.introduce,a.funding_id,a.status,a.date_start,a.date_ended FROM ".DB_PREFIX."crowdfunding as a left join ".DB_PREFIX."category as b on a.category_id=b.category_id  WHERE  a.status=15 and parent_id = " . (int)$url." order by current_goal desc");
		 $arr=array();	
		  foreach($query->rows as $v){
			if((strtotime($v['date_ended'])-strtotime($v['date_start']))-(strtotime(date('Y-m-d h:i:s',time()))-strtotime($v['date_start']))>0 && (time()-strtotime($v['date_start']))/86400 < 10 ){
			 $arr[]=$v;
			}			
		  }
		  return $arr;		
		}elseif($id==3 && $sid==3){
		  foreach($query->rows as $k=>$v){
			 if((strtotime($v['date_ended'])-strtotime($v['date_start']))-(strtotime(date('Y-m-d h:i:s',time()))-strtotime($v['date_start']))>0){
		      $query = $this->db->query("SELECT COUNT(*) AS total  FROM ".DB_PREFIX."order as c left join ".DB_PREFIX."order_total as b on c.order_id=b.order_id
                                     left join ".DB_PREFIX."crowdfunding_rewards as a on b.rewards_id=a.rewards_id where a.funding_id=".$v['funding_id']);
         
		      $arr[$k]['count']=$query->row['total'];
			  $arr[$k]['name']=$v['name'];
			  $arr[$k]['image']=$v['image'];
			  $arr[$k]['current_goal']=$v['current_goal'];
			  $arr[$k]['total_goal']=$v['total_goal'];
			  $arr[$k]['introduce']=$v['introduce'];
			  $arr[$k]['funding_id']=$v['funding_id'];
			  $arr[$k]['status']=$v['status'];
			  $arr[$k]['date_start']=$v['date_start'];
			  $arr[$k]['date_ended']=$v['date_ended'];
              			  
		   }
		  }
		    $sort = array(  
            'direction' => 'SORT_DESC', //排序顺序标志 SORT_DESC 降序；SORT_ASC 升序  
            'field'     => 'count',       //排序字段  
              );
		    $arrSort = array();  
            foreach($arr AS $uniqid => $row){  
                foreach($row AS $key=>$value){  
                  $arrSort[$key][$uniqid] = $value;  
               }  
            }
            if($sort['direction'] && !empty($arr)){  
                 array_multisort($arrSort[$sort['field']], constant($sort['direction']), $arr);  
             } 			
            return $arr;			
		}elseif($id==1 && $sid==1){
		  foreach($query->rows as $v){
			if($v['current_goal']>=$v['total_goal'] && ((strtotime($v['date_ended'])-strtotime($v['date_start']))-(strtotime(date('Y-m-d h:i:s',time()))-strtotime($v['date_start'])))/86400<=10  ){
			 $arr[]=$v;
			}
		   }
		  return $arr;
		}elseif($id==1 && $sid==2){
         $query = $this->db->query("SELECT a.name,a.image,a.current_goal,a.total_goal,a.introduce,a.funding_id,a.status,a.date_start,a.date_ended FROM ".DB_PREFIX."crowdfunding as a left join ".DB_PREFIX."category as b on a.category_id=b.category_id  WHERE  a.status=15 and parent_id = " . (int)$url." order by current_goal desc");
		 $arr=array();
		  foreach($query->rows as $v){
			if((time()-strtotime($v['date_start']))/86400 < 10 && $v['current_goal']>=$v['total_goal']){
			 $arr[]=$v;
			}			
		  }
		  return $arr;			
		}elseif($id==1 && $sid==3){
		  foreach($query->rows as $k=>$v){
			 if($v['current_goal']>=$v['total_goal']){
		     $query = $this->db->query("SELECT COUNT(*) AS total  FROM ".DB_PREFIX."order as c left join ".DB_PREFIX."order_total as b on c.order_id=b.order_id
                                     left join ".DB_PREFIX."crowdfunding_rewards as a on b.rewards_id=a.rewards_id where a.funding_id=".$v['funding_id']);
         
		      $arr[$k]['count']=$query->row['total'];
			  $arr[$k]['name']=$v['name'];
			  $arr[$k]['image']=$v['image'];
			  $arr[$k]['current_goal']=$v['current_goal'];
			  $arr[$k]['total_goal']=$v['total_goal'];
			  $arr[$k]['introduce']=$v['introduce'];
			  $arr[$k]['funding_id']=$v['funding_id'];
			  $arr[$k]['status']=$v['status'];
			  $arr[$k]['date_start']=$v['date_start'];
			  $arr[$k]['date_ended']=$v['date_ended'];
              			  
		   }
		  }
		    $sort = array(  
            'direction' => 'SORT_DESC', //排序顺序标志 SORT_DESC 降序；SORT_ASC 升序  
            'field'     => 'count',       //排序字段  
              );
		    $arrSort = array();  
            foreach($arr AS $uniqid => $row){  
                foreach($row AS $key=>$value){  
                  $arrSort[$key][$uniqid] = $value;  
               }  
            }
            if($sort['direction'] && !empty($arr)){  
                 array_multisort($arrSort[$sort['field']], constant($sort['direction']), $arr);  
             } 			
            return $arr;			
		}
		
	  }		   

}
