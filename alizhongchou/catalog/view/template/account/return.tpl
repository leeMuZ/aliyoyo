<div class="profile_one col-lg-12 five_profile col-sm-12 col-xs-12">
  <div class="date_added col-lg-12 added col-sm-12 col-xs-12" style="text-transform:uppercase;">
    <p class="col-lg-3 col-sm-3 col-xs-3">RETURN ID</p>
    <p class="col-lg-2 col-sm-2 col-xs-2">STATUS</p>
    <p class="col-lg-2 col-sm-2 col-xs-4">DATE ADDED</p>
    <p class="col-lg-2 col-sm-2 col-xs-3">ORDER ID</p>
  </div>
  <?php if ($returns) { ?>
  <?php foreach ($returns as $return) { ?>
  <div class="date_added_num col-lg-12 col-sm-12 col-xs-12">
    <p class="col-lg-3 col-sm-3 col-xs-3">#<?php echo $return['return_id']; ?></p>
    <p class="col-lg-2 col-sm-2 col-xs-3"><?php echo $return['name']; ?></p>
    <p class="col-lg-2 col-sm-2 col-xs-3"><?php echo date("Y-m-d",time($return['date_added'])); ?></p>
    <p class="col-lg-2 col-sm-2 col-xs-3"><?php echo $return['order_id']; ?></p>
    <p class="col-lg-3 col-sm-3 col-xs-12 eye">
      <a href="" data-toggle="tooltip" title="" class="view">
      <button class="btn">
        <i class="fa fa-eye"></i>
      </button>
      </a>
    </p>
  </div>
  <?php }?>

  <?php } else { ?>
  <div class="date_added col-lg-12 added col-sm-12 col-xs-12">
    <P class="col-lg-12 col-sm-12 col-xs-12">
	  <center>
	 <div class="user_avatar " >
	   <img src="image/Profile_Photo-60x60.png" style="width:100px;height:100px">
	   <span >Nothing</span>
	 </div>
	</center>
    </P>
  </div>
  <?php } ?>
</div>
<div class="pagination-results col-lg-12 col-sm-12 col-xs-12">
  <?php echo $pagination; ?>
</div>
<script>
  $("#acontant-tabsix .view").on("click",function(){
    var urls=$(this).attr('href')
    $(this).attr('href',"javascript:void(0)");
    addrAjax( urls,'#acontant-tabsix .view','#acontant-tabsix');
    $(".tooltip").hide();
  })

  $("#acontant-tabsix .pagination a").on("click",function(){
    var urls=$(this).attr('href')
    $(this).attr('href',"javascript:void(0)")
    addrAjax( urls,"#acontant-tabsix .pagination a",'#acontant-tabsix');
    $(".scrollup").click();
  })

</script>
