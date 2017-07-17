<?php echo $header;?>
<?php if ($testmode) { ?>
  <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $text_testmode; ?></div>
<?php } ?>
<div class="pament_true_all">	
   <div class="container">
		<div class="col-md-12 center-column pament_true" id="content">
			<div class="pament_true_top">
			<?php if(isset($rewards)){?>
				<p><span> Project name：</span><span><?php echo $rewards['crowdfunding_name']; ?></span></p>
				<p><span> Model：</span><span><?php echo $rewards['name']; ?></span></p>
				<p><span> Price：</span><span>$<?php echo $rewards['pledge_amount']; ?></span></p>
				<p><span> Postage:</span>$<?php echo $shipping_price; ?></p>
			<?php }else{?>
			    <p><span> Project name：</span><span><?php echo $funding['name']; ?></span></p>
				<p><span> Price：</span><span>$<?php echo $total; ?></span></p>
			<?php }?>
			</div>
			<div class="pament_true_bottom">
				<p><span> Coupon code :</span><span><?php echo isset($coupon['code'])?$coupon['code']:''; ?></span></p>
				<p><span> Existing address : </span><span><?php echo $first_name.' '.$last_name.','.$address1.' '.$address2.','.$city.','.$zip.','.$country; ?></span></p>
				<p><span> Payment method :</span><span>Paypal</span></p>
			</div>
			<div class="cart-total">
				<table>
					<tbody>
						<tr>
							<td class="text-right Sub-Total">Sub-Total:</td>
							<td class="text-right Sub-Total">$<?php echo $total?></td>
						</tr>
						<tr>
							<td class="text-right Total">Total:</td>
							<td class="text-right Total">$<?php echo $amount?></td>
						</tr>
						<tr>
							<td class="text-right Total">Shipping:</td>
							<td class="text-right Total">$<?php echo $shipping_price?></td>
						</tr>
						<?php if($coupon){?>
						<tr>
							<td class="text-right Total">Coupon:</td>
							<td class="text-right Total">-$<?php echo floatval($coupon['discount'])?></td>
						</tr>
						<?php }?>
					</tbody>
				</table>
			</div>
			<form action="<?php echo $action; ?>" method="post">
  <input type="hidden" name="cmd" value="_cart" />
  <input type="hidden" name="upload" value="1" />
  <input type="hidden" name="business" value="<?php echo $business; ?>" />
  <?php if(isset($rewards)){?>
  <input type="hidden" name="item_name_1" value="<?php echo $rewards['crowdfunding_name']; ?>" />
  <input type="hidden" name="item_number_1" value="<?php echo $rewards['name']; ?>" />
  <?php }else{?>
   <input type="hidden" name="item_name_1" value="<?php echo  $funding['name']; ?>" />
  <input type="hidden" name="item_number_1" value="no rewards" />
  <?php }?>
  <input type="hidden" name="amount_1" value="<?php echo $total?>" />
  <input type="hidden" name="quantity_1" value="1" />
  <?php if ($coupon) { ?>
    <input type="hidden" name="discount_amount_cart" value="<?php echo $coupon['discount']; ?>" />
  <?php } ?>
  <input type="hidden" name="currency_code" value="<?php echo $currency_code; ?>" />
  <input type="hidden" name="first_name" value="<?php echo $first_name; ?>" />
  <input type="hidden" name="last_name" value="<?php echo $last_name; ?>" />
  <input type="hidden" name="address1" value="<?php echo $address1; ?>" />
  <input type="hidden" name="address2" value="<?php echo $address2; ?>" />
  <input type="hidden" name="city" value="<?php echo $city; ?>" />
  <input type="hidden" name="zip" value="<?php echo $zip; ?>" />
  <input type="hidden" name="country" value="<?php echo $country; ?>" />
  <input type="hidden" name="address_override" value="0" />
  <input type="hidden" name="email" value="<?php echo $email; ?>" />
  <input type="hidden" name="lc" value="<?php echo $lc; ?>" />
  <input type="hidden" name="rm" value="2" />
  <input type="hidden" name="no_note" value="1" />
  <input type="hidden" name="no_shipping" value="1" />
  <input type="hidden" name="charset" value="utf-8" />
  <input type="hidden" name="return" value="<?php echo $return; ?>" />   
  <input type="hidden" name="notify_url" value="<?php echo $notify_url; ?>" />
  <input type="hidden" name="cancel_return" value="<?php echo $cancel_return; ?>" />
  <input type="hidden" name="paymentaction" value="<?php echo $paymentaction; ?>" />
  <input type="hidden" name="custom" value="<?php echo $custom; ?>" />
  <input type="hidden" name="bn" value="OpenCart_2.0_WPS" />
  <div class="buttons">
				<!-- <div class="pull-left btn">
					<a href="">Continue Shopping</a>
				</div> -->
			 	<div class="right">
			 		<span class="button" style="border:0;background-color:#fff;" href="">
			 			<a href='<?php echo $cancel_return;?>'>Return to change</a>
			 		</span>
					
					<input type='submit' class="button proceed" value='Confirm Order'>
				</div>
			</div>
</form>
			
		</div>
	</div>
</div>			
<?php echo $footer;?>
