<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="button" data-toggle="tooltip" title="<?php echo $button_delete; ?>" class="btn btn-danger" onclick="confirm('Are you sure?') ? $('#form-review').submit() : false;"><i class="fa fa-trash-o"></i></button>
      </div>
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>
          <div class="well">
          <div class="row">

            <div class="col-sm-4">
              <div class="form-group">
                <label class="control-label" for="input-order-status"><?php echo $entry_order_status; ?></label>
                <select name="filter_status" id="input-order-status" class="form-control">
                  <option value="*"></option>
                  <option value="5" <?php echo isset($filter_status) && $filter_status==5 ? 'selected' : '' ?> >待审核</option>
                  <option value="10" <?php echo isset($filter_status) && $filter_status==10 ? 'selected' : '' ?>>审核成功</option>
                  <option value="12" <?php echo isset($filter_status) && $filter_status==12 ? 'selected' : '' ?> >审核失败</option>
                  <option value="15" <?php echo isset($filter_status) && $filter_status==15 ? 'selected' : '' ?>>发布</option>
                </select>
              </div>
              <div class="form-group">
                  <button type="button" id="button-filter" class="btn btn-primary pull-right"><i class="fa fa-search"></i> Filter</button>

              </div>
            </div>

          </div>
        </div>
  <div class="container-fluid">
    <?php if ($error_warning) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <?php if ($success) { ?>
    <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-list"></i> <?php echo $text_list; ?></h3>
      </div>
      <div class="panel-body">

        <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form-review">
          <div class="table-responsive">
            <table class="table table-bordered table-hover">
              <thead>
                <tr>
                  <td style="width: 1px;" class="text-center"><input type="checkbox" onclick="$('input[name*=\'selected\']').prop('checked', this.checked);" /></td>
                  <td class="text-left">Image</td>
                  <td class="text-left">Project name</td>
                  <td class="text-right">Claaification</td>
                  <td class="text-left">Funder name</td>
                  <td class="text-left">funding goal</td>
                  <td class="text-right">Date</td>
				  <td class="text-right">Action</td>
                </tr>
              </thead>
              <tbody>
                <?php if ($result) { ?>
                <?php foreach ($result as $review) { ?>
                <tr>
                  <td class="text-center"><?php if (in_array($review['funding_id'], $selected)) { ?>
                    <input type="checkbox" name="selected[]" value="<?php echo $review['funding_id']; ?>" checked="checked" />
                    <?php } else { ?>
                    <input type="checkbox" name="selected[]" value="<?php echo $review['funding_id']; ?>" />
                    <?php } ?></td>
			       <?php if(!empty($review['image'])){ ?>
                      <td class="text-left"><img src="<?php echo HTTP_Aliyoyo.'image/'.$review['image'] ?>" alt="" style="width:100px;height:60px"></td>
                   <?php }else{ ?>
		              <td class="text-left"><img src="<?php echo HTTP_Aliyoyo.'image/cache/no_image-700x420.jpg' ?>" alt="" style="width:100px;height:60px"></td>
		          <?php } ?>
                  <td class="text-left"><?php echo $review['name']; ?></td>
                  <td class="text-right"><?php echo $review['fname']; ?></td>
                  <td class="text-left"><?php echo $review['firstname'].$review['lastname']; ?></td>
                  <td class="text-left"><?php echo '$'.floatval($review['total_goal']); ?></td>
				  <td class="text-left"><?php echo $review['date_added']; ?></td>
                  <td class="text-right"><a href="<?php echo $href.'&funding_id='.$review['funding_id'].'&email='.$review['email']; ?>" data-toggle="tooltip" title="<?php echo $button_edit; ?>" class="btn btn-primary"><i class="fa fa-pencil"></i></a></td>
                </tr>
                <?php } ?>
                <?php } else { ?>
                <tr>
                  <td class="text-center" colspan="7"><?php echo $text_no_results; ?></td>
                </tr>
                <?php } ?>
              </tbody>
            </table>
          </div>
        </form>
        <div class="row">
          <div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
          <div class="col-sm-6 text-right"><?php echo $results; ?></div>
        </div>
      </div>
    </div>
  </div>
  <script type="text/javascript"><!--
$('#button-filter').on('click', function() {
	url = 'index.php?route=catalog/reviews&token=<?php echo $token; ?>';
	
	var filter_product = $('input[name=\'filter_product\']').val();
	
	if (filter_product) {
		url += '&filter_product=' + encodeURIComponent(filter_product);
	}
	
	var filter_author = $('input[name=\'filter_author\']').val();
	
	if (filter_author) {
		url += '&filter_author=' + encodeURIComponent(filter_author);
	}
	
	var filter_status = $('select[name=\'filter_status\']').val();
	
	if (filter_status != '*') {
		url += '&filter_status=' + encodeURIComponent(filter_status); 
	}		
			
	var filter_date_added = $('input[name=\'filter_date_added\']').val();
	
	if (filter_date_added) {
		url += '&filter_date_added=' + encodeURIComponent(filter_date_added);
	}

	location = url;
});
//--></script> 
  <script type="text/javascript"><!--
$('.date').datetimepicker({
	pickTime: false
});
//--></script></div>
<?php echo $footer; ?>