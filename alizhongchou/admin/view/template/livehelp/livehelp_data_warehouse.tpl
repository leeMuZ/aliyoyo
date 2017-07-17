<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
   <div class="page-header">
      <div class="container-fluid">
         <div class="pull-right">
            <button type="button" data-toggle="tooltip" title="<?php echo $button_delete; ?>" class="btn btn-danger" onclick="confirm('<?php echo $text_confirm; ?>') ? $('#form-livehelp-warehouse').submit() : false;"><i class="fa fa-trash-o"></i></button>
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
            <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form-livehelp-warehouse">
               <div class="table-responsive">
                  <table class="table table-bordered table-hover">
                     <thead>
                        <tr>
                           <td width="1" class="text-center">
                              <input type="checkbox" onclick="$('input[name*=\'selected\']').prop('checked', this.checked);" />
                           </td>
                           <td class="text-left"><?php if ($sort == 'thread_id') { ?>
                              <a href="<?php echo $sort_thread_id; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_thread_id; ?></a>
                              <?php } else { ?>
                              <a href="<?php echo $sort_thread_id; ?>"><?php echo $column_thread_id; ?></a>
                              <?php } ?>
                           </td>
                           <td class="text-left"><?php if ($sort == 'customer_name') { ?>
                              <a href="<?php echo $sort_customer_name; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_customer_name; ?></a>
                              <?php } else { ?>
                              <a href="<?php echo $sort_customer_name; ?>"><?php echo $column_customer_name; ?></a>
                              <?php } ?>
                           </td>
                           <td class="text-left"><?php if ($sort == 'operator_name') { ?>
                              <a href="<?php echo $sort_operator_name; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_operator_name; ?></a>
                              <?php } else { ?>
                              <a href="<?php echo $sort_operator_name; ?>"><?php echo $column_operator_name; ?></a>
                              <?php } ?>
                           </td>
                           <td class="text-left"><?php echo $column_message; ?> 
                              <span class="btn-help" data-toggle="modal" data-target="#fulltext-help"><i class="icon-info"></i></span>
                           </td>
                           <td class="text-right"><?php echo $column_action; ?></td>
                        </tr>
                     </thead>
                     <tbody>
                        <tr class="filter">
                           <td></td>
                           <td>
                              <select name="filter_thread_id" class="form-control">
                                 <option value=""></option>
                                 <?php foreach ($threads as $thread) { ?>
                                 <?php if($filter_thread_id == $thread['thread_id']) { ?>
                                 <option value="<?php echo $thread['thread_id']; ?>" selected="selected"><?php echo $thread['name']; ?></option>
                                 <?php } else { ?>
                                 <option value="<?php echo $thread['thread_id']; ?>"><?php echo $thread['name']; ?></option>
                                 <?php } ?>
                                 <?php } ?>
                              </select>
                           </td>
                           <td>
                              <input type="text" name="filter_customer_name" value="<?php echo $filter_customer_name; ?>" class="form-control" />
                           </td>
                           <td>
                              <input type="text" name="filter_operator_name" value="<?php echo $filter_operator_name; ?>" class="form-control" />
                           </td>
                           <td>
                              <input type="text" name="filter_message" value="<?php echo $filter_message; ?>" class="form-control" />
                           </td>
                           <td align="text-right"><a onclick="filter();" class="btn btn-primary"><?php echo $button_filter; ?></a></td>
                        </tr>
                        <?php if ($rows) { ?>
                        <?php foreach ($rows as $row) { ?>
                        <tr class="<?php echo $row['tr_class']; ?>">
                           <td class="text-center">
                              <?php if ($row['selected']) { ?>
                              <input type="checkbox" name="selected[]" value="<?php echo $row['row_id']; ?>" checked="checked" />
                              <?php } else { ?>
                              <input type="checkbox" name="selected[]" value="<?php echo $row['row_id']; ?>" />
                              <?php } ?>
                           </td>
                           <td class="text-left"><?php echo $row['thread_id']; ?></td>
                           <td class="text-left"><?php echo $row['customer_name']; ?></td>
                           <td class="text-left"><?php echo $row['operator_name']; ?></td>
                           <td class="text-left"><?php echo $row['message']; ?></td>
                           <td></td>
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

<div id="fulltext-help" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><?php echo $text_fulltext_help; ?></h4>
      </div>

      <div class="modal-body">
         <table class="table table-condensed table-hover">
            <thead>
               <tr>
                  <td class="text-left"><?php echo $text_special_char; ?></td>
                  <td class="text-center"><?php echo $text_description; ?></td>
                  <td class="text-right"><?php echo $text_sample; ?></td>
               </tr>
            </thead>
            <tbody>
               <tr>
                  <td class="text-center"> <code>+</code> </td>
                  <td>
                     <?php echo $text_char_plus_description; ?>
                  </td>
                  <td>
                     <input type="text" class="form-group" value="red cheap +car">
                  </td>
               </tr>
               <tr>
                  <td class="text-center"> <code>-</code> </td>
                  <td>
                     <?php echo $text_char_minus_description; ?>
                  </td>
                  <td>
                     <input type="text" class="form-group" value="red -expensive +car">
                  </td>
               </tr>
               <tr>
                  <td class="text-center"> <code>&lt;, &gt;</code> </td>
                  <td>
                     <?php echo $text_char_less_great_than_description; ?>
                  </td>
                  <td>
                     <input type="text" class="form-group" value="red -expensive +car">
                  </td>
               </tr>
               <tr>
                  <td class="text-center"> <code>( )</code> </td>
                  <td>
                     <?php echo $text_char_bracket_description; ?>
                  </td>
                  <td>
                     <input type="text" class="form-group" value="+car +(>cheap <new)">
                  </td>
               </tr>
               <tr>
                  <td class="text-center"> <code>~</code> </td>
                  <td>
                     <?php echo $text_char_swung_dash_description; ?>
                  </td>
                  <td>
                     <input type="text" class="form-group" value="red +car ~blue">
                  </td>
               </tr>
               <tr>
                  <td class="text-center"> <code>*</code> </td>
                  <td>
                     <?php echo $text_char_star_description; ?>
                  </td>
                  <td>
                     <input type="text" class="form-group" value="car*">
                  </td>
               </tr>
               <tr>
                  <td class="text-center"> <code>" "</code> </td>
                  <td>
                     <?php echo $text_char_quotes_description; ?>
                  </td>
                  <td>
                     <input type="text" class="form-group" value="new cheap red car">
                  </td>
               </tr>
            </tbody>
         </table>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<script type="text/javascript">
   function filter() {
    url = 'index.php?route=livehelp/livehelp_data_warehouse&token=<?php echo $token; ?>';
   
    var filter_thread_id = $('select[name=\'filter_thread_id\'] option:selected').val();
    
    if (filter_thread_id) {
      url += '&filter_thread_id=' + encodeURIComponent(filter_thread_id);
    }
    
    var filter_customer_name = $('input[name=\'filter_customer_name\']').val();
    
    if (filter_customer_name) {
      url += '&filter_customer_name=' + encodeURIComponent(filter_customer_name);
    }
   
    var filter_operator_name = $('input[name=\'filter_operator_name\']').val();
    
    if (filter_operator_name) {
      url += '&filter_operator_name=' + encodeURIComponent(filter_operator_name);
    }
   
    var filter_message = $('input[name=\'filter_message\']').val();
    
    if (filter_message) {
      url += '&filter_message=' + encodeURIComponent(filter_message);
    }
    
    location = url;
   }
</script> 
<script type="text/javascript">
   $(document).ready(function() {
      $('#form input').keydown(function(e) {
         if (e.keyCode == 13) filter();
      });
   });
</script> 
<?php echo $footer; ?>