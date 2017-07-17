<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
<div class="container-fluid">
	<div class="page-header">
	    <h1>Blog Category</h1>
	    <ul class="breadcrumb">
		     <?php foreach ($breadcrumbs as $breadcrumb) { ?>
		      <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
		      <?php } ?>
	    </ul>
	  </div>
	  
	<link href='http://fonts.googleapis.com/css?family=Open+Sans:600,500,400' rel='stylesheet' type='text/css'>
	
	

	<?php if ($error_warning) { ?>
		<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
		  <button type="button" class="close" data-dismiss="alert">&times;</button>
		</div>
	<?php } elseif ($success) {  ?>
		<div class="alert alert-success"><i class="fa fa-exclamation-circle"></i> <?php echo $success; ?>
			<button type="button" class="close" data-dismiss="alert">&times;</button>
		</div>
	<?php } ?>
	
	<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
		<div class="set-size">
			<div class="content">
				<table width="100%">
					<tr>
						<td width="15%">Product:</td>
						<td width="85%">
							<select name="product">
								<option value="date_added">new</option>
								<option value="fancy">hot</option>
								<option value="sort_order">sort_order</option>
							</select>
						</td>
					</tr>
					<?php if(isset($discovery['discovery']['product']) && $discovery['discovery']['product'] !=""){?>
					<script>
					var product_option='<?php echo $discovery['discovery']['product']?>';
					$("[name='product']").val(product_option);
					</script>
					<?php }?>
					<tr>
						<td width="15%">Blog:</td>
						<td width="85%">
							<select name="blog">
								<option value="date_added">new</option>
								<option value="fancy">hot</option>
							</select>
						</td>
					</tr>
					<?php if(isset($discovery['discovery']['blog']) && $discovery['discovery']['blog'] !=""){?>
					<script>
					var blog_option='<?php echo $discovery['discovery']['blog']?>';
					$("[name='blog']").val(blog_option);
					</script>
					<?php }?>
					<tr>
						<td width="15%">List:</td>
						<td width="85%">
							<select name="list">
								<option value="date_added">new</option>
								<option value="follow_count">follow_count</option>
								<option value="product_count">product_count</option>
							</select>
						</td>
					</tr>
					<?php if(isset($discovery['discovery']['list']) && $discovery['discovery']['list'] !=""){?>
					<script>
					var list_option='<?php echo $discovery['discovery']['list']?>';
					$("[name='list']").val(list_option);
					</script>
					<?php }?>
					<tr>
						<td width="15%">Review:</td>
						<td width="85%">
							<select name="review">
								<option value="time">new</option>
							</select>
						</td>
					</tr>
					<?php if(isset($discovery['discovery']['review']) && $discovery['discovery']['review'] !=""){?>
					<script>
					var review_option='<?php echo $discovery['discovery']['review']?>';
					$("[name='review']").val(review_option);
					</script>
					<?php }?>
					<tr>
						<td width="15%">Evaluation:</td>
						<td width="85%">
							<select name="evaluation">
								<option value="time">new</option>
							</select>
						</td>
					</tr>
					<?php if(isset($discovery['discovery']['evaluation']) && $discovery['discovery']['evaluation'] !=""){?>
					<script>
					var evaluation_option='<?php echo $discovery['discovery']['evaluation']?>';
					$("[name='evaluation']").val(evaluation_option);
					</script>
					<?php }?>
					<tr>
						<td colspan="2"><input value="save" type="submit"/></td>
					</tr>
				</table>
			</div>
		</div>
	</form>
</div>
</div>
<?php echo $footer; ?>