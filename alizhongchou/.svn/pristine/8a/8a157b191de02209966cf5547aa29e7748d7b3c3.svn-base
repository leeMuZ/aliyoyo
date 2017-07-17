<div class="editmewaddress">
  <form class="clearfix personal-forem form-horizontal">
	  <div class="form-group" style="margin-bottom:30px;">
		<div class="">
		  <button type="button" class="btn submit-address edit-address">NEW ADDRESS</button>
		</div>
	  </div>
  </form>
  <?php foreach($result as $v){ ?>
  <div class="clearfix addresseding">
	<h4>Default Address</h4>
	<p>
	  <span>Name:</span><span><?php echo $v['firstname'].$v['lastname'] ?></span>
	</p>
	<p>
	  <span>Telephone:</span><span><?php echo $v['telephone'] ?></span>
	</p>
	<p>
	  <span>Company:</span><span><?php echo $v['company'] ?></span>
	</p>
	<p>
	  <span>Street_1:</span><span><?php echo $v['address_1'] ?></span>
	</p>
	<p>
	  <span>Street_2:</span><span><?php echo $v['address_2'] ?></span>
	</p>
	<p>
	  <span>City:</span><span><?php echo $v['city'] ?></span>
	</p>
	<p>
	  <span>Post Code:</span><span><?php echo $v['postcode'] ?></span>
	</p>
	<p>
	  <span>Country:</span><span>China</span>
	</p>
	<p>
	  <span>Region/State:</span><span>Haidian State</span>
	</p>
	 <a href="<?php echo $update.'&address_id='. $v['address_id']; ?>" class="penciladdr"><i class="fa fa-heart modify"></i></a>
	<i class="fa fa-heart-o delete"  data-toggle="modal" id="<?php echo $v['address_id'] ?>"></i>
  </div>
<?php } ?>
  <div class="successful clairefix">
	<i></i> Success: Your information has been saved.
  </div>
  <!-- 模态框 -->
  <div class="modal fade exampleModal"  id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
	  <div class="modal-content">
		<div class="modal-body">
		   <p>Do you realy want to delete this address?</p>
		</div>
		<div class="modal-footer">
		  <div>
			<button type="button" class="btn" data-dismiss="modal">NO</button>
			<button type="button" class="btn yesdelete" >YES</button>
		  </div>
		</div>
	  </div>
	</div>
  </div>
	<!-- 模态框end -->
</div>
<script>
/*$(".edit-address").click(function(event) {
  $(".editmewaddress").hide();
  $(".newpersonal-forem").show();
});*/
  $(".edit-address").on("click",function () {
    addrAjax('account/adress/add','.edit-address','#shipping');

  })
   $(".penciladdr").on("click",function () {
    var urls=$(this).attr('href');
    $(this).attr('href',"javascript:void(0)");
    addrAjax( urls,'.penciladdr','#shipping');
  })

//add by liuxuewen 2017.7.13
	function crateadress(url){
		$.ajax({
			url: url,
			type: 'post',
			data: $("form[name='adress']").serialize(),
			beforeSend: function() {
				$('button').attr({disabled:'disabled'})
			},
			complete: function() {
				$('button').removeAttr('disabled')
			},
			success: function(data) {
					if(data==1){
						location.href='/account/login'
					}else{
						$("#shipping").empty();
						$("#shipping").append(data);
                        $(".newpersonal-forem").show();
						$(".editmewaddress").hide();
					}

			},
			error: function(xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
		return false;
	}
	//add by liuxuewen 2017.7.14
	/*function editadress(){

		$.ajax({
			url: 'account/adress/edit',
			type: 'post',
			data: $("form[name='adress']").serialize(),
			beforeSend: function() {
				$('button').attr({disabled:'disabled'})
			},
			complete: function() {
				$('button').removeAttr('disabled')
			},
			success: function(data) {
					if(data==1){
						location.href='/account/login'
					}else{
						$("#shipping").empty();
						$("#shipping").append(data);
                        $(".newpersonal-forem").hide();
						$(".editmewaddress").hide();
					}

			},
			error: function(xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
		return false;
	}*/
	//add by liuxuewen 2017.7.13
	$('.modify').click(function () {
			var id = $(this).attr("href");
					$.ajax({
						type: 'get',
						url: 'index.php?route=account/adress/info',
						data: 'aid='+id,
						dataType: 'json',
						success: function(res) {
                           $(".editmewaddress").hide();
						   //$(".newpersonal-forem").show();
                           $(".amif").html(res.success);
						  
						}
						});
	    });
$(".delete").click(function(event) {
    $(".yesdelete").attr("data-id",this.id);
    $('#exampleModal').modal('show');
  });
$(".yesdelete").click(function(){
    var id = $(this).attr("data-id");
    console.log(id)
    $("#"+id+"").parent().remove();
    $('#exampleModal').modal('hide');
   $.ajax({
	type: 'get',
	url: 'index.php?route=account/adress/deleted',
	data: 'oid='+id,
	dataType: 'json',
	success: function(res) {
	  $(ob).parent().remove();
	}
	});
    $(".successful").fadeIn(300);
    });
	

	function doDel(){
		var ok1=false;
		var firstname=$('#firstname').val();	
                         if(firstname.length >= 3){
                       
                        ok1=true;
                    }else{
					   $('.fir').html('cuo wu');
					   return false;
                    }
      

	}
           

</script>
