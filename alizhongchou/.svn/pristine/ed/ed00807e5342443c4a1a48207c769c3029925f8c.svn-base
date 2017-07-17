<?php echo $header; ?>
	<div class="standard-body" style="margin-top:20px">
		<div class="full-width">
			<div class="partten">
				<div class="container">
					<!-- backers -->
					<div class="backers clearfix col=sm-12">
						<div class="clearfix col-sm-12 backers-top">
							<span>Explore categories</span>
							<select name="" id="charge-sid" class="backer-select">
							   <?php foreach($name as $v) {?>
								<option value="<?php echo $v['rewards_id'] ?>"><?php echo $v['name'] ?></option>
							   <?php } ?>
							</select>
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

									</div>
								</tbody>
							</table>
						</div>
						<div class="pagination-results col-lg-12 col-sm-12 col-xs-12" style="text-align:center">
                       <?php echo $pagination; ?>
                      </div>
					</div>
				</div>
			</div>
		</div>
	</div>

<script>
    	  $('#charge-sid').change(function(){
                var sid = $(this).val();
				var href = "<?php echo $href ?>";

                	$.ajax({
						type: 'get',
						url: 'index.php?route=account/backersperson/getinfo',
						data: 'sid='+sid+"&href="+href,
						dataType: 'json',
						success: function(res) {
						  //alert(res.success);
						   $('.backerstable-tbody').html(res.success);
						   //$('#myModal').modal('show')
						}
						});
			});

		
	$('.faeye').each(function(index, el) {
		$(this).click(function () {
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
	
	function fun(href,id){
					$.ajax({
						type: 'get',
						url: 'index.php?route=account/datepage/info',
						data: 'oid='+id+"&rel="+href,
						dataType: 'json',
						success: function(res) {
						  //alert(res.success);
						   $('#myModal').html(res.success);
						   $('#myModal').modal('show')
						}
						});
	}
	


</script>
 
<?php echo $footer; ?>
