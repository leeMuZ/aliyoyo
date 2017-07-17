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
               <div class="alert alert-info">
                  <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                  <i class="fa fa-exclamation-triangle text-warning"></i> &nbsp; 
                  <?php echo $text_operator_description; ?>
               </div>
               <!-- INPUT USER ID -->                                                        
               <div class="form-group<?php echo (!empty($error_user) ? " has-error" : ""); ?>">
                  <label for="input_user" class="col-sm-4 control-label required">
                  <?php echo $entry_user; ?>                                              
                  </label>                                                       
                  <div class="col-sm-6">
                     <select name="user_id" id="input_user" class="form-control">
                        <option value="0"><?php echo $text_select; ?></option>
                        <?php foreach ($users as $user) { ?>
                        <?php if($user['user_id'] == $user_id) { ?>
                        <option value="<?php echo $user['user_id']; ?>" selected="selected"><?php echo $user['username']; ?></option>
                        <?php } else { ?>
                        <option value="<?php echo $user['user_id']; ?>"><?php echo $user['username']; ?></option>
                        <?php } ?>
                        <?php } ?>
                     </select>
                     <?php if ($error_user) { ?>
                     <span class="help-block">
                     <?php echo $error_user; ?>
                     </span>
                     <?php } ?>                             
                  </div>
               </div>

               <!-- INPUT OPERATOR IMAGE -->
               <div class="form-group">
                  <label class="col-sm-4 control-label" for="input-image">
                     <span class="has-tooltip" data-toggle="tooltip" data-placement="top" title="<?php echo $title_image; ?>">
                     <?php echo $entry_image; ?>
                     </span>
                  </label>
                  <div class="col-sm-6"> 
                     <a href="" id="thumb-image" data-toggle="image" class="img-thumbnail"><img src="<?php echo $thumb; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a>
                     <input type="hidden" name="image" value="<?php echo $image; ?>" id="input-image" />
                  </div>
               </div>

               <!-- INPUT NAME -->
               <div class="form-group<?php echo ($error_name ? " has-error" : ""); ?>">
                  <label class="col-sm-4 control-label required">
                  <?php echo $entry_name; ?>
                  </label>
                  <div class="col-sm-6">
                     <input type="text" name="name" value="<?php echo $name; ?>" class="form-control">
                     <?php if ($error_name) { ?>
                     <span class="help-block">
                     <?php echo $error_name; ?>
                     </span>
                     <?php } ?> 
                  </div>
               </div>
               <!-- INPUT DESCRIPTION -->
               <div class="form-group">
                  <label class="col-sm-4 control-label">
                  <?php echo $entry_description; ?>
                  </label>
                  <div class="col-sm-6">
                     <textarea name="description" class="form-control" rows="2"><?php echo $description; ?></textarea>
                     <span class="help-block">
                        <?php echo $text_accepting_html; ?>
                     </span>
                  </div>
               </div>
               <!-- INPUT STATUS -->
               <div class="form-group">
                  <label class="col-sm-4 control-label">
                  <?php echo $entry_status; ?>
                  </label>
                  <div class="col-sm-4">
                     <div class="radio radio-inline">
                        <label>
                           <input type="radio" name="status" id="input" value="1"<?php echo ($status ? ' checked="checked"' : ''); ?>>
                           <?php echo $text_enabled; ?>
                        </label>
                     </div>
                     <div class="radio radio-inline">
                        <label>
                           <input type="radio" name="status" id="input" value="0"<?php echo (!$status ? ' checked="checked"' : ''); ?>>
                           <?php echo $text_disabled; ?>
                        </label>
                     </div>
                  </div>
               </div>
            </form>
         </div>
      </div>
   </div>
</div>
<?php echo $footer; ?>