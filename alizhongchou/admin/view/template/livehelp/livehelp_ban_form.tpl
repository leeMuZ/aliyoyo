<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
   <div class="page-header">
      <div class="container-fluid">
         <div class="pull-right">
            <button type="submit" form="form" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
            <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a>
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
      <div class="panel panel-default">
         <div class="panel-heading">
            <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_form; ?></h3>
         </div>
         <div class="panel-body">
            <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" class="form-horizontal group-border-dashed" id="form" role="form">
               <!-- INPUT USER_NAME -->
                  <div class="form-group required">
                     <label class="col-sm-4 control-label">
                     <?php echo $entry_user_name; ?>
                     </label>
                     <div class="col-sm-6">
                        <input type="text" name="user_name" value="<?php echo $user_name; ?>" class="form-control">
                        <?php if($error_user_name) { ?>
                        <span class="help-block">
                        <?php echo $error_user_name; ?>
                        </span>
                        <?php } ?>
                     </div>
                  </div>
                  <!-- INPUT COMMENT -->
                  <div class="form-group">
                     <label class="col-sm-4 control-label">
                     <?php echo $entry_comment; ?>
                     </label>
                     <div class="col-sm-6">
                        <textarea name="comment" rows="2" class="form-control"><?php echo $comment; ?></textarea>
                     </div>
                  </div>
                  <!-- INPUT DATE_EXPIRED -->
                  <div class="form-group">
                     <label class="col-sm-4 control-label">
                     <span class="has-tooltip" title="<?php echo $title_expired; ?>" data-toggle="tooltip">
                     <?php echo $entry_expired; ?> 
                     </span>
                     </label>
                     <div class="col-sm-6">
                        <div class="input-group datetime">
                           <input type="text" name="date_expired" value="<?php echo $date_expired; ?>" data-date-format="YYYY-MM-DD HH:mm:ss" id="input-date-added" class="form-control" />
                           <span class="input-group-btn">
                           <button id="input_date_available" type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                           </span>
                        </div>
                     </div>
                  </div>
                  <!-- INPUT IP -->
                  <div class="form-group required">
                     <label class="col-sm-4 control-label">
                     <?php echo $entry_ip; ?>
                     </label>
                     <div class="col-sm-6">
                        <input type="text" name="ip" value="<?php echo $ip; ?>" class="form-control">
                        <?php if($error_ip) { ?>
                        <span class="help-block">
                        <?php echo $error_ip; ?>
                        </span>
                        <?php } ?>
                     </div>
                  </div>
            </form>
         </div>
      </div>
   </div>
</div>
<script src="view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.js" type="text/javascript"></script>
<link href="view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet" media="screen" />
<script type="text/javascript"><!--
$('.datetime').datetimepicker({
   pickTime: true
});
//-->
</script>
<?php echo $footer; ?>