<?php if (isset($error_warning)) { ?>
<?php if ($error_warning) { ?>
<div class="warning">
  <button type="button" class="close" data-dismiss="alert">&times;</button>
  <?php echo $error_warning; ?>
</div>
<?php } ?>
<?php } ?>

<?php if (isset($success)) { ?>
<?php if ($success) { ?>
<div class="alert alert-success success">
  <button type="button" class="close" data-dismiss="alert">&times;</button>
  <?php echo $success; ?>
</div>
<?php } ?>
<?php } ?>
<?php unset($registry->get('session')->data['new_product_theme']);?>
<div class="profile_one col-lg-12 col-sm-12 col-xs-12">
  <div class="new_address col-lg-12 col-sm-12 col-xs-12">
    <div class="new_addredd_btn">
      <button class="btn newaddress">
        <i class="fa fa-plus"></i>
        <?php echo $button_new_address; ?>
      </button>
    </div>
  </div>
  <?php if ($addresses) { ?>
  <?php foreach ($addresses as $k => $result) { ?>
  <?php if($registry->get("customer")->getAddressId()){
  if($k==0){ ?>
  <div class="add_address col-lg-12 col-sm-12 col-xs-12">
    <div class="default_all">
      <p class="default">DEFAULT ADDRESS</p>
      <div class="message">
        <?php echo $result['address']; ?>
      </div>
      <a href="<?php echo $result['update']; ?>" class="penciladdr"><button class="btn pen"><i class="fa fa-pencil"></i></button></a>
      <a href="<?php echo $result['delete']; ?>"  class="deladdr"><button class="btn deleat"><i class="fa fa-trash-o"></i></button></a>
      <!-- <button class="btn set">SET AS DEFAULT</button> -->
    </div>
  </div>
  <?php } else { ?>
  <div class="add_address col-lg-12 col-sm-12 col-xs-12">
    <div class="default_all">
      <div class="message">
        <?php echo $result['address']; ?>
      </div>
      <a href="<?php echo $result['update']; ?>" class="penciladdr"><button class="btn pen"><i class="fa fa-pencil"></i></button></a>
      <a href="<?php echo $result['delete']; ?>"  class="deladdr"><button class="btn deleat"><i class="fa fa-trash-o"></i></button></a>
      <button class="btn set1" onclick="setdefault(<?php echo $result['address_id']; ?>)">SET AS DEFAULT</button>
    </div>
  </div>
          <?php }}else { ?>
  <div class="add_address col-lg-12 col-sm-12 col-xs-12">
    <div class="default_all">
      <div class="message">
        <?php echo $result['address']; ?>
      </div>
      <a href="<?php echo $result['update']; ?>" class="penciladdr"><button class="btn pen"><i class="fa fa-pencil"></i></button></a>
      <a href="<?php echo $result['delete']; ?>"  class="deladdr"><button class="btn deleat"><i class="fa fa-trash-o"></i></button></a>
      <button class="btn set1" onclick="setdefault(<?php echo $result['address_id']; ?>)">SET AS DEFAULT</button>
    </div>
  </div>
  <?php }} ?>
  <div class="pagination-results col-lg-12 col-sm-12 col-xs-12">
    <div class="col-sm-6 col-xs-12 text-left">
      <?php echo $pagination; ?>
    </div>
    </div>
  <?php } else { ?>
  <div class="add_address col-lg-12 col-sm-12 col-xs-12">
    <div class="default_all">
      <div class="message">
  <p><?php echo $text_empty; ?></p>
  </div></div></div>
  <?php } ?>
</div>
<script>
  $(".newaddress").on("click",function () {
    addrAjax( 'account/address/add','.newaddress','#acontant-tabthree');

  })
  $(".penciladdr").on("click",function () {
    var urls=$(this).attr('href');
    $(this).attr('href',"javascript:void(0)");
    addrAjax( urls,'.penciladdr','#acontant-tabthree');
  })
  $(".deladdr").on("click",function () {
    var urls=$(this).attr('href');
    $(this).attr('href',"javascript:void(0)");
    addrAjax( urls,'.deladdr','#acontant-tabthree');
    $(".scrollup").click();
  })
  function setdefault(addrId){
    $.ajax({
      url: 'account/address/setDefauleAddr',
      type: 'post',
      dataType: 'json',
      data: "address_id="+addrId,
      beforeSend: function() {
        $('button').attr({disabled:'disabled'})
      },
      complete: function() {
        $('button').removeAttr('disabled')
      },
      success: function(data) {
        if(data.code=="success"){
          $("[href='#acontant-tabthree']").click()
        }
      },
      error: function(xhr, ajaxOptions, thrownError) {
        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
      }
    });
    return false;
  }

  $("#acontant-tabthree .pagination a").on("click",function(){
    var urls=$(this).attr('href');
    $(this).attr('href',"javascript:void(0)");
    addrAjax( urls,'#acontant-tabthree .pagination a','#acontant-tabthree');
    $(".scrollup").click();
  })

</script>
