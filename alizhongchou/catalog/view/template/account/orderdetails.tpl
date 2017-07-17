<?php echo $header; ?>
  <div class="standard-body" style="margin-top:20px">
	<div class="full-width">
		<div class="container">
			<div class="product-all  col-md-12 col-sm-12">
				<div class="container">
					<div class="product row">
						<div class="order_all ">
							<p class="order order-first upper">Order History</p>
						</div>
						<div class="product_content_all col-sm-12" style="padding:0;">
						  <?php foreach($history as $v) {?>
							<div class="product_content product_table col-md-12 col-xs-12  ">
								<div class="product_content_cont col-sm-4 col-xs-3"><?php echo $v['date_added']?></div>
								<div class="product_content_cont col-sm-4 col-xs-3"><?php echo $v['status']?></div>
								<div class="product_content_cont col-sm-4 col-xs-6"></div>
							</div>
						  <?php } ?>
						  <?php foreach($arr as $v) {?>
							<div class="product_content product_table col-md-12 col-xs-12  mored" style="display: none;">
								<div class="product_content_cont col-sm-4 col-xs-3"><?php echo $v['date_added']?></div>
								<div class="product_content_cont col-sm-4 col-xs-3"><?php echo $v['status']?></div>
								<div class="product_content_cont col-sm-4 col-xs-6"></div>
							</div>
						  <?php } ?>
							<div class="product_more col-sm-12 col-xs-12">
								<div class="more_btn col-sm-offset-4 col-sm-4 col-xs-12">
								<button class="btn col-sm-12 col-xs-12 mor" onclick="more()"> More</button>
								<button class="btn col-sm-12 col-xs-12 hid" onclick="hid()" style="display: none;">Pack up</button>
							</div>
						</div>
					</div>
				</div>
				<div class="product row">
					<div class="order_all ">
						<p class="order upper">Order Details</p>
					</div>
					<div class="product_content_all col-sm-12 col-xs-12">
					  <?php foreach($result as $v){ 
					     if($v['shipping_method']==0){
							$v['shipping_method']='无邮费'; 
						 }elseif($v['shipping_method']==1){
							 $v['shipping_method']='指定国家';
						 }elseif($v['shipping_method']==2){
							 $v['shipping_method']='全球';
						 }
					  ?>
						<div class="product_content">
							<div class="product_content_cont col-sm-4 col-xs-6 left">
								Order ID: #<?php echo $v['order_id'] ?><br>
								Date Added:<?php echo $v['date_added'] ?>
							</div>
							<div class="product_content_cont col-sm-8 col-xs-6 left">
								Payment Method:<?php echo $v['ename'] ?><br>
								Shipping Method: <?php echo $v['shipping_method'] ?> 
							</div>
						</div>
					  <?php } ?>
					</div>
				</div>
				<div class="product row">
					<div class="order_all ">
						<p class="order col-sm-8 col-xs-6 have-padding upper">Shipping Address </p>
					</div>
					<div class="product_content_all col-sm-12 col-xs-12">
						<div class="product_content">
							<div class="product_content_cont col-sm-8 col-xs-6 left" style="padding-left:10px">
						      <?php echo $shipping_address ?>
       						</div>
						</div>
					</div>
				</div>
				<div class="product row">
					<div class="order_all ">
						<input id="input-express-num" type="hidden" disabled="true" value="sdfasasd">
						<p class="order col-sm-4 col-xs-8 iphon">EXPRESS NUM : sdfasasd</p>
						<button class="btn r" onclick="viewtrack()" id="btn-view-track" style="">VIEW TRACKING </button>
						<button class="btn r" onclick="hidetrack()" id="btn-hide-track" style="display: none;">Hide Tracking </button>
					</div>
					<div class="product_content_all col-sm-12 col-xs-12" style="min-height:0px;">
						<div class="product_content" id="input-express-info" style="display: none;">
							<!-- <iframe src="//www.17track.net/en/externalcall?resultDetailsH=156&amp;nums=sdfasasd&amp;fc=0" width="100%" id="trackIframe" height="225" frameborder="0" fid="iframe-2"></iframe> -->
						</div>
					</div>
				</div>
				<div class="product row">
					<div class="order_all ">
						<p class="order col-sm-4 upper">Order Details</p>
					</div>
					<div class="product_content_all col-sm-12 col-xs-12" style="padding:0;">
					  <?php foreach($result as $v){ ?>
						<div class="table-responsive cart-info cart-overlay col-xs-12">
							<!-- <div class="showloader overlay"></div> -->
							<table class="table table-bordered" style="border:0">
								<thead>
									<tr>
										<td class="text-center" style="font-weight:bold;"><?php echo date('Y-m-d',strtotime($v['date_added'])) ?></td>
										<td class=" hidden-xs" style="text-align:left;">#<?php echo $v['order_id'] ?></td>
										<td class="text-center hidden-xs"></td>
										<td class="text-right hidden-xs"></td>
										<td class="text-right hidden-xs"><?php echo $v['ename'] ?></td>
										<!-- <td class="text-right"></td> -->
									</tr>
								</thead>
								<tbody class="tbody">
									<tr>
										<td class="text-center" style="width:15%;padding-left: 15px;">
											<a href=""><img src="<?php echo HTTP_Aliyoyo.'image/'.$v['image'] ?>" alt="" title="" class="img-thumbnail"></a>
										</td>
										<td class="text-center hidden-xs" style="width: 30%;text-align: left;">
											<a href=""><?php echo $v['crowdfunding_name'] ?></a>
										</td>
										<td class="text-right hidden-xs"></td>
										<td class="text-right hidden-xs" id="product_price_1287"><?php echo $v['name'] ?></td>
										<td class="text-right hidden-xs">Sub-Total: $<?php echo floatval($v['total']) ?></td>
										<!-- <td class="text-right">
											<button class="btn">Review</button>
											<button class="btn">Refund</button>
										</td> -->
									</tr>
								</tbody>
							</table>
							<p class="total-p">Free Shipping:&nbsp;&nbsp;<span>$<?php  echo floatval($v['shipping_price']) ?></span></p>
							<p class="total-p">Coupon:&nbsp;&nbsp;<span>$ -<?php echo floatval($v['balance']) ?></span></p>
							<p class="total-p">Total:&nbsp;&nbsp;<span>$<?php echo floatval($v['total'])-floatval($v['balance'])+floatval($v['shipping_price']) ?></span></p>
						</div>
					  <?php } ?>	
					</div>
				</div>
				</div>
			</div>
		</div>
	</div>
</div>


	<script src="js/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/swiper-3.3.1.min.js"></script>
	<script>
		// function hidetrack(){
		// 	$("#btn-hide-track").hide();
		// 	$("#btn-view-track").show();
		//     $("#tbody-express-info").hide();
		//     $("#input-express-info").empty();
		// }
		function more(){
			$(".mored").show();
		  	$(".mor").hide();
		 	$(".hid").show();
		}
		function hid(){
		   $(".mored").hide();
		   $(".mor").show();
		   $(".hid").hide();
		}
	</script>
<?php echo $footer; ?>
