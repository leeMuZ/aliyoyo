<style> 
.btn-danger {
    color: #aaaaaa;
    background-color: white;
    border-color: #aaaaaa;
	width: 50px;

    border: 1px solid #aaaaaa;
    border-radius: 0;
    height: 40px;
}
.btn-danger:hover{
   background-color: #aaaaaa;
   border-color:#aaaaaa;
}

.views {
    width: 150px;
    background: #fff;
    border: 1px solid #aaaaaa;
    border-radius: 0;
    height: 40px;
}


</style>
<div class="profile_one col-lg-12" id="topp">
  <?php if ($result) { ?>
  <?php foreach ($result as $order) { 
  ?>
     
  <div class="payment col-lg-12 col-sm-12 col-xs-12">
    <div class="complete col-lg-12 col-md-12 col-sm-12 col-xs-12">
      <p class="date col-lg-2 col-sm-2 col-xs-3">
        <span><?php echo date('Y-m-d',time($order['date_added'])) ?></span>
      </p>
      <p class="danhao col-lg-3 col-sm-3 col-xs-2">
        <span>#<?php echo $order['order_id']; ?></span>
      </p>
      <p class="comp col-lg-offset-4 col-lg-3 col-sm-offset-4 col-sm-3  col-xs-offset-2 col-xs-5">
        <span><?php echo $order['ename']; ?></span> 
      </p>
	  <p class="danhao col-lg-3 col-sm-3 col-xs-2">
    </div>
    <div class="card col-lg-12 col-sm-12 col-xs-12" >
      <div class="card_list_img l" style="width:100px;height:60px">
	    <?php if(!empty($order['image'])){ ?>
          <img src="<?php echo HTTP_Aliyoyo.'image/'.$order['image'] ?>" alt="" style="width:100px;height:60px">
        <?php }else{ ?>
		  <img src="<?php echo HTTP_Aliyoyo.'image/cache/no_image-700x420.jpg' ?>" alt="" style="width:100px;height:60px">
		<?php } ?>
	  </div>
      <div class="card_list_word col-lg-5 col-sm-7 col-xs-7" style="width:60%">
        <p style="float:left;width:75%"><?php echo $order["crowdfunding_name"]?></p>
		<p style="float:left;width:15%;margin-left:10%;padding-top:20px"><?php echo $order['name']; ?></p>
      </div>

      <div class="card_list_price col-lg-offset-3 col-lg-1 col-sm-offset-1 col-sm-1  col-xs-1" style="width:3%;margin-left:-2%;padding-top:15px" >
        <span>$<?php echo floatval($order['total']); ?></span>
      </div>
      <div class="card_list_btn r hidden-sm hidden-xs " style="margin-top:5px">
	    <?php if($order['ename']=='Shipped' || $order['ename']=='Payment Complete' ){ ?>
            <a href="<?php echo $url.'&uid='.$order['order_id'].'&name='.$order['crowdfunding_name'] ?>"><button class="btn"><b>Refund</b></button></a> 
		<?php }elseif($order['ename']=='Canceled' || $order['ename']=='Refunded'){ ?>
		    <a href="#"><button class="btn"><b>Payment</b></button></a>
		<?php }else{ ?>
		 <a href=""> <button class="btn"><b>Refunded</b></button></a>
		<?php } ?>
      </div>
    </div>
   
    <div class="product col-lg-12 col-sm-12 col-xs-12">
      <p class="col-lg-offset-5 col-lg-7">
        &nbsp;&nbsp;&nbsp;&nbsp;Total:<span class="red">$<?php echo $order['total']+$order['shipping_price']; ?></span>(Shipping fee<?php echo number_format($order['shipping_price'],2); ?>)</p>
	 <a href="<?php echo $src.'&order_id='.$order['order_id'] ?>"><button class="views">View more</button></a>
	 <?php if($order['ename']=='Canceled' || $order['ename']=='Refunded'){ ?>
	  <a href="javascript:void(0)" onclick="doDel(<?php echo $order['order_id']  ?>,this)"><button  style="margin-top:7px;margin-right:7px" type="button" data-toggle="tooltip" title="" class="btn-danger"><i class="fa fa-trash-o"></i></button></a>
     <?php } ?>
    </div>
  </div>
  <?php } ?>
  <div class="pagination-results col-lg-12 no-margin">
    <div class="col-sm-6 col-xs-12 text-left">
      <?php echo $pagination; ?>
    </div>
  </div>
  <?php } else { ?>
  <div class="payment col-lg-12 col-sm-12 col-xs-12">
    <div class="complete col-lg-12">
  <p class="l" style="line-height: 43px;">
	  <center>
	 <div class="user_avatar " >
	   <img src="image/Profile_Photo-60x60.png" style="width:100px;height:100px">
	   <span >Nothing</span>
	 </div>
	</center>
  </p>
      </div></div>
  <?php } ?>
</div>
<script>
      function doDel(id,ob){
          
            if(confirm('are you sure you want to delete？')){
      
				  $.ajax({
 
						type: 'get',
						url: 'index.php?route=account/order/info',
						data: 'oid='+id,
						dataType: 'json',
						success: function(res) {
						  $(ob).parent().parent().remove();
						}
						});
            }
        }
  $("#acontant-tabfour .pagination a,#acontant-tabfour .view").on("click",function(){
    var urls=$(this).attr('href')
    $(this).attr('href',"javascript:void(0)")
    addrAjax( urls,'#acontant-tabfour .pagination a,#acontant-tabfour .view','#acontant-tabfour');
    $(".scrollup").click();
  })
</script>
