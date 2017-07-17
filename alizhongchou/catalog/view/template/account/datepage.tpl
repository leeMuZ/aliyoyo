<?php echo $header; ?>
             			<?php if (isset($success)) { ?>
							<?php if ($success) { ?>
							<div class="alert alert-success success">
								<button type="button" class="close" data-dismiss="alert">&times;</button>
								<?php echo $success; ?>
							</div>
							<?php } ?>
							<?php } ?>
				<div class="container">
					<!-- backers -->
					<div class="backers clearfix col=sm-12">
						<div class="clearfix col-sm-12 backers-top">
							<span>Explore categories</span>
							<a href="<?php echo $href.'&src='.$src ?>" class="backer-more">View more</a>
						</div>
						<div class="backers-bottom clearfix col-sm-12">
							<table class="backerstable">
								<thead class="backerstable-thead">
									<tr>
										<td><i class="fa fa-user"></i> Name</td>
										<td><i class="fa fa-money"></i>Money</td>
										<td><i class="fa fa-tag"></i>Type</td>
										<td><i class="fa fa-map-marker"></i>Location </td>
										<td><i class="fa fa-phone"></i>Phone</td>
										<td><i class="fa fa-envelope"></i>Email </td>
										<td><i class="fa fa-calendar"></i>Date</td>
										<td></td>
									</tr>
								</thead>
								<tbody class="backerstable-tbody">
								  <?php foreach($result as $v){
									  if(!empty($v['shipping_telephone'])){
									  ?>
									<tr>
										<td><?php echo $v['shipping_firstname'].$v['shipping_lastname'] ?></td>
										<td><?php echo '$'.floatval($v['total']) ?></td>
										<td><?php echo $v['name'] ?></td>
										<td><?php echo $v['shipping_country'] ?></td>
										<td><?php echo $v['shipping_telephone'] ?></td>
										<td><?php echo $v['email'] ?></td>
										<td><?php echo date('Y-m-d',time($v['date_added'])) ?></td>
										<td class="center-td faeye" href="<?php echo $v['order_id']?>" rel="<?php echo $v['name'] ?>" ><i class="fa fa-eye"></i></td>
									</tr>
                                  <?php } }?>

									<!-- xiaoyanjing -->
									<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
									  	<div class="modal-dialog eyedialog" role="document">
									    	<div class="modal-content">
									      		<div class="modal-header">
									        		<button type="button" class="close" data-dismiss="modal" aria-label="Close">
									        			<span aria-hidden="true">
									        				<i class="fa fa-close"></i>
									        			</span>
									        		</button>
									       			<h4 class="modal-title" id="myModalLabel">View supporters information</h4>
									      		</div>
										        <div class="modal-body">
										        	<p class="pxinxi">
										        		<span class="spanicon">
										        			<i class="fa fa-user"></i>Name：
										        		</span>
										        		<span>Yang.yang.yang</span>
										        	</p>
										        	<p class="pxinxi">
										        		<span class="spanicon">
										        			<i class="fa fa-money"></i>Money：
										        		</span>
										        		<span>$399</span>
										        	</p>
										        	<p class="pxinxi">
										        		<span class="spanicon">
										        			<i class="fa fa-tag"></i>Type：
										        		</span>
										        		<span>Early birds</span>
										        	</p>
										        	<p class="pxinxi">
										        		<span class="spanicon">
										        			<i class="fa fa-map-marker"></i>Phone：
										        		</span>
										        		<span>+86 475 4781 4445</span>
										        	</p>
										        	<p class="pxinxi">
										        		<span class="spanicon">
										        			<i class="fa fa-phone"></i>Email：
										        		</span>
										        		<span>dkaadasdasdasdassada@gmail.com</span>
										        	</p>
										        	<p class="pxinxi">
										        		<span class="spanicon">
										        			<i class="fa fa-envelope"></i>Date：
										        		</span>
										        		<span>2017.12.04  10:21AM</span>
										        	</p>
										        	<p class="pxinxi">
										        		<span class="spanicon">
										        			<i class="fa fa-calendar"></i>Location：
										        		</span>
										        		<span><i class="redmap"></i>Zhongguancun venture building 1008，Beijing，China</span>
										        	</p>
										        </div>
											</div>
									  	</div>
									</div>
								</tbody>
							</table>
						</div>
					</div>
					<!-- Video Plays -->
					<!--<div class="videoplays clearfix col-sm-12">
						<div class="videoplays-left col-sm-3">
							<p class="pone">Project Video Plays</p>
							<p class="ptwo">1,810</p>
							<p class="pthree">20.49% of plays completed</p>
						</div>
						<div class="videoplays-right col-sm-9">
							<p class="pone">Google Analytics tracking ID</p>
							<p class="pthree">Enter your Google Analytics tracking ID to enable Google Analytics for your project.</p>
							<div class="clearfix col-sm-11 videoplays-div">
								<input type="text" class="col-sm-8" value="UA XXXXXXXXX-X">
								<button class="btn col-sm-3">Enable tracking</button>
							</div>
						</div>
					</div>-->
					<!-- postupdate -->
					<div class="postupdate  clearfix col-sm-12">
					  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" class="form-horizontal">
						<input type="hidden" value="<?php echo $src ?>" name="funding_id" class="hidden">
						<input type="hidden" value="<?php if(!empty($update)){ echo $update['update_id']; } ?>" name="update_id" class="hidden">
						<div class="clearfix col-sm-12 backers-top">
							<span>Post an update</span>
						</div>
						<div class="postupdate-bottom-left col-sm-7">
							<input type="text" class="col-sm-12" name="title" value="">
							
							<textarea id="editor" class="clearfix col-sm-12" name="content"></textarea>
  							
							
						</div>
						<div class="postupdate-bottom-right col-sm-5">
							<h5 class="inline-block">
								Who can view this post?
							</h5>
							<div class="ksr_toggle mb3 mb7-sm">
								<div class="bg show"></div>
								<div class="radio-div">
									<input type="radio" id="ip1" value="0" name="post_type">
									<label class="public" for="ip1">
										<span class="ss-icon ss-unlock margin-right"></span>
										Anyone
										
									</label>
								</div>
								<div class="radio-div selected">
									<input type="radio" id="ip2" value="1" name="post_type"  checked="checked">	
									<label class="private "  for="ip2"  style='color:#353535'>
										<span class="ss-icon ss-lock margin-right"></span>
										Backers
									</label>
								</div>
								

								<!--<input type="hidden" value="0" name="post" id="post_public" class="hidden">-->
							</div>
						</div>
						<div class="sumitbutton clearfix col-sm-12">
						    <input type="submit" value="Save & Publish" class="btn">
						</div>
						</form>
					</div>
				
	</div>

