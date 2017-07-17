<?php echo $header; ?>
<head>
<link href="catalog/view/stylesheet/age.css" rel="stylesheet">
<link href="catalog/view/stylesheet/payment.css" rel="stylesheet">
</head>
<body>

 <div class="standard-body">
		<div class="full-width">
			<div class="container">
				<div class="col-md-12 center-column payment-page" id="content">
					<form  method="post" enctype="multipart/form-data" id="editCartForm">
						<div class="table-responsive cart-info cart-overlay col-xs-12">
							<div class="showloader overlay"></div>
							<table class="table table-bordered" style="border:0">
								<thead>
									<tr>
										<td class="text-center">Image</td>
										<td class="text-center hidden-xs">PROJECT NAME</td>
										<td class="text-center hidden-xs">Model</td>
										<td class="text-right hidden-xs">Price</td>
										<td class="text-center">POSTAGE</td>
										<td class="text-right">Total</td>
									</tr>
								</thead>
								<tbody class="tbody">
									<tr>
										<td class="text-center">
											<a href=""><img src="catalog/view/img/vdio.jpg" alt="" title="" class="img-thumbnail"></a>
										</td>
										<td class="text-center hidden-xs" style="width: 25%;text-align: left;">
											<a href="">Foldio360 – A smart turntable to create stunning 360 images</a>
										</td>
										<td class="text-center hidden-xs">Early bird</td>
										<td class="text-right hidden-xs" id="product_price_1287">$67.99</td>
										<td class="text-right hidden-xs">$67.99</td>
										<td class="text-right">
											<strong id="product_total_1287">$67.99</strong>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</form>
					<h2>What would you like to do next?</h2>
					<p style="padding-bottom: 10px">
						If you have a coupon, please fill in the coupon code.
					</p>
					<div class="panel-group" id="accordion">
						<div id="collapse-coupon" class="panel-collapse collapse in" style="height: auto;">
							<div class="panel-body" style="padding-top:0px;">
								<label class="control-label" for="input-coupon" style="padding-top: 10px;padding-left: 0px;padding-right:20px;font-size: 16px;">Enter your coupon here:</label>
								<div class="input-group col-sm-8">
									<input type="text" name="coupon" value="" id="input-coupon" class="form-control col-sm-8">
									<span class="input-group-btn col-sm-4">
										<input type="button" value="Apply Coupon" id="button-coupon" data-loading-text="Loading..." class="btn btn-primary">
									</span>
								</div>
							</div>
						</div>
						<div class="panel-collapse collapse in" id="collapse-payment-address" style="height: auto;">
							<div class="panel-body">
								<form class="form-horizontal">
									<p style="margin:0;"><span style="color:#eb0909;">*</span>&nbsp;&nbsp;Please fill in your address</p>
									<!--tian xieguo dizhide yangshi -->
									<div class="hidegroup">
										<div class="radio" style="padding-top:10px;padding-bottom:10px;">
											<label>
												<input type="radio" name="payment_address" value="existing" checked="checked">
												I want to use an existing address
											</label>
										</div>
										<div id="payment-existing">
											<div class="select_box form-control" id="input-payment-country">
								                <span class="select_txt"></span>
								                <a class="selet_open">
								                	<i class="fa fa-angle-down"></i>
								                </a>
								                <div class="option">
								                    <a>Please Select</a>
								                    <a>2</a>
								                    <a>3</a>
								                </div>
								            </div>
										</div>
										<div class="radio" style="padding-top:10px;">
											<label>
												<input type="radio" name="payment_address" value="new" data-toggle="modal" data-target="#myModal">
												I want to use a new address
											</label>
										</div>
									</div>
									<!-- Modal -->
									<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
										 <div class="modal-dialog" role="document">
										    <div class="modal-content">
											    <div class="modal-header">
											        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
											        <h4 class="modal-title" id="myModalLabel">Add a new address</h4>
											    </div>
											    <div class="modal-body">
											        <div id="payment-new" style="display:block;">
														<div class="form-group required">
															<label class="col-sm-3 control-label" for="input-payment-firstname">First Name</label>
															<div class="col-sm-9">
																<input type="text" name="firstname" value="" placeholder="First Name" id="input-payment-firstname" class="form-control">
															</div>
														</div>
														<div class="form-group required">
															<label class="col-sm-3 control-label" for="input-payment-lastname">Last Name</label>
															<div class="col-sm-9">
																<input type="text" name="lastname" value="" placeholder="Last Name" id="input-payment-lastname" class="form-control">
															</div>
														</div>
														<div class="form-group required">
															<label class="col-sm-3 control-label" for="input-payment-telephone">Telephone</label>
															<div class="col-sm-9">
																<input type="text" name="telephone" value="" placeholder="Telephone" id="input-payment-telephone" class="form-control">
															</div>
														</div>
														<div class="form-group">
															<label class="col-sm-3 control-label" for="input-payment-company">Company</label>
															<div class="col-sm-9">
																<input type="text" name="company" value="" placeholder="Company" id="input-payment-company" class="form-control">
															</div>
														</div>
														<div class="form-group required">
															<label class="col-sm-3 control-label" for="input-payment-address-1">Street</label>
															<div class="col-sm-9">
																<input type="text" name="address_1" value="" placeholder="Street" id="input-payment-address-1" class="form-control">
															</div>
														</div>
														<div class="form-group">
															<label class="col-sm-3 control-label" for="input-payment-address-2"></label>
															<div class="col-sm-9">
																<input type="text" name="address_2" value="" placeholder="" id="input-payment-address-2" class="form-control">
															</div>
														</div>
														<div class="form-group required">
															<label class="col-sm-3 control-label" for="input-payment-city">City</label>
															<div class="col-sm-9">
																<input type="text" name="city" value="" placeholder="City" id="input-payment-city" class="form-control">
															</div>
														</div>
														<div class="form-group">
															<label class="col-sm-3 control-label" for="input-payment-postcode">Post Code</label>
															<div class="col-sm-9">
																<input type="text" name="postcode" value="" placeholder="Post Code" id="input-payment-postcode" class="form-control">
															</div>
														</div>
														<div class="form-group required">
															<label class="col-sm-3 control-label" for="input-payment-country">Country</label>
															<div class="col-sm-9 seading" >
																<div class="select_box form-control" id="input-payment-country">
													                <span class="select_txt"></span>
													                <a class="selet_open">
													                	<i class="fa fa-angle-down"></i>
													                </a>
													                <div class="option">
													                    <a>Please Select</a>
													                    <a>2</a>
													                    <a>3</a>
													                </div>
													            </div>
															</div>
														</div>
														<div class="form-group required">
															<label class="col-sm-3 control-label" for="input-payment-zone">Region / State</label>
															<div class="col-sm-9 seading">
																<div class="select_box form-control" id="input-payment-country">
													                <span class="select_txt"></span>
													                <a class="selet_open">
													                	<i class="fa fa-angle-down"></i>
													                </a>
													                <div class="option">
													                    <a>Please Select</a>
													                    <a>2</a>
													                    <a>3</a>
													                </div>
													            </div>
															</div>
														</div>
													</div>
											    </div>
											    <div class="modal-footer">
											        <!-- <button type="button" class="btn btn-default" data-dismiss="modal">Close</button> -->
											        <button type="button" class="btn btn-primary">SAVE</button>
											    </div>
										    </div>
										 </div>
									</div>
								</form>
							</div>
						</div>
						<div class="panel-collapse " id="collapse-payment-method">
							<div class="panel-body tenmargin">
								<p><span style="color:#eb0909;">*</span>&nbsp;&nbsp;Please choose a payment method</p>
								<div class="radio">
									<label>
										<input type="radio" name="payment_method" value="pp_standard" checked="checked">
										PayPal 

									</label>
								</div>
								<div class="radio">
									<label>
										<input type="radio" name="payment_method" value="pp_express">
										PayPal Express Checkout 
									</label>
								</div>
								<div class="radio">
									<label>
										<input type="radio" name="payment_method" value="creditcard">
										Credit Card Payment <br>
										<img src="catalog/view/img/visa_mast.jpg" alt="Credit Card" data-pin-nopin="true"> 
									</label>
								</div>
								
							</div>
						</div>
					</div>
					<div class="cart-total">
						<table>
							<tbody>
								<tr>
									<td class="text-right Sub-Total">Sub-Total:</td>
									<td class="text-right Sub-Total">$84.74</td>
								</tr>
								<tr>
									<td class="text-right Total">Total:</td>
									<td class="text-right Total">$84.74</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="buttons">
						<!-- <div class="pull-left btn">
							<a href="">Continue Shopping</a>
						</div> -->
					 	<div class="right" style="float:right">
					 		<a class="button" style="border:0;background-color:#fff;" href="">
					 			<img src="catalog/view/img/btn_xpressCheckout.gif" align="left" style="margin-right:7px;">
					 		</a>
							-- OR -- 
							<a href="" class="button proceed">Proceed to Checkout</a>
						</div>
					</div>
				</div>
			</div>
		</div>
<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/swiper-3.3.1.min.js"></script>
<script>
// **********************modal那个select*****************************
	    $(document).ready(function(){
            $(".select_box").click(function(event){   
                event.stopPropagation();
                $(this).find(".option").toggle();
                $(this).parent().siblings().find(".option").hide();
            });
            $(document).click(function(event){
                var eo=$(event.target);
                if($(".select_box").is(":visible") && eo.attr("class")!="option" && !eo.parent(".option").length)
                $('.option').hide();                                      
            });
            /*赋值给文本框*/
            $(".option a").click(function(){
                var value=$(this).text();
                $(this).parent().siblings(".select_txt").text(value);
                $("#select_value").val(value)
             })
        })
</script>
</body>
<?php echo $footer; ?>