<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
   <div class="page-header">
      <div class="container-fluid">
         <div class="pull-right">
            <a href="<?php echo $add; ?>" data-toggle="tooltip" title="<?php echo $button_add; ?>" class="btn btn-primary"><i class="fa fa-plus"></i></a>
            <button type="button" data-toggle="tooltip" title="<?php echo $button_delete; ?>" class="btn btn-danger" onclick="confirm('<?php echo $text_confirm; ?>') ? $('#form-livehelp-ban').submit() : false;"><i class="fa fa-trash-o"></i></button>
         </div>
         <h1><?php echo $heading_title; ?></h1>
         <ul class="breadcrumb">
            <?php foreach ($breadcrumbs as $breadcrumb) { ?>
            <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
            <?php } ?>
         </ul>
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
            <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form-livehelp-ban">
               <div class="table-responsive">
                  <table class="table table-bordered table-hover">
                     <thead>
                        <tr>
                           <td width="1" class="text-center">
                              <input type="checkbox" onclick="$('input[name*=\'selected\']').prop('checked', this.checked);" />
                           </td>
                           <td class="left">
                              <?php if ($sort == 'user_name') { ?>
                              <a href="<?php echo $sort_user_name; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_user_name; ?></a>
                              <?php } else { ?>
                              <a href="<?php echo $sort_user_name; ?>"><?php echo $column_user_name; ?></a>
                              <?php } ?>
                           </td>
                           <td class="left">
                              <?php if ($sort == 'date_added') { ?>
                              <a href="<?php echo $sort_date_added; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_date_added; ?></a>
                              <?php } else { ?>
                              <a href="<?php echo $sort_date_added; ?>"><?php echo $column_date_added; ?></a>
                              <?php } ?>
                           </td>
                           <td class="left">
                              <?php if ($sort == 'date_expired') { ?>
                              <a href="<?php echo $sort_date_expired; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_date_expired; ?></a>
                              <?php } else { ?>
                              <a href="<?php echo $sort_date_expired; ?>"><?php echo $column_date_expired; ?></a>
                              <?php } ?>
                           </td>
                           <td class="left">
                              <?php if ($sort == 'ip') { ?>
                              <a href="<?php echo $sort_ip; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_ip; ?></a>
                              <?php } else { ?>
                              <a href="<?php echo $sort_ip; ?>"><?php echo $column_ip; ?></a>
                              <?php } ?>
                           </td>
                           <td class="right"><?php echo $column_action; ?></td>
                        </tr>
                     </thead>
                     <tbody>
                        <tr class="filter">
                           <td></td>
                           <td></td>
                           <td>
                             <div class="input-group date">
                               <input type="text" name="filter_date_added" value="<?php echo $filter_date_added; ?>" data-date-format="YYYY-MM-DD" id="input-date-added" class="form-control" />
                               <span class="input-group-btn">
                               <button id="input_date_available" type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                               </span>
                             </div>
                           </td>
                           <td>
                             <div class="input-group date">
                               <input type="text" name="filter_date_expired" value="<?php echo $filter_date_expired; ?>" data-date-format="YYYY-MM-DD" id="input-date-added" class="form-control" />
                               <span class="input-group-btn">
                               <button id="input_date_available" type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                               </span>
                             </div>
                           </td>
                           <td></td>
                           <td align="text-right"><a id="button-filter" class="btn btn-primary"><?php echo $button_filter; ?></a></td>
                        </tr>
                        <?php if ($banned_users) { ?>
                        <?php foreach ($banned_users as $banned_user) { ?>
                        <tr>
                           <td class="text-center"><?php if ($banned_user['selected']) { ?>
                              <input type="checkbox" name="selected[]" value="<?php echo $banned_user['ban_id']; ?>" checked="checked" />
                              <?php } else { ?>
                              <input type="checkbox" name="selected[]" value="<?php echo $banned_user['ban_id']; ?>" />
                              <?php } ?>
                           </td>
                           <td class="text-left"><?php echo $banned_user['user_name']; ?></td>
                           <td class="text-left"><?php echo $banned_user['date_added']; ?></td>
                           <td class="text-left"><?php echo $banned_user['date_expired']; ?></td>
                           <td class="text-left"><?php echo $banned_user['ip']; ?></td>
                           <td class="text-right"><?php foreach ($banned_user['action'] as $action) { ?>
                              [ <a href="<?php echo $action['href']; ?>"><?php echo $action['text']; ?></a> ]
                              <?php } ?>
                           </td>
                        </tr>
                        <?php } ?>
                        <?php } else { ?>
                        <tr>
                           <td class="text-center" colspan="6"><?php echo $text_no_results; ?></td>
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
</div>
<script type="text/javascript"><!--
$('#button-filter').on('click', function() {
  url = 'index.php?route=livehelp/livehelp_ban&token=<?php echo $token; ?>';

  var filter_date_added = $('input[name=\'filter_date_added\']').val();

  if (filter_date_added) {
    url += '&filter_date_added=' + encodeURIComponent(filter_date_added);
  }

  var filter_date_expired = $('input[name=\'filter_date_expired\']').val();

  if (filter_date_expired) {
    url += '&filter_date_expired=' + encodeURIComponent(filter_date_expired);
  }

  location = url;
});
//--></script> 
<script src="view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.js" type="text/javascript"></script>
<link href="view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet" media="screen" />
<script type="text/javascript"><!--
$('.date').datetimepicker({
   pickTime: false
});
//-->
</script>
<?php echo $footer; ?>