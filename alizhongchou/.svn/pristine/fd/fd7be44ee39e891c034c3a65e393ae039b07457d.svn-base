<?php echo $header; 
$theme_options = $registry->get('theme_options');
$config = $registry->get('config'); 
$registry->get('session')->data['new_account_theme'] = 1;
 ?>
 <style>
 .profiletable-top .ul1 li a:visited{
	background:#26C6DA;	
  }
  	.acontantactive{
	background: #26C6DA!important;
	color: #fff!important;
}
 </style>
<div class="profile-all">
	<div class="container">
		<div class="profile row" style="margin-bottom: 30px;">
			<div class="profile-bottom col-lg-3 col-xs-12">
				<div class="profile-tab-ul col-lg-12">
					<div class=" profiletable-top col-lg-12" style="margin-top:0px">
						<ul class="nav nav-tabs ul1" id="acontant_ul">
							<li class="col-lg-12 co-md-12 col-sm-12 col-xs-12 active">
								<a href="#acontant-tabone" class="acontantactive">
									<i class="fa fa-user"></i>
									<span>Edit</span>
								</a>
							</li>
							<li class="col-lg-12 co-md-12 col-sm-12 col-xs-12">
								<a href="#acontant-tabtwo" class="">
									<i class="fa fa-lock"></i>
									<span>Password</span>
								</a>
							</li>
							<!--<li class="col-lg-12 co-md-12 col-sm-12 col-xs-12">
								<a href="#acontant-tabthree" class="">
									<i class="fa fa-truck"></i>
									<span><?php echo $text_address; ?></span>
								</a>
							</li>-->
							<li class="col-lg-12 co-md-12 col-sm-12 col-xs-12">
								<a href="#acontant-tabfour" class="">
									<i class="fa fa-list-alt"></i>
									<span>Order</span>
								</a>
							</li>
							<!--<li class="col-lg-12 co-md-12 col-sm-12 col-xs-12">
								<a href="#acontant-tabfive" class="">
									<i class="fa fa-money"></i>
									<span><?php echo $text_reward; ?></span>
								</a>
							</li>-->
							<li class="col-lg-12 co-md-12 col-sm-12 col-xs-12">
								<a href="#acontant-tabsix" class="">
									<i class="fa fa-refresh"></i>
									<span>Return</span>
								</a>
							</li>
						</ul>
					</div>
				</div>
			</div>
			<div class="profile-tab-content col-lg-9 col-xs-12">
				<div class=" profiletable-bottom col-lg-12">
					<div class="tab-content  acontant-tab">
						<div class="tab-pane fade in active col-lg-12 col-md-12 col-xs-12 " id="acontant-tabone" style="text-transform:uppercase;">
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
							<div class="profile_one col-lg-offset-2 col-lg-8">
								<form  method="post" enctype="multipart/form-data" class="col-lg-12" id='new-match' >

									<p class="photo"><?php echo $entry_photo; ?> </p>
									<div class="circle_img">
										<img src="<?php echo $photo?>" alt="" class="member_img">

								   <input  type="file" class="input-files" id="reviewImageUpload"  accept="image/gif, image/jpeg, image/png, image/jpg" title="Upload Profile Photo" />
									</div>
									  <div class="text-danger" id="file_error" style="display: none"></div>
									<div class="change_photo">
										<input type="button" class="btn " id="photo" data-loading-text="Loading..." value="<?php echo $entry_changephoto; ?> "/>
									</div>
								</form>
								<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" class="col-lg-12">
									<div class="form-group">
										<input type="hidden" name="avatar" value="<?php echo $photo?>">
										<label for="exampleInputEmail1"><span>*</span>NICKNAME</label>
										<input type="text" class="form-control" name="nickname" value="<?php echo $nickname; ?>" placeholder="<?php echo $entry_nickname; ?>" id="input-nickname">
										<?php if ($error_nickname) { ?>
											<div class="text-danger"><?php echo $error_nickname; ?></div>
										<?php } ?>
									</div>
									 <input type="hidden" name="firstname" value="<?php echo $firstname; ?>" placeholder="<?php echo $entry_firstname; ?>" id="input-firstname" class="form-control" />
									 <input type="hidden" name="lastname" value="<?php echo $lastname; ?>" placeholder="<?php echo $entry_lastname; ?>" id="input-lastname" class="form-control" />

									<div class="form-group">
										<label for="exampleInputPassword1"><?php echo $entry_telephone; ?></label>
										<input type="tel" class="form-control" name="telephone" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" value="<?php echo $telephone; ?>" placeholder="<?php echo $entry_telephone; ?>" id="input-telephone" >
										<?php if ($error_telephone) { ?>
										<div class="text-danger">TELEPHONE</div>
										<?php } ?>
									</div>
									<div class="form-group">
										<label for="exampleInputPassword1">EMAIL</label>
										<input type="email" name="email" value="<?php echo $email; ?>" placeholder="<?php echo $entry_email; ?>" id="input-email" class="form-control" >
										<?php if ($error_email) { ?>
										<div class="text-danger"><?php echo $error_email; ?></div>
										<?php } ?>
									</div>
									<div class="form-group">
										<label for="exampleInputPassword1"><?php echo $entry_description; ?></label>
										<textarea rows="4" class="form-control"  name="description" maxlength="140" placeholder="<?php echo $entry_description; ?>" id="input-description"  style="resize:none;"><?php echo $description; ?></textarea>
										<?php if ($error_description) { ?>
										<div class="text-danger"><?php echo $error_description; ?></div>
										<?php } ?>
									</div>
									<div class="submit">
										<button type="submit" class="btn btn-default"><?php echo $entry_save; ?></button>
									</div>
								</form>
							</div>
						</div>
						<div class="tab-pane fade col-lg-12 col-md-12 col-xs-12" id="acontant-tabtwo" style="text-transform:uppercase;"></div>
						<div class="tab-pane fade col-md-12 col-xs-12" id="acontant-tabthree"></div>
						<div class="tab-pane fade col-md-12 col-xs-12" id="acontant-tabfour"></div>
						<div class="tab-pane fade col-md-12 col-xs-12" id="acontant-tabfive"></div>
						<div class="tab-pane fade col-md-12 col-xs-12" id="acontant-tabsix"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	$("input[type='file']").hide();
	$("#photo").on('click',function(){
		$("input[type='file']").click();
	})

	//uoload img
	$('.input-files').change(function (e) {

		if (getObjectURL(this.files[0])) {
			if(typeof(data) == 'undefine'){
				var data = new FormData($("#new-match")[0]);
			}
			var data = new FormData($("#new-match")[0]);
			var files = $("#reviewImageUpload").prop('files');
			for(var i = 0 ;i<files.length;i++){
				var file = files[i];
				if (!file.type.match('image.*')) {
					continue;
				}
				data.append('image[]', file);
			}
			$.ajax({
				url: "index.php?route=account/edit",
				type: 'post',
				data: data,
				dataType:'json',
				cache: false,
				contentType: false,
				processData: false,
				beforeSend: function() {
				$('#photo').button('loading');
				},
				success: function(data) {
				 $('#photo').button('reset');
					if(data.code == 1){
						$('#file_error').hide();
						$('.member_img').attr('src', data.data);
					}else if(data.code == 0){
						$('#file_error').show();
						$('#file_error').html(data.data)
					}else if(data.code == 2){
						location.href=data.data;
					}

				},
				complete :function(){ $('#photo').removeAttr('disabled')}
			});
		}
		function getObjectURL(file) {
			var url = null;
			if (window.createObjectURL != undefined) { // basic
				url = window.createObjectURL(file);
			} else if (window.URL != undefined) { // mozilla(firefox)
				url = window.URL.createObjectURL(file);
			} else if (window.webkitURL != undefined) { // webkit or chrome
				url = window.webkitURL.createObjectURL(file);
			}
			return url;
		}

	})
	//add by nana 2016.11.04
	function editPwd(){
		$.ajax({
			url: 'account/password',
			type: 'post',
			data: $("form[name='resetpwd']").serialize(),
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
						$("#acontant-tabtwo").empty();
						$("#acontant-tabtwo").append(data);

					}

			},
			error: function(xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
		return false;
	}
	function editAddr( link){
		$.ajax({
			url: link,
			type: 'post',
			dataType: 'json',
			data: $("form[id='editAddr']").serialize(),
			beforeSend: function() {
				$('button').attr({disabled:'disabled'})
			},
			complete: function() {
				$('button').removeAttr('disabled')
			},
			success: function(data) {
				$('button').removeAttr('disabled');
				if(data==1){
					location.href='/account/login'
				}
				if(data.success){
					$("[href='#acontant-tabthree']").click();
				}
				if(data.error){
					$('#acontant-tabthree').empty();
					$('#acontant-tabthree').append(data.data);
				}
				$(".scrollup").click();
			},
			error: function(xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
		return false;
	}
</script>
<?php echo $footer; ?>
