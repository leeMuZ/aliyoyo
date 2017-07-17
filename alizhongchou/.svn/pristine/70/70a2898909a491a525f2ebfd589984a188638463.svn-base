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
               <!-- INPUT NAME -->                                                        
               <div class="form-group<?php echo (!empty($error_name) ? " has-error" : ""); ?>">
                  <label class="col-sm-4 control-label required">   
                  <?php echo $entry_text; ?>                                             
                  </label>                                                       
                  <div class="col-sm-4">
                     <?php foreach ($languages as $language) { ?>                                     
                     <div class="input-group">
                        <div class="input-group-addon">
                           <img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" alt="<?php echo $language['name']; ?>" />                                      
                        </div>
                        <input type="text" name="status_text[<?php echo $language['language_id']; ?>][name]" class="form-control" value="<?php echo isset($status_text[$language['language_id']]) ? $status_text[$language['language_id']]['name'] : ''; ?>" />
                     </div>
                     <?php if (isset($error_name[$language['language_id']])) { ?>
                     <span class="help-block">                                     
                     <?php echo $error_name[$language['language_id']]; ?>
                     </span>                                                
                     <?php } ?>    
                     <?php } ?>  
                  </div>
               </div>
               <!-- INPUT TEXT -->                                                        
               <div class="form-group<?php echo (!empty($error_text) ? " has-error" : ""); ?>">
                  <label class="col-sm-4 control-label required">   
                  <?php echo $entry_text; ?>                                             
                  </label>                                                       
                  <div class="col-sm-4">
                     <?php foreach ($languages as $language) { ?>                                     
                     <div class="input-group">
                        <div class="input-group-addon">                                         
                           <img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" alt="<?php echo $language['name']; ?>" />                                      
                        </div>
                        <textarea name="status_text[<?php echo $language['language_id']; ?>][text]" id="" class="form-control" rows="3"><?php echo isset($status_text[$language['language_id']]) ? $status_text[$language['language_id']]['text'] : ''; ?></textarea>
                     </div>
                     <?php if (isset($error_text[$language['language_id']])) { ?>
                     <span class="help-block">                                     
                     <?php echo $error_text[$language['language_id']]; ?>
                     </span>                                                
                     <?php } ?>    
                     <?php } ?>  
                  </div>
               </div>
               <!-- INPUT COLOR -->                            
               <div class="form-group">
                  <label for="input_color" class="col-sm-4 control-label">    
                  <span class="has-tooltip" data-toggle="tooltip" title="<?php echo $title_color; ?>">
                  <?php echo $entry_color; ?> </span>
                  </label>                         
                  <div class="col-sm-4">                          
                     <input id="input_color" type="text" value="#<?php echo $color; ?>" class="form-control colorpicker" readonly />                                      
                     <input type="hidden" name="color" value="<?php echo $color; ?>">
                  </div>
               </div>
            </form>
         </div>
      </div>
   </div>
</div>
<script type="text/javascript">
   $(function(){
       $('.colorpicker').minicolors({
         theme: 'bootstrap',
         change: function(hex, opacity) {
           $('input[name="color"]').val(hex.replace("#", ""));
         }
       });
   });
</script>
<?php echo $footer; ?>