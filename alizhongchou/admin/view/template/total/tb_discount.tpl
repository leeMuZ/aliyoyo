<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-total" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
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
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
      </div>
      <div class="panel-body">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-total" class="form-horizontal">
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-heading"><?php echo $entry_heading;?></label>
            <div class="col-sm-10">
              <?php foreach ($languages as $language) { ?>
              <div><input type="text" name="tb_discount_heading[<?php echo $language['language_id']; ?>]" value="<?php echo $tb_discount_heading[$language['language_id']];?>"  class="form-control" style="width: 96%;float: left"/>      
                  <img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" style="float: left;margin: 5px;"/><br></div>
            <?php } ?>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
            <div class="col-sm-10">
              <select name="tb_discount_status" class="form-control">
                                <?php if ($tb_discount_status) { ?>
                                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                                <option value="0"><?php echo $text_disabled; ?></option>
                                <?php } else { ?>
                                <option value="1"><?php echo $text_enabled; ?></option>
                                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                                <?php } ?>
                            </select>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-sort-order"><?php echo $entry_sort_order; ?></label>
            <div class="col-sm-10">
             <input type="text" name="tb_discount_sort_order" value="<?php echo $tb_discount_sort_order; ?>" class="form-control" />
            </div>
          </div>
            
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-sort-order"><?php echo $entry_discount_type; ?></label>
            <div class="col-sm-10">
             <select name="tb_discount_type" id="tb_discount_type"  class="form-control">
                                <option value="0" <?php if (!$tb_discount_type) echo "selected=\"selected\""; ?> >
                                        <?php echo $entry_percentage; ?>
                            </option>
                            <option value="1" <?php if ($tb_discount_type) echo "selected=\"selected\""; ?> >
                                    <?php echo $entry_quantity; ?>
                        </option>
                    </select>  
            </div>
          </div>
            
            <div id="tab-geo-zone" class="form-group">
                            <label class="col-sm-2 control-label" for="input-amount"><?php echo $entry_discount; ?></label>
<div class="col-sm-10">
                    
                                <table class="list" id="module">
                                    <thead> 
                                        <tr>
                                            <td class="left" style="width: 120px;">From</td>
                                            <td class="left" style="width: 120px;"> To </td>
                                            <td class="left" style="width: 120px;">Charge <span id="discount_type"></span></td>
                                            <td style="width: 60px;"></td>
                                        </tr>
                                    </thead>                                
                                    <?php $module_row = 0; ?>
                                    <?php if(!empty($tb_discount_rates)){ ?>
                                    <?php foreach ($tb_discount_rates['from'] as $key => $tb_discount_rate) { ?>
                                    <tbody id="module-row-<?php echo $module_row; ?>">                                          
                                        <tr>
                                            <td class="left" style="width: 100px;">
                                                <input type="text" name="tb_discount_rate[from][<?php echo $module_row; ?>]" value="<?php echo $tb_discount_rate;?>" style="width: 100px;"  class="form-control"/>                                             
                                            </td>
                                            <td class="left">
                                                <input type="text" name="tb_discount_rate[to][<?php echo $module_row; ?>]" value="<?php echo $tb_discount_rates['to'][$key];?>" style="width: 100px;" class="form-control" />   
                                            </td>
                                            <td class="left">
                                                 <input type="text" name="tb_discount_rate[charge][<?php echo $module_row; ?>]" value="<?php echo $tb_discount_rates['charge'][$key];?>" style="width: 100px;" class="form-control" />           
                                            </td>

                                            <td class="left"><a onclick="$('#module-row-<?php echo $module_row; ?>').remove();" class="btn btn-danger">Remove</a></td>
                                        </tr>
                                    </tbody>
                                    <?php $module_row++; ?>
                                    <?php } ?>
                                    <?php } ?>   
                                    <tfoot>
                                        <tr>
                                            <td colspan="4"></td>
                                            <td class="left"><a onclick="addModule();" class="btn btn-primary">Add</a></td>
                                        </tr>
                                    </tfoot>

                                </table>
                              
</div>
                </div>
            
            
        </form>
      </div>
    </div>
  </div>
</div>
<?php echo $footer; ?>




<style type="text/css">
    .codeex_button{ background: none repeat scroll 0 0 #003A88 !important;
                    border-radius: 10px 10px 10px 10px;
                    color: #FFFFFF !important;
                    display: inline-block;
                    padding: 5px 15px;
                    text-decoration: none;
                    margin-left: 5px;
    }
</style>
<script type="text/javascript"><!--
var module_row = <?php echo $module_row; ?>;
            function addModule() {
                html = '<tbody><tr><td class="left" style="width: 100px;">&nbsp;</td></tr></tbody><tbody id="module-row-'+ module_row + '" >';
                html += '  <tr>';
                html += '   <td class="left" style="width: 100px;">';
                html += '       <input type="text" name="tb_discount_rate[from]['+module_row+']" value="" style="width: 100px;"  class="form-control"/>  ';
                html += '   </td>';
                html += '    <td class="left">';
                html += '       <input type="text" name="tb_discount_rate[to]['+module_row+']" value="" style="width: 100px;" class="form-control" />  ';
                html += '   </td>';
                html += '    <td class="left">';
                html += '       <input type="text" name="tb_discount_rate[charge]['+module_row+']" value="" style="width: 100px;" class="form-control" />  ';
                html += '    </td>';
                html += '    <td class="left"><a onclick="$(\'#module-row-'+ module_row + '\').remove();" class="btn btn-danger">Remove</a></td>';
                html += '  </tr>';
                html += '</tbody>';
//alert( $('.cls'+geo_zone_id).html());
                $('#module tfoot').before(html);

                module_row++;
            }
                 
//--></script> 
