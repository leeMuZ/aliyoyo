<?php echo $header; ?>
	<div class="standard-body" style="margin-top:10px">
		<div class="full-width">
			<div class="container">
			<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" class="form-horizontal" id="form-product">
				<div class="panel-collapse collapse in" id="collapse-payment-address" style="height: auto;">
					<div class="panel-body">
						<div class="popopo col-md-3 col-sm-4">
							<p class="orderin">Order information:</p>
						</div>
						
						<div class="order-right col-md-9 col-sm-8">
							<p>
								<span class="xing-red">*</span>
								<span class="xing-name">Project name:</span>
								<span><?php echo $name ?></span>
							</p>
							<?php foreach($result as $v){ ?>
							<p>
							<input type="hidden" name="order" value="<?php echo $v['order_id'] ?>">
								<span class="xing-red">*</span>
								<span class="xing-name">Back amount:</span>
								<span>$<?php echo sprintf('%.2f', $v['total'] )?></span>
							</p>
							<p>
								<span class="xing-red">*</span>
								<span class="xing-name">Shipping:</span>
								<span>$<?php echo sprintf('%.2f', $v['shipping_price'] )?></span>
							</p>
							<p>
								<span class="xing-red">*</span>
								<span class="xing-name">Refund amount:</span>
								<span>$<?php echo sprintf('%.2f', ($v['shipping_price']+$v['total'])) ?></span>
							</p>
							<p>
								<span class="xing-red">*</span>
								<span class="xing-name">Order ID:</span>
								<span><?php echo $v['order_id'] ?></span>
							</p>
							<?php } ?>
						</div>
					</div>
					<div class="panel-body">
			
						<div class="popopo col-md-3 col-sm-4">
							<p class="orderin">Refund information:</p>
							<span id="block" style="padding-left:110px;color:red"></span>
						</div>
						<div class="order-right col-md-9 col-sm-8">
					
							<div class="projectinformation">
								<p class="xing-radio-p">
									<span class="xing-red">*</span>
									<span class="xing-name">Reason for reture:</span>
								</p>
								<div class="xing-radio-p" id="block">
									<p><input type="radio" name="return_reason_id" value="0" id="input-payment-lastname"> I do not want to buy it</p>
									<p><input type="radio" name="return_reason_id" value="1" id="input-payment-lastname"> I do not want to buy it</p>
									<p><input type="radio" name="return_reason_id" value="2" id="input-payment-lastname"> I do not want to buy it</p>
									<p><input type="radio" name="return_reason_id" value="3" id="input-payment-lastname"> I do not want to buy it</p>
								</div>
							</div>
							<div class="projectinformation">
								<p>
									<span>Faulty or other details:</span>
								</p>
								<textarea name="comment" id="" cols="30" rows="8" placeholder="Faulty or other details"></textarea>
								<p class="projectinformation-btn">
									<!--<input type='submit' class="btn" value="Refunds">-->
								<button type="button" id="btnSubmit" data-toggle="tooltip"  class="btn btn-danger" >Refunds</button>

								</p>
							</div>
						</div>
					</div>
				</div>
				</form>
			</div>
		</div>
	</div>
	<script>
	  $("#btnSubmit").click(function(){   
         var val=$('input:radio[name="return_reason_id"]:checked').val();
         var len=$("#block").val();		 
          if(val==null){   
         
          $("#block").html('please select one');		  
          return false;   
         }else{
			 if(confirm('que ding ti jiao ma')){
				 $('#form-product').submit();
			 }else{
				 false;
			 }
			 
		 }   

	  })		 
	</script>
<?php echo $footer ?>