<!--<script src="js/bootstrap.min.js"></script>
<script src="catalog/view/javascript/swiper-3.3.1.min.js"></script>-->
<script type="text/javascript" src="catalog/view/javascript/summernote/summernote.js"></script>
<!-- <script src="js/ceshi.js"></script> -->
<script>


	$('.faeye').each(function(index, el) {
		$(this).click(function () {
        	//$('#myModal').modal('show');
			var id = $(this).attr("href");
			var rel = $(this).attr("rel");
					$.ajax({
						type: 'get',
						url: 'index.php?route=account/datepage/info',
						data: 'oid='+id+"&rel="+rel,
						dataType: 'json',
						success: function(res) {
						  //alert(res.success);
						   $('#myModal').html(res.success);
						   $('#myModal').modal('show')
						}
						});
	    });
	});

	// summernote
	$('#editor').summernote({
		// disableDragAndDrop:true
		height: 200,
		toolbar: [
			['style', ['bold', 'italic','style']],
			['layout',['ul']],
			['insert', ['link','video','picture']],
			
		        ],
		 callbacks: {
			 onChange: function(contents, $editable) {
			      $('.validate-preserve').show();
			    },
        	    onImageUpload: function(files) {
        	      var formData = new FormData();
	        	  	for (var i = 0; i < files.length; i++) {
	        	  		 var file = files[i];
	        	  		if (!file.type.match('image.*')) {
		        	  		alert("is not image")
	        	  		    continue;
	        	  		  }
        	          formData.append('image[]',file);
	        	  	}
        	   
        	  		
        	      $.ajax({
        	        url : 'index.php?route=project/crowdfund/summernoteUpload',
        	        type : 'POST',
        	        data : formData,
        	        processData : false,
        	        contentType : false,
        	        beforeSend: function() {
						$('.note-editing-area .note-editable').after('<div class="minsert-progress active progress-striped " > <div class="progress-bar" role="progressbar" aria-valuemin="0" aria-valuemax="100" style="width: 100%"> </div> </div>')	
					},
					complete :function(){
						$('.minsert-progress').remove();
					},
        	        success : function(data) {
	        	        if(data['sys_error']){
		        	        alert(data['sys_error']);
		        	        }else{
	        	        	for (var i = 0; i < data['count']; i++) {
	        	        if(data['images'][i]['success']){
        	          $('#editor').summernote('insertImage',data['images'][i]['url'],'img');
		        	        }else{
                              alert(data['images'][i]['error']);
			        	        }
	        	        	}
			        	        }
        	        }
        	      });
        	    }
        	  }

	});

	$(document).ready(function(){
		var aa=$(".bg");
		aa.css({
		    'left': aa.width()
	   		});

	});
	$('.ksr_toggle .radio-div').on('click', function (e) {
		$(this).addClass('selected');
    	$(this).siblings(".radio-div").removeClass('selected');
		$(this).siblings('.bg').css({
     	 'left': $(this).position().left
   		})
  
  	});

 



</script>	


<?php echo $footer; ?>
