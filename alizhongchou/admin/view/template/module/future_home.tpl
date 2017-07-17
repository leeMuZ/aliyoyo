<?php echo $header; ?><?php echo $column_left; ?>
<div id="content"><div class="container-fluid">
        <div class="page-header">
            <h1>Future Home</h1>
            <ul class="breadcrumb">
                <?php foreach ($breadcrumbs as $breadcrumb) { ?>
                <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
                <?php } ?>
            </ul>
        </div>

        <link rel="stylesheet" type="text/css" href="view/stylesheet/css/colorpicker.css" />
        <script type="text/javascript" src="view/javascript/jquery/colorpicker.js"></script>
        <link href='http://fonts.googleapis.com/css?family=Open+Sans:600,500,400' rel='stylesheet' type='text/css'>

        <script type="text/javascript">
            $.fn.tabs = function() {
                var selector = this;

                this.each(function() {
                    var obj = $(this);

                    $(obj.attr('href')).hide();

                    $(obj).click(function() {
                        $(selector).removeClass('selected');

                        $(selector).each(function(i, element) {
                            $($(element).attr('href')).hide();
                        });

                        $(this).addClass('selected');

                        $($(this).attr('href')).show();

                        return false;
                    });
                });

                $(this).show();

                $(this).first().click();
            };
        </script>

        <script type="text/javascript">
            $(document).ready(function() {

                $('.colorpicker-input').ColorPicker({
                    onChange: function (hsb, hex, rgb, el) {
                        $(el).val("#" +hex);
                        $(el).css("border-right", "20px solid #" + hex);
                    },
                    onShow: function (colpkr) {
                        $(colpkr).show();
                        return false;
                    },
                    onHide: function (colpkr) {
                        $(colpkr).hide();
                        return false;
                    }
                });
            });
        </script>

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
            <div class="set-size" id="advanced_grid">
                <div class="content">
                    <div>
                        <div class="tabs clearfix">
                            <!-- Tabs module -->
                            <div id="tabs" class="htabs main-tabs">
                                <?php $module_row = 1; ?>
                                <?php foreach ($modules as $module) { ?>
                                <a href="#tab-module-<?php echo $module_row; ?>" id="module-<?php echo $module_row; ?>">Module <?php echo $module_row; ?> &nbsp;<img src="view/image/module_template/delete-slider.png"  alt="" onclick="$('#module-<?php echo $module_row; ?>').remove(); $('#tab-module-<?php echo $module_row; ?>').remove(); $('.main-tabs a:first').trigger('click'); return false;" /></a>
                                <?php $module_row++; ?>
                                <?php } ?>
                                <span id="module-add">Add Module &nbsp;<img src="view/image/module_template/add.png" alt="" onclick="addModule();" /></span>
                            </div>

                            <?php $module_row = 1; $modules_count = 1; $columns_count = 1; $links = 1; $products_tabs = 1; $collections = 1; $future_image = 1; $future_home = 1; $future_product = 1; $future_category = 1;?>
                            <?php foreach ($modules as $module) { $column_count = $columns_count; ?>
                            <div id="tab-module-<?php echo $module_row; ?>" class="tab-content">
                                <div id="tab-module-<?php echo $module_row; ?>-tabs" class="module-tabs">
                                    <a href="#tab-module-<?php echo $module_row; ?>-settings">Settings</a>
                                    <?php if(isset($module['column'])) { foreach($module['column'] as $column) { ?>
                                    <a href="#tab-module-<?php echo $module_row; ?>-column-<?php echo $column_count; ?>" id="column-<?php echo $column_count; ?>">Column &nbsp;<img src="view/image/module_template/delete-slider.png" alt="" onclick="$('#tab-module-<?php echo $module_row; ?>-column-<?php echo $column_count; ?>').remove(); $('#column-<?php echo $column_count; ?>').remove(); return false;" /></a>
                                    <?php $column_count++; } } ?>
                                    <span class="column-add">Add Column &nbsp;<img src="view/image/module_template/add.png" alt="" onclick="addcolumn(<?php echo $module_row; ?>);" /></span>
                                </div>

                                <div id="tab-module-<?php echo $module_row; ?>-settings" class="tab-content3">
                                    <h4>Design settings</h4>
                                    <table class="form">
                                        <tr>
                                            <td>Add custom class:</td>
                                            <td><input type="text" name="future_home_module[<?php echo $module_row; ?>][custom_class]" value="<?php echo $module['custom_class']; ?>" /></td>
                                        </tr>
                                        <tr>
                                            <td>Margins (px):<br><small style="color:#a3a3a3;font-size: 10px">(Top - right - bottom - left)</small></td>
                                            <td><input type="text" name="future_home_module[<?php echo $module_row; ?>][margin_top]" style="display: inline-block;margin-right:10px;" size="2" value="<?php echo $module['margin_top']; ?>" /> - <input type="text" name="future_home_module[<?php echo $module_row; ?>][margin_right]" size="2" style="display: inline-block;margin-right:10px;margin-left: 10px" value="<?php echo $module['margin_right']; ?>" /> - <input type="text" name="future_home_module[<?php echo $module_row; ?>][margin_bottom]" size="2" style="display: inline-block;margin-right:10px;margin-left: 10px" value="<?php echo $module['margin_bottom']; ?>" /> - <input type="text" name="future_home_module[<?php echo $module_row; ?>][margin_left]" style="display: inline-block;margin-right:10px;margin-left: 10px" size="2" value="<?php echo $module['margin_left']; ?>" /></td>
                                        </tr>
                                        <tr>
                                            <td>Paddings (px):<br><small style="color:#a3a3a3;font-size: 10px">(Top - right - bottom - left)</small></td>
                                            <td><input type="text" name="future_home_module[<?php echo $module_row; ?>][padding_top]" style="display: inline-block;margin-right:10px;" size="2" value="<?php echo $module['padding_top']; ?>" /> - <input type="text" name="future_home_module[<?php echo $module_row; ?>][padding_right]" size="2" style="display: inline-block;margin-right:10px;margin-left: 10px" value="<?php echo $module['padding_right']; ?>" /> - <input type="text" name="future_home_module[<?php echo $module_row; ?>][padding_bottom]" size="2" style="display: inline-block;margin-right:10px;margin-left: 10px" value="<?php echo $module['padding_bottom']; ?>" /> - <input type="text" name="future_home_module[<?php echo $module_row; ?>][padding_left]" style="display: inline-block;margin-right:10px;margin-left: 10px" size="2" value="<?php echo $module['padding_left']; ?>" /></td>
                                        </tr>
                                        <tr>
                                            <td>Force full width:</td>
                                            <td><select name="future_home_module[<?php echo $module_row; ?>][force_full_width]">
                                                    <option value="0"<?php if($module['force_full_width'] == 0) echo ' selected="selected"'; ?>>No</option>
                                                    <option value="1"<?php if($module['force_full_width'] == 1) echo ' selected="selected"'; ?>>Yes</option>
                                                </select></td>
                                        </tr>
                                        <tr>
                                            <td>Background color:</td>
                                            <td><input type="text" name="future_home_module[<?php echo $module_row; ?>][background_color]" class="colorpicker-input" value="<?php echo $module['background_color']; ?>" <?php if($module['background_color'] != '') echo 'style="border-right: 20px solid ' . $module['background_color'] . '"'; ?> /></td>
                                        </tr>
                                        <tr>
                                            <td>Background image type:</td>
                                            <td><select name="future_home_module[<?php echo $module_row; ?>][background_image_type]">
                                                    <option value="0"<?php if($module['background_image_type'] == 0) echo ' selected="selected"'; ?>>None</option>
                                                    <option value="1"<?php if($module['background_image_type'] == 1) echo ' selected="selected"'; ?>>Standard</option>
                                                    <option value="2"<?php if($module['background_image_type'] == 2) echo ' selected="selected"'; ?>>Parallax</option>
                                                </select></td>
                                        </tr>
                                        <tr>
                                            <td>Background image:</td>
                                            <td>
                                                <?php if ($module['background_image']) { ?>
                                                <a href="" id="thumb-<?php echo $module_row; ?>" class="img-thumbnail img-edit" data-toggle="image"><img src="../image/<?php echo $module['background_image']; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a>
                                                <?php } else { ?>
                                                <a href="" id="thumb-<?php echo $module_row; ?>" class="img-thumbnail img-edit" data-toggle="image"><img src="<?php echo $placeholder; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a>
                                                <?php } ?>
                                                <input type="hidden" name="future_home_module[<?php echo $module_row; ?>][background_image]" value="<?php echo $module['background_image']; ?>" id="input-<?php echo $module_row; ?>" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Position:</td>
                                            <td><select name="future_home_module[<?php echo $module_row; ?>][background_image_position]">
                                                    <option value="top left"<?php if($module['background_image_position'] == 'top left') echo ' selected="selected"'; ?>>Top left</option>
                                                    <option value="top center"<?php if($module['background_image_position'] == 'top center') echo ' selected="selected"'; ?>>Top center</option>
                                                    <option value="top right"<?php if($module['background_image_position'] == 'top right') echo ' selected="selected"'; ?>>Top right</option>
                                                    <option value="bottom left"<?php if($module['background_image_position'] == 'bottom left') echo ' selected="selected"'; ?>>Bottom left</option>
                                                    <option value="bottom center"<?php if($module['background_image_position'] == 'bottom center') echo ' selected="selected"'; ?>>Bottom center</option>
                                                    <option value="bottom right"<?php if($module['background_image_position'] == 'bottom right') echo ' selected="selected"'; ?>>Bottom right</option>
                                                    <option value="50% 0"<?php if($module['background_image_position'] == '50% 0') echo ' selected="selected"'; ?>>50% 0</option>
                                                </select></td>
                                        </tr>
                                        <tr>
                                            <td>Repeat:</td>
                                            <td><select name="future_home_module[<?php echo $module_row; ?>][background_image_repeat]">
                                                    <option value="no-repeat"<?php if($module['background_image_repeat'] == 'no-repeat') echo ' selected="selected"'; ?>>no-repeat</option>
                                                    <option value="repeat-x"<?php if($module['background_image_repeat'] == 'repeat-x') echo ' selected="selected"'; ?>>repeat-x</option>
                                                    <option value="repeat-y"<?php if($module['background_image_repeat'] == 'repeat-y') echo ' selected="selected"'; ?>>repeat-y</option>
                                                    <option value="repeat"<?php if($module['background_image_repeat'] == 'repeat') echo ' selected="selected"'; ?>>repeat</option>
                                                </select></td>
                                        </tr>
                                        <tr>
                                            <td>Attachment:</td>
                                            <td><select name="future_home_module[<?php echo $module_row; ?>][background_image_attachment]">
                                                    <option value="scroll"<?php if($module['background_image_attachment'] == 'scroll') echo ' selected="selected"'; ?>>scroll</option>
                                                    <option value="fixed"<?php if($module['background_image_attachment'] == 'fixed') echo ' selected="selected"'; ?>>fixed</option>
                                                </select></td>
                                        </tr>
                                    </table>

                                    <h4 style="padding-top: 30px">Layout settings</h4>
                                    <table class="form">
                                        <tr>
                                            <td>Layout:</td>
                                            <td><select name="future_home_module[<?php echo $module_row; ?>][layout_id]">
                                                    <option value="88888" selected>6#Future(HOME)</option>
                                                </select></td>
                                        </tr>
                                        <tr>
                                            <td>Position:</td>
                                            <td><select name="future_home_module[<?php echo $module_row; ?>][position]">

                                                    <?php if ($module['position'] == 'header') { ?>
                                                    <option value="header" selected="selected">Header</option>
                                                    <?php } else { ?>
                                                    <option value="header">Header</option>
                                                    <?php } ?>



                                                    <?php if ($module['position'] == 'middle') { ?>
                                                    <option value="middle" selected="selected">Middle</option>
                                                    <?php } else { ?>
                                                    <option value="middle">Middle</option>
                                                    <?php } ?>



                                                    <?php if ($module['position'] == 'bottom') { ?>
                                                    <option value="bottom" selected="selected">Bottom</option>
                                                    <?php } else { ?>
                                                    <option value="bottom">Bottom</option>
                                                    <?php } ?>


                                                    <?php if ($module['position'] == 'other') { ?>
                                                    <option value="other" selected="selected">Other</option>
                                                    <?php } else { ?>
                                                    <option value="other">Other</option>
                                                    <?php } ?>
                                                </select></td>
                                        </tr>
                                        <tr>
                                            <td>Status:</td>
                                            <td><select name="future_home_module[<?php echo $module_row; ?>][status]">
                                                    <option value="1"<?php if($module['status'] == 1) echo ' selected="selected"'; ?>>Enabled</option>
                                                    <option value="0"<?php if($module['status'] == 0) echo ' selected="selected"'; ?>>Disabled</option>
                                                </select></td>
                                        </tr>
                                        <tr>
                                            <td>Sort Order:</td>
                                            <td><input type="text" name="future_home_module[<?php echo $module_row; ?>][sort_order]" value="<?php echo $module['sort_order']; ?>" size="3" /></td>
                                        </tr>
                                        <tr>
                                            <td>Disable on mobile:</td>
                                            <td><select name="future_home_module[<?php echo $module_row; ?>][disable_on_mobile]">
                                                    <option value="0"<?php if($module['disable_on_mobile'] == 0) echo ' selected="selected"'; ?>>No</option>
                                                    <option value="1"<?php if($module['disable_on_mobile'] == 1) echo ' selected="selected"'; ?>>Yes</option>
                                                </select></td>
                                        </tr>
                                    </table>
                                </div>

                                <?php if(isset($module['column'])) { foreach($module['column'] as $column) { ?>
                                <div id="tab-module-<?php echo $module_row; ?>-column-<?php echo $columns_count; ?>" class="tab-content3">
                                    <?php if($column['status'] == 1) { echo '<div class="status status-on" title="1" rel="module_' . $module_row . '_column_' . $columns_count . '_status"></div>'; } else { echo '<div class="status status-off" title="0" rel="module_' . $module_row . '_column_' . $columns_count . '_status"></div>'; } ?>
                                <input name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][status]" value="<?php echo $column['status']; ?>" id="module_<?php echo $module_row; ?>_column_<?php echo $columns_count; ?>_status" type="hidden" />

                                <div class="input clearfix">
                                    <p>Column width:</p>
                                    <select name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][width]" class="change-column-width" id="module-<?php echo $module_row; ?>-column-<?php echo $columns_count; ?>">
                                        <option value="1"<?php if($column['width'] == 1) echo ' selected="selected"'; ?>>1/12</option>
                                        <option value="2"<?php if($column['width'] == 2) echo ' selected="selected"'; ?>>2/12</option>
                                        <option value="3"<?php if($column['width'] == 3) echo ' selected="selected"'; ?>>3/12</option>
                                        <option value="4"<?php if($column['width'] == 4) echo ' selected="selected"'; ?>>4/12</option>
                                        <option value="5"<?php if($column['width'] == 5) echo ' selected="selected"'; ?>>5/12</option>
                                        <option value="6"<?php if($column['width'] == 6) echo ' selected="selected"'; ?>>6/12</option>
                                        <option value="7"<?php if($column['width'] == 7) echo ' selected="selected"'; ?>>7/12</option>
                                        <option value="8"<?php if($column['width'] == 8) echo ' selected="selected"'; ?>>8/12</option>
                                        <option value="9"<?php if($column['width'] == 9) echo ' selected="selected"'; ?>>9/12</option>
                                        <option value="10"<?php if($column['width'] == 10) echo ' selected="selected"'; ?>>10/12</option>
                                        <option value="11"<?php if($column['width'] == 11) echo ' selected="selected"'; ?>>11/12</option>
                                        <option value="12"<?php if($column['width'] == 12) echo ' selected="selected"'; ?>>12/12</option>
                                        <option value="advanced"<?php if($column['width'] == 'advanced') echo ' selected="selected"'; ?>>Advanced</option>
                                    </select>
                                </div>

                                <div class="input clearfix simple-width"<?php if($column['width'] == 'advanced') echo ' style="display: none"'; ?>>
                                <p>Disable on mobile:</p>
                                <select name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][disable_on_mobile]">
                                    <option value="0"<?php if($column['disable_on_mobile'] == 0) echo ' selected="selected"'; ?>>No</option>
                                    <option value="1"<?php if($column['disable_on_mobile'] == 1) echo ' selected="selected"'; ?>>Yes</option>
                                </select>
                            </div>

                            <div class="input clearfix advanced-width"<?php if($column['width'] != 'advanced') echo ' style="display: none"'; ?>>
                            <p>Column width on extra small devices (<768px):</p>
                            <select name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][width_xs]">
                                <option value="1"<?php if($column['width_xs'] == 1) echo ' selected="selected"'; ?>>1/12</option>
                                <option value="2"<?php if($column['width_xs'] == 2) echo ' selected="selected"'; ?>>2/12</option>
                                <option value="3"<?php if($column['width_xs'] == 3) echo ' selected="selected"'; ?>>3/12</option>
                                <option value="4"<?php if($column['width_xs'] == 4) echo ' selected="selected"'; ?>>4/12</option>
                                <option value="5"<?php if($column['width_xs'] == 5) echo ' selected="selected"'; ?>>5/12</option>
                                <option value="6"<?php if($column['width_xs'] == 6) echo ' selected="selected"'; ?>>6/12</option>
                                <option value="7"<?php if($column['width_xs'] == 7) echo ' selected="selected"'; ?>>7/12</option>
                                <option value="8"<?php if($column['width_xs'] == 8) echo ' selected="selected"'; ?>>8/12</option>
                                <option value="9"<?php if($column['width_xs'] == 9) echo ' selected="selected"'; ?>>9/12</option>
                                <option value="10"<?php if($column['width_xs'] == 10) echo ' selected="selected"'; ?>>10/12</option>
                                <option value="11"<?php if($column['width_xs'] == 11) echo ' selected="selected"'; ?>>11/12</option>
                                <option value="12"<?php if($column['width_xs'] == 12) echo ' selected="selected"'; ?>>12/12</option>
                                <option value="hidden"<?php if($column['width_xs'] == 'hidden') echo ' selected="selected"'; ?>>hidden</option>
                            </select>
                        </div>

                        <div class="input clearfix advanced-width"<?php if($column['width'] != 'advanced') echo ' style="display: none"'; ?>>
                        <p>Column width on small devices (≥768px):</p>
                        <select name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][width_sm]">
                            <option value="1"<?php if($column['width_sm'] == 1) echo ' selected="selected"'; ?>>1/12</option>
                            <option value="2"<?php if($column['width_sm'] == 2) echo ' selected="selected"'; ?>>2/12</option>
                            <option value="3"<?php if($column['width_sm'] == 3) echo ' selected="selected"'; ?>>3/12</option>
                            <option value="4"<?php if($column['width_sm'] == 4) echo ' selected="selected"'; ?>>4/12</option>
                            <option value="5"<?php if($column['width_sm'] == 5) echo ' selected="selected"'; ?>>5/12</option>
                            <option value="6"<?php if($column['width_sm'] == 6) echo ' selected="selected"'; ?>>6/12</option>
                            <option value="7"<?php if($column['width_sm'] == 7) echo ' selected="selected"'; ?>>7/12</option>
                            <option value="8"<?php if($column['width_sm'] == 8) echo ' selected="selected"'; ?>>8/12</option>
                            <option value="9"<?php if($column['width_sm'] == 9) echo ' selected="selected"'; ?>>9/12</option>
                            <option value="10"<?php if($column['width_sm'] == 10) echo ' selected="selected"'; ?>>10/12</option>
                            <option value="11"<?php if($column['width_sm'] == 11) echo ' selected="selected"'; ?>>11/12</option>
                            <option value="12"<?php if($column['width_sm'] == 12) echo ' selected="selected"'; ?>>12/12</option>
                            <option value="hidden"<?php if($column['width_sm'] == 'hidden') echo ' selected="selected"'; ?>>hidden</option>
                        </select>
                    </div>

                    <div class="input clearfix advanced-width"<?php if($column['width'] != 'advanced') echo ' style="display: none"'; ?>>
                    <p>Column width on medium devices (≥992px):</p>
                    <select name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][width_md]">
                        <option value="1"<?php if($column['width_md'] == 1) echo ' selected="selected"'; ?>>1/12</option>
                        <option value="2"<?php if($column['width_md'] == 2) echo ' selected="selected"'; ?>>2/12</option>
                        <option value="3"<?php if($column['width_md'] == 3) echo ' selected="selected"'; ?>>3/12</option>
                        <option value="4"<?php if($column['width_md'] == 4) echo ' selected="selected"'; ?>>4/12</option>
                        <option value="5"<?php if($column['width_md'] == 5) echo ' selected="selected"'; ?>>5/12</option>
                        <option value="6"<?php if($column['width_md'] == 6) echo ' selected="selected"'; ?>>6/12</option>
                        <option value="7"<?php if($column['width_md'] == 7) echo ' selected="selected"'; ?>>7/12</option>
                        <option value="8"<?php if($column['width_md'] == 8) echo ' selected="selected"'; ?>>8/12</option>
                        <option value="9"<?php if($column['width_md'] == 9) echo ' selected="selected"'; ?>>9/12</option>
                        <option value="10"<?php if($column['width_md'] == 10) echo ' selected="selected"'; ?>>10/12</option>
                        <option value="11"<?php if($column['width_md'] == 11) echo ' selected="selected"'; ?>>11/12</option>
                        <option value="12"<?php if($column['width_md'] == 12) echo ' selected="selected"'; ?>>12/12</option>
                        <option value="hidden"<?php if($column['width_md'] == 'hidden') echo ' selected="selected"'; ?>>hidden</option>
                    </select>
                </div>

                <div class="input clearfix advanced-width"<?php if($column['width'] != 'advanced') echo ' style="display: none"'; ?>>
                <p>Column width on large devices (≥1200px):</p>
                <select name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][width_lg]">
                    <option value="1"<?php if($column['width_lg'] == 1) echo ' selected="selected"'; ?>>1/12</option>
                    <option value="2"<?php if($column['width_lg'] == 2) echo ' selected="selected"'; ?>>2/12</option>
                    <option value="3"<?php if($column['width_lg'] == 3) echo ' selected="selected"'; ?>>3/12</option>
                    <option value="4"<?php if($column['width_lg'] == 4) echo ' selected="selected"'; ?>>4/12</option>
                    <option value="5"<?php if($column['width_lg'] == 5) echo ' selected="selected"'; ?>>5/12</option>
                    <option value="6"<?php if($column['width_lg'] == 6) echo ' selected="selected"'; ?>>6/12</option>
                    <option value="7"<?php if($column['width_lg'] == 7) echo ' selected="selected"'; ?>>7/12</option>
                    <option value="8"<?php if($column['width_lg'] == 8) echo ' selected="selected"'; ?>>8/12</option>
                    <option value="9"<?php if($column['width_lg'] == 9) echo ' selected="selected"'; ?>>9/12</option>
                    <option value="10"<?php if($column['width_lg'] == 10) echo ' selected="selected"'; ?>>10/12</option>
                    <option value="11"<?php if($column['width_lg'] == 11) echo ' selected="selected"'; ?>>11/12</option>
                    <option value="12"<?php if($column['width_lg'] == 12) echo ' selected="selected"'; ?>>12/12</option>
                    <option value="hidden"<?php if($column['width_lg'] == 'hidden') echo ' selected="selected"'; ?>>hidden</option>
                </select>
            </div>

            <div class="input clearfix">
                <p>Sort:</p>
                <input type="text" name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][sort]" value="<?php echo $column['sort']; ?>">
            </div>

            <h4 style="margin-top: 20px">Add modules to the column</h4>

            <div id="module_<?php echo $module_row; ?>_column_<?php echo $columns_count; ?>_modules" class="tabs_add_element clearfix">
                <?php if(isset($column['module'])) { $s = 1; foreach($column['module'] as $column_module) { ?>
                <a href="#module-<?php echo $module_row; ?>-<?php echo $columns_count; ?>-module-<?php echo $s; ?>" id="element-<?php echo $modules_count; ?>"><?php echo $s; ?> &nbsp;<img src="view/image/module_template/delete-slider.png" alt="" onclick="$('#element-<?php echo $modules_count; ?>').remove(); $('#module-<?php echo $module_row; ?>-<?php echo $columns_count; ?>-module-<?php echo $s; ?>').remove(); return false;" /></a>
                <?php $s++; $modules_count++; } } ?>
                <img src="view/image/module_template/add.png" alt="" onclick="addModuleToColumn(<?php echo $module_row; ?>, <?php echo $columns_count; ?>);">
            </div>

            <?php if(isset($column['module'])) { $s = 1; foreach($column['module'] as $column_module) { ?>
            <div id="module-<?php echo $module_row; ?>-<?php echo $columns_count; ?>-module-<?php echo $s; ?>" style="padding-top: 20px">
                <?php if($column_module['status'] == 1) { echo '<div class="status status-on" title="1" rel="module_' . $module_row . '_column_' . $columns_count . '_module_' . $s . '_status"></div>'; } else { echo '<div class="status status-off" title="0" rel="module_' . $module_row . '_column_' . $columns_count . '_module_' . $s . '_status"></div>'; } ?>
            <input name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][status]" value="<?php echo $column_module['status']; ?>" id="module_<?php echo $module_row; ?>_column_<?php echo $columns_count; ?>_module_<?php echo $s; ?>_status" type="hidden" />

            <div class="input clearfix">
                <p>Sort:</p>
                <input type="text" name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][sort]" value="<?php echo $column_module['sort']; ?>">
            </div>
            <div class="input clearfix">
                <p>Type column:</p>
                <select name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][type]" class="type-column" id="<?php echo $module_row; ?>-<?php echo $columns_count; ?>-module-<?php echo $s; ?>">
                  <!--  <option value="html"<?php if($column_module['type'] == 'html') echo ' selected="selected"'; ?>>HTML</option>
                    <option value="box"<?php if($column_module['type'] == 'box') echo ' selected="selected"'; ?>>Box</option>
                    <option value="links"<?php if($column_module['type'] == 'links') echo ' selected="selected"'; ?>>Links</option>
                    <option value="products"<?php if($column_module['type'] == 'products') echo ' selected="selected"'; ?>>Products</option>
                    <option value="products_tabs"<?php if($column_module['type'] == 'products_tabs') echo ' selected="selected"'; ?>>Products Tabs</option>
                    <option value="collections"<?php if($column_module['type'] == 'collections') echo ' selected="selected"'; ?>>collections</option>
                    <option value="newsletter"<?php if($column_module['type'] == 'newsletter') echo ' selected="selected"'; ?>>Newsletter</option>
                    <option value="latest_blogs"<?php if($column_module['type'] == 'latest_blogs') echo ' selected="selected"'; ?>>Latest blogs</option>
                    <option value="load_module"<?php if($column_module['type'] == 'load_module') echo ' selected="selected"'; ?>>Load module</option>-->
                    <option value="future_home"<?php if($column_module['type'] == 'future_home') echo ' selected="selected"'; ?>>Future home</option>
                    <option value="future_carousel"<?php if($column_module['type'] == 'future_carousel') echo ' selected="selected"'; ?>>Future carousel</option>
                    <!--<option value="future_product"<?php if($column_module['type'] == 'future_product') echo ' selected="selected"'; ?>>Future product</option>-->
                    <option value="future_category"<?php if($column_module['type'] == 'future_category') echo ' selected="selected"'; ?>>Future category</option>
                </select>
            </div>

            <div class="type-column">

                <div class="html"<?php if($column_module['type'] != 'html') echo ' style="display: none"'; ?>>
                <div id="language-html-<?php echo $module_row; ?>-<?php echo $columns_count; ?>-<?php echo $s; ?>" class="htabs">
                    <?php foreach ($languages as $language) { ?>
                    <a href="#tab-language-html-<?php echo $module_row; ?>-<?php echo $columns_count; ?>-<?php echo $s; ?>-<?php echo $language['language_id']; ?>"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>
                    <?php } ?>
                </div>

                <?php foreach ($languages as $language) { ?>
                <div id="tab-language-html-<?php echo $module_row; ?>-<?php echo $columns_count; ?>-<?php echo $s; ?>-<?php echo $language['language_id']; ?>">
                    <div class="input clearfix">
                        <p>HTML:</p>
                        <textarea name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][html][<?php echo $language['language_id']; ?>]" <?php if($column_module['type'] != 'html') echo 'disabled="disabled"'; ?>><?php $language_id = $language['language_id']; if(isset($column_module['html'][$language_id])) echo $column_module['html'][$language_id]; ?></textarea>
                    </div>
                </div>
                <?php } ?>
            </div>

            <div class="box"<?php if($column_module['type'] != 'box') echo ' style="display: none"'; ?>>
            <div id="language-box-<?php echo $module_row; ?>-<?php echo $columns_count; ?>-<?php echo $s; ?>" class="htabs">
                <?php foreach ($languages as $language) { ?>
                <a href="#tab-language-box-<?php echo $module_row; ?>-<?php echo $columns_count; ?>-<?php echo $s; ?>-<?php echo $language['language_id']; ?>"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>
                <?php } ?>
            </div>

            <?php foreach ($languages as $language) { ?>
            <div id="tab-language-box-<?php echo $module_row; ?>-<?php echo $columns_count; ?>-<?php echo $s; ?>-<?php echo $language['language_id']; ?>">
                <div class="input clearfix">
                    <p>Module Title:</p>
                    <input type="text" name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][module][title][<?php echo $language['language_id']; ?>]" value="<?php $language_id = $language['language_id']; if(isset($column_module['module']['title'][$language_id])) echo $column_module['module']['title'][$language_id]; ?>" <?php if($column_module['type'] != 'box') echo 'disabled="disabled"'; ?>>
                </div>

                <div class="input clearfix">
                    <p>Module Text:</p>
                    <textarea name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][module][text][<?php echo $language['language_id']; ?>]" <?php if($column_module['type'] != 'box') echo 'disabled="disabled"'; ?>><?php $language_id = $language['language_id']; if(isset($column_module['module']['text'][$language_id])) echo $column_module['module']['text'][$language_id]; ?></textarea>
                </div>
            </div>
            <?php } ?>
    </div>

    <div class="links"<?php if($column_module['type'] != 'links') echo ' style="display: none"'; ?>>

    <div class="input clearfix" style="padding-top:30px">
        <p>Module Template:</p>
        <div class="module-layouts">
            <?php foreach($templates as $template) {
						   	               if(isset($links_templates[$template])) {
						   	                    $i = 0;
						   	                    echo '<div class="module-layout-title">' . $template . '</div>';
        if(!isset($column_module['links']['module_layout'])) $column_module['links']['module_layout'] = false;
        foreach($links_templates[$template] as $file_template) { ?>
        <div class="module-layout clearfix">
            <input type="radio" name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][links][module_layout]" value="<?php echo $file_template; ?>" <?php if($column_module['links']['module_layout'] == $file_template) echo 'checked="checked"'; ?> class="input-module-layout" <?php if($column_module['type'] != 'links') echo 'disabled="disabled"'; ?>>
            <p><?php echo $file_template; ?></p>
        </div>
        <?php $i++; }
						   	               }
						   	          } ?>
    </div>
</div>

<div class="input clearfix">
    <p>Module Title:</p>
    <div class="list-language">
        <?php foreach ($languages as $language) { ?>
        <div class="language"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" alt="<?php echo $language['name']; ?>" width="16px" height="11px" /><input type="text" name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][links][title][<?php echo $language['language_id']; ?>]" value="<?php $language_id = $language['language_id']; if(isset($column_module['links']['title'][$language_id])) echo $column_module['links']['title'][$language_id]; ?>" <?php if($column_module['type'] != 'links') echo 'disabled="disabled"'; ?>></div>
        <?php } ?>
    </div>
</div>

<div class="input clearfix" style="border:none">
    <p>Max links in one column:</p>
    <input type="text" name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][links][limit]" value="<?php if(isset($column_module['links']['limit'])) echo $column_module['links']['limit']; ?>" style="width: 50px" <?php if($column_module['type'] != 'links') echo 'disabled="disabled"'; ?>>
</div>

<table id="links-<?php echo $module_row; ?>-<?php echo $columns_count; ?>-<?php echo $s; ?>">
    <thead>
    <tr>
        <td class="first">Name</td>
        <td>Link</td>
        <td>Sort</td>
        <td>Delete</td>
    </tr>
    </thead>
    <?php if(isset($column_module['links']['array'])) { foreach ($column_module['links']['array'] as $link) { ?>
    <tbody id="link-<?php echo $links; ?>">
    <tr>
        <td class="first"><div class="list-language">
                <?php foreach ($languages as $language) { ?>
                <div class="language">
                    <img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" alt="<?php echo $language['name']; ?>" width="16px" height="11px" />
                    <input type="text" name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][links][array][<?php echo $links; ?>][name][<?php echo $language['language_id']; ?>]" value="<?php $language_id = $language['language_id']; if(isset($link['name'][$language_id])) echo $link['name'][$language_id]; ?>">
                </div>
                <?php } ?>
            </div></td>
        <td><input type="text" name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][links][array][<?php echo $links; ?>][url]" value="<?php echo $link['url']; ?>" <?php if($column_module['type'] != 'links') echo 'disabled="disabled"'; ?>></td>
        <td><input type="text" class="sort" name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][links][array][<?php echo $links; ?>][sort]" value="<?php echo $link['sort']; ?>" <?php if($column_module['type'] != 'links') echo 'disabled="disabled"'; ?>></td>
        <td><a onclick="$('#link-<?php echo $links; ?>').remove();" class="remove-link">Remove</a></td>
    </tr>
    </tbody>
    <?php $links++; } } ?>
    <tfoot></tfoot>
</table>
<a onclick="addLink(<?php echo $module_row; ?>, <?php echo $columns_count; ?>, <?php echo $s; ?>);" class="add-link">Add item</a>
</div>

<div class="products"<?php if($column_module['type'] != 'products') echo ' style="display: none"'; ?>>

<div class="input clearfix" style="padding-top:30px">
    <p>Module Template:</p>
    <div class="module-layouts">
        <?php foreach($templates as $template) {
						   	               if(isset($products_templates[$template])) {
						   	                    $i = 0;
						   	                    echo '<div class="module-layout-title">' . $template . '</div>';
    if(!isset($column_module['products']['module_layout'])) $column_module['products']['module_layout'] = false;
    foreach($products_templates[$template] as $file_template) { ?>
    <div class="module-layout clearfix">
        <input type="radio" name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][products][module_layout]" value="<?php echo $file_template; ?>" <?php if($column_module['products']['module_layout'] == $file_template) echo 'checked="checked"'; ?> class="input-module-layout" <?php if($column_module['type'] != 'products') echo 'disabled="disabled"'; ?>>
        <p><?php echo $file_template; ?></p>
    </div>
    <?php $i++; }
						   	               }
						   	          } ?>
</div>
</div>

<div class="input clearfix">
    <p>Module Title:</p>
    <div class="list-language">
        <?php foreach ($languages as $language) { ?>
        <div class="language"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" alt="<?php echo $language['name']; ?>" width="16px" height="11px" /><input type="text" name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][products][title][<?php echo $language['language_id']; ?>]" value="<?php $language_id = $language['language_id']; if(isset($column_module['products']['title'][$language_id])) echo $column_module['products']['title'][$language_id]; ?>" <?php if($column_module['type'] != 'products') echo 'disabled="disabled"'; ?>></div>
        <?php } ?>
    </div>
</div>

<div class="input clearfix">
    <p>Get products from:</p>
    <div style="float:left;width:425px">
        <select name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][products][get_products_from]" class="get-product" id="<?php echo $module_row; ?>-<?php echo $columns_count; ?>-module-<?php echo $s; ?>" <?php if($column_module['type'] != 'products') echo 'disabled="disabled"'; ?>>
        <?php if(!isset($column_module['products']['get_products_from'])) $column_module['products']['get_products_from'] = false; ?>
        <option value="latest"<?php if($column_module['products']['get_products_from'] == 'latest') echo ' selected="selected"'; ?>>Latest Products</option>
        <option value="special"<?php if($column_module['products']['get_products_from'] == 'special') echo ' selected="selected"'; ?>>Special Products</option>
        <option value="bestsellers"<?php if($column_module['products']['get_products_from'] == 'bestsellers') echo ' selected="selected"'; ?>>Bestsellers Products</option>
        <option value="products"<?php if($column_module['products']['get_products_from'] == 'products') echo ' selected="selected"'; ?>>Choose a products</option>
        <option value="category"<?php if($column_module['products']['get_products_from'] == 'category') echo ' selected="selected"'; ?>>Choose a category</option>
        <option value="random"<?php if($column_module['products']['get_products_from'] == 'random') echo ' selected="selected"'; ?>>Random products</option>
        <option value="people_also_bought"<?php if($column_module['products']['get_products_from'] == 'people_also_bought') echo ' selected="selected"'; ?>>People also bought</option>
        <option value="related"<?php if($column_module['products']['get_products_from'] == 'related') echo ' selected="selected"'; ?>>Related products</option>
        <option value="most_viewed"<?php if($column_module['products']['get_products_from'] == 'most_viewed') echo ' selected="selected"'; ?>>Most viewed</option>
        </select>

        <div class="filter_<?php echo $module_row; ?>_<?php echo $columns_count; ?>_<?php echo $s; ?>_products panel-products-autocomplete"<?php if($column_module['products']['get_products_from'] != 'products') echo ' style="display: none"'; ?>>
        <div class="products-autocomplete clearfix">
            <p>Products:<br><span style="font-size:11px;color:#808080">(Autocomplete)</span></p>
            <div><input type="text" alt="<?php echo $module_row; ?>" title="<?php echo $columns_count; ?>" id="<?php echo $s; ?>" name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][products][product]" value="" <?php if($column_module['type'] != 'products') echo 'disabled="disabled"'; ?> /></div>
        </div>
        <div class="scrollbox products">
            <?php if(!isset($column_module['products']['products'])) $column_module['products']['products'] = false; ?>
            <?php $products = explode(',', $column_module['products']['products']); ?>
            <?php $class = 'odd'; ?>
            <?php foreach ($products as $product) { if($product > 0) { ?>
            <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
            <?php
						   	          							     	$model_catalog_product = $registry->get('model_catalog_product');
            $product_info = $model_catalog_product->getProduct($product);
            $product_name = false;
            if($product_info) {
            $product_name = $product_info['name'];
            }
            ?>
            <div id="product-<?php echo $module_row; ?>-<?php echo $columns_count; ?>-<?php echo $s; ?>-<?php echo $product; ?>" class="<?php echo $class; ?>"><?php echo $product_name; ?> <img src="view/image/module_template/delete-slider.png" alt="<?php echo $module_row; ?>" title="<?php echo $columns_count; ?>" id="<?php echo $s; ?>" class="<?php echo $product; ?>" />
                <input type="hidden" value="<?php echo $product; ?>" />
            </div>
            <?php } } ?>
        </div>
        <input type="hidden" name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][products][products]" value="<?php if(isset($column_module['products']['products'])) echo $column_module['products']['products']; ?>" <?php if($column_module['type'] != 'products') echo 'disabled="disabled"'; ?> />
    </div>

    <div class="filter_<?php echo $module_row; ?>_<?php echo $columns_count; ?>_<?php echo $s; ?>_categories panel-categories-autocomplete"<?php if($column_module['products']['get_products_from'] != 'category') echo ' style="display: none"'; ?>>
    <div class="products-autocomplete clearfix">
        <p>Categories:<br><span style="font-size:11px;color:#808080">(Autocomplete)</span></p>
        <div><input type="text" alt="<?php echo $module_row; ?>" title="<?php echo $columns_count; ?>" id="<?php echo $s; ?>" name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][products][category]" <?php if($column_module['type'] != 'products') echo 'disabled="disabled"'; ?> value="" /></div>
    </div>
    <div class="scrollbox categories">
        <?php if(!isset($column_module['products']['categories'])) $column_module['products']['categories'] = false; ?>
        <?php $categories = explode(',', $column_module['products']['categories']); ?>
        <?php $class = 'odd'; ?>
        <?php foreach ($categories as $category) { if($category > 0) { ?>
        <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
        <?php
						   	          							     	$model_catalog_category = $registry->get('model_catalog_category');
        $category_info = $model_catalog_category->getCategory($category);
        $category_name = false;
        if($category_info) {
        $category_name = $category_info['name'];
        }
        ?>
        <div id="category-<?php echo $module_row; ?>-<?php echo $columns_count; ?>-<?php echo $s; ?>-<?php echo $category; ?>" class="<?php echo $class; ?>"><?php echo $category_name; ?> <img src="view/image/module_template/delete-slider.png" alt="<?php echo $module_row; ?>" title="<?php echo $columns_count; ?>" id="<?php echo $s; ?>" class="<?php echo $category; ?>" />
            <input type="hidden" value="<?php echo $category; ?>" />
        </div>
        <?php } } ?>
    </div>
    <input type="hidden" name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][products][categories]" value="<?php if(isset($column_module['products']['categories'])) echo $column_module['products']['categories']; ?>" <?php if($column_module['type'] != 'products') echo 'disabled="disabled"'; ?> />
</div>
</div>
</div>

<div class="input clearfix">
    <p>Image dimension (W x H) and Resize Type:</p>
    <input type="text" name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][products][width]" value="<?php if(isset($column_module['products']['width'])) echo $column_module['products']['width']; ?>" style="width:50px;margin-right: 5px" <?php if($column_module['type'] != 'products') echo 'disabled="disabled"'; ?>>
    <input type="text" name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][products][height]" value="<?php if(isset($column_module['products']['height'])) echo $column_module['products']['height']; ?>" style="width: 50px" <?php if($column_module['type'] != 'products') echo 'disabled="disabled"'; ?>>
</div>

<div class="input clearfix">
    <p>Limit products:</p>
    <input type="text" name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][products][limit]" value="<?php if(isset($column_module['products']['limit'])) echo $column_module['products']['limit']; ?>" style="width: 50px" <?php if($column_module['type'] != 'products') echo 'disabled="disabled"'; ?>>
</div>
</div>

<div class="future_carousel"<?php if($column_module['type'] != 'future_carousel') echo ' style="display: none"';?> >
<div class="input clearfix" style="padding-top:30px">
    <p>Module Template:</p>
    <div class="module-layouts">
        <?php foreach($templates as $template) {
						   	                  if(isset($carousel_templates[$template])) {
						   	                       $i = 0;
						   	                       echo '<div class="module-layout-title">' . $template . '</div>';
    if(!isset($column_module['future_carousel']['module_layout'])) $column_module['future_carousel']['module_layout'] = false;
    foreach($carousel_templates[$template] as $file_template) { ?>
    <div class="module-layout clearfix">
        <input type="radio" name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][future_carousel][module_layout]" value="<?php echo $file_template; ?>" <?php if($column_module['future_carousel']['module_layout'] == $file_template) echo 'checked="checked"'; ?> class="input-module-layout" <?php if($column_module['type'] != 'future_carousel') echo 'disabled="disabled"'; ?>>
        <p><?php echo $file_template; ?></p>
    </div>
    <?php $i++; }
						   	                  }
						   	             } ?>
</div>
<table  id="future_carousel-<?php echo $module_row; ?>-<?php echo $columns_count; ?>-<?php echo $s; ?>" class="table table-striped table-bordered table-hover">
    <thead>
    <tr>
        <td class="text-left">sort</td>
        <td class="text-left">link</td>
        <td class="text-left">image</td>
        <td class="text-right">Detele</td>
        <td></td>
    </tr>
    </thead>
    <tbody>
    <?php if(isset($column_module['future_carousel']['array'])) { foreach ($column_module['future_carousel']['array'] as $carousel) { ?>
    <tbody id="future_carousel-<?php echo $future_image; ?>">
    <tr>
        <td class="first"><div class="list-language">
                <?php foreach ($languages as $language) { ?>
                <div class="language">
                    <img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" alt="<?php echo $language['name']; ?>" width="16px" height="11px" />
                    <input type="text" name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][future_carousel][array][<?php echo $future_image; ?>][sort][<?php echo $language['language_id']; ?>]" value="<?php $language_id = $language['language_id']; if(isset($carousel['sort'][$language_id])) echo $carousel['sort'][$language_id]; ?>">
                </div>
                <?php } ?>
            </div></td>
        <td><input type="text" name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][future_carousel][array][<?php echo $future_image; ?>][link]" value="<?php if(isset($carousel['link'])){ echo $carousel['link'];} ?>" /></td>
        <td>
            <a href="" id="thumb-image<?php echo $future_image?>_image" data-toggle="image" class="img-thumbnail"><img src="<?php if(isset($carousel['show_image'])){  echo $carousel['show_image'];}else{ echo '/image/cache/no_image-100x100.png'; } ?>" alt="" title="" data-placeholder="/image/cache/no_image-100x100.png"></a>
            <input name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][future_carousel][array][<?php echo $future_image; ?>][image]" value="<?php  if(isset($carousel['image'])){ echo $carousel['image'];} ?>" id="input-image<?php echo $future_image?>_image" type="hidden">
        </td>
        <td><a onclick="$('#future_carousel-<?php echo $future_image; ?>').remove();" class="remove-link">Remove</a></td>
    </tr>
    </tbody>
    <?php $future_image++; } } ?>
    <tfoot>
    </tfoot>
</table>
<a onclick="addCarousel(<?php echo $module_row; ?>, <?php echo $columns_count; ?>, <?php echo $s; ?>);" class="add-carousel">Add item</a>
</div>
</div>


<!--333333333333333333333333333start    -->
<div class="future_product"<?php if($column_module['type'] != 'future_product') echo ' style="display: none"';?> >
<div class="input clearfix" style="padding-top:30px">
    <p>Module Template:</p>
    <div class="module-layouts">
        <?php foreach($templates as $template) {
                if(isset($future_product_templates[$template])) {
                    $i = 0;
                    echo '<div class="module-layout-title">' . $template . '</div>';
    if(!isset($column_module['future_product']['module_layout'])) $column_module['future_product']['module_layout'] = false;
    foreach($future_product_templates[$template] as $file_template) { ?>
    <div class="module-layout clearfix">
        <input type="radio" name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][future_product][module_layout]" value="<?php echo $file_template; ?>" <?php if($column_module['future_product']['module_layout'] == $file_template) echo 'checked="checked"'; ?> class="input-module-layout" <?php if($column_module['type'] != 'future_product') echo 'disabled="disabled"'; ?>>
        <p><?php echo $file_template; ?></p>
    </div>
    <?php $i++; }
                }
            } ?>
</div>
<table  id="future_product-<?php echo $module_row; ?>-<?php echo $columns_count; ?>-<?php echo $s; ?>" class="table table-striped table-bordered table-hover">
    <thead>
    <tr>
        <td class="text-left">Product Name</td>
        <td class="text-left">link</td>
        <td class="text-left">image</td>
        <td class="text-right">Detele</td>
        <td></td>
    </tr>
    </thead>
    <tbody>
    <?php if(isset($column_module['future_product']['array'])) { foreach ($column_module['future_product']['array'] as $carousel) { ?>
    <tbody id="future_product-<?php echo $future_product ?>">
    <tr>
        <td class="first"><div class="list-language">
                <?php foreach ($languages as $language) { ?>
                <div class="language">
                    <img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" alt="<?php echo $language['name']; ?>" width="16px" height="11px" />
                    <input type="text" name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][future_product][array][<?php echo $future_product; ?>][product_name][<?php echo $language['language_id']; ?>]" value="<?php $language_id = $language['language_id']; if(isset($carousel['product_name'][$language_id])) echo $carousel['product_name'][$language_id]; ?>">
                </div>
                <?php } ?>
            </div></td>
        <td><input type="text" name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][future_product][array][<?php echo $future_product; ?>][link]" value="<?php if(isset($carousel['link'])){  echo $carousel['link'];} ?>" /></td>
        <td>
            <a href="" id="thumb-image<?php echo $future_product?>_product" data-toggle="image" class="img-thumbnail"><img src="<?php if(isset($carousel['show_image'])){  echo $carousel['show_image'];}else{ echo '/image/cache/no_image-100x100.png'; } ?>" alt="" title="" data-placeholder="/image/cache/no_image-100x100.png"></a>
            <input name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][future_product][array][<?php echo $future_product; ?>][image]" value="<?php if(isset($carousel['image'])){  echo $carousel['image'];}?>" id="input-image<?php echo $future_product?>_product" type="hidden">
            <input name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][future_product][array][<?php echo $future_product; ?>][product_id]" value="<?php if(isset($carousel['product_id'])){  echo $carousel['product_id'];}?>"  type="hidden">
        </td>
        <td><a onclick="$('#future_product-<?php echo $future_product; ?>').remove();" class="remove-product">Remove</a></td>
    </tr>
    </tbody>
    <script>
        $('input[name=\'future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][future_product][array][<?php echo $future_product;?>][product_name][1]\']').autocomplete({
            delay: 500,
            source: function(request, response) {
                $.ajax({
                    url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
                    dataType: 'json',
                    success: function(json) {
                        response($.map(json, function(item) {
                            return {
                                label: item['name'],
                                value: item['product_id']
                            }
                        }));
                    }
                });
            },
            select: function(item) {
                $('input[name=\'future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][future_product][array][<?php echo $future_product;?>][product_name][1]\']').val(item['label']);
                $('input[name=\'future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][future_product][array][<?php echo $future_product;?>][product_id]\']').val(item['value']);
                $.ajax({
                    url: 'index.php?route=module/discover_recommend/product_ajax&token=<?php echo $token; ?>&product_id='+item['value'],
                    dateType: 'json',
                    success:function (json) {
                        var obj = JSON.parse(json);
                        var domain = window.location.host;
                        var url = obj.url.split(domain+'/');
                        obj.url = url[1];
                        $('input[name=\'future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][future_product][array][<?php echo $future_product;?>][link]\']').val(obj.url);
                        $('input[name=\'future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][future_product][array][<?php echo $future_product;?>][image]\']').val(obj.image);
                        var a = $('input[name=\'future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][future_product][array][<?php echo $future_product;?>][image]\']').prev('a').find('img');
                        a.attr("src", obj.image_show);
                    }
                });
                //$('#product-' + module_row + '-' + column + '-' + modules + '-' + modules3 + '-' + item['value']).remove();

                //$('.filter_' + module_row + '_' + column + '_' + modules + '_' + modules3 + '_products .scrollbox').append('<div id="product-' + module_row + '-' + column + '-' + modules + '-' + modules3 + '-' + item['value'] + '">' + item['label'] + '<img src="view/image/module_template/delete-slider.png" alt="' + module_row + '" title="' + column + '" value="' + modules3 + '" id="' + modules + '" class="' + item['value'] + '" /><input type="hidden" value="' + item['value'] + '" /></div>');

                //$('.filter_' + module_row + '_' + column + '_' + modules + '_' + modules3 + '_products .scrollbox div:odd').attr('class', 'odd');
                //$('.filter_' + module_row + '_' + column + '_' + modules + '_' + modules3 + '_products .scrollbox div:even').attr('class', 'even');

                /* data = $.map($('.filter_' + module_row + '_' + column + '_' + modules + '_' + modules3 + '_products .scrollbox input'), function(element){
                 return $(element).attr('value');
                 });*/

                //$('input[name=\'future_home_module[' + module_row + '][column][' + column + '][module][' + modules + '][products_tabs][products][' + modules3 + '][products]\']').attr('value', data.join());

                return false;
            },
            focus: function(event, ui) {
                return false;
            }
        });


    </script>
    <?php $future_product++; } } ?>
    <tfoot>
    </tfoot>
</table>
<a onclick="addFutureProduct(<?php echo $module_row; ?>, <?php echo $columns_count; ?>, <?php echo $s; ?>);" class="add-product">Add item</a>
</div>
</div>

<!--333333333333333333333333333start    -->




<!--111111111111111111start    -->
<div class="future_category"<?php if($column_module['type'] != 'future_category') echo ' style="display: none"';?> >
<div class="input clearfix" style="padding-top:30px">
    <p>Module Template:</p>
    <div class="module-layouts">
        <?php foreach($templates as $template) {
                if(isset($category_templates[$template])) {
                    $i = 0;
                    echo '<div class="module-layout-title">' . $template . '</div>';
    if(!isset($column_module['future_category']['module_layout'])) $column_module['future_category']['module_layout'] = false;
    foreach($category_templates[$template] as $file_template) { ?>
    <div class="module-layout clearfix">
        <input type="radio" name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][future_category][module_layout]" value="<?php echo $file_template; ?>" <?php if($column_module['future_category']['module_layout'] == $file_template) echo 'checked="checked"'; ?> class="input-module-layout" <?php if($column_module['type'] != 'future_category') echo 'disabled="disabled"'; ?>>
        <p><?php echo $file_template; ?></p>
    </div>
    <?php $i++; }
                }
            } ?>
</div>
<table  id="future_category-<?php echo $module_row; ?>-<?php echo $columns_count; ?>-<?php echo $s; ?>" class="table table-striped table-bordered table-hover">
    <thead>
    <tr>
        <td class="text-left">Category Name</td>
        <td class="text-left">SVG</td>
        <td class="text-left">image</td>
        <td class="text-right">Detele</td>
        <td></td>
    </tr>
    </thead>
    <tbody>
    <?php if(isset($column_module['future_category']['array'])) { foreach ($column_module['future_category']['array'] as $carousel) { ?>
    <tbody id="future_category-<?php echo $future_category ?>">
    <tr>
        <td class="first"><div class="list-language">
                <?php foreach ($languages as $language) { ?>
                <div class="language">
                    <img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" alt="<?php echo $language['name']; ?>" width="16px" height="11px" />
                    <input type="text" name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][future_category][array][<?php echo $future_category; ?>][category_name][<?php echo $language['language_id']; ?>]" value="<?php $language_id = $language['language_id']; if(isset($carousel['category_name'][$language_id])) echo $carousel['category_name'][$language_id]; ?>">
                </div>
                <?php } ?>
            </div></td>
        <td><input type="text" name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][future_category][array][<?php echo $future_category; ?>][icon]" value="<?php if(isset($carousel['icon'])){ echo $carousel['icon'];} ?>" /></td>
        <td>
            <a href="" id="thumb-image<?php echo $future_category?>_category" data-toggle="image" class="img-thumbnail"><img src="<?php if(isset($carousel['show_image'])){  echo $carousel['show_image'];}else{ echo '/image/cache/no_image-100x100.png'; } ?>" alt="" title="" data-placeholder="/image/cache/no_image-100x100.png"></a>
            <input name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][future_category][array][<?php echo $future_category; ?>][image]" value="<?php if(isset($carousel['image'])){ echo $carousel['image'];}?>" id="input-image<?php echo $future_category?>_category" type="hidden">
            <input name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][future_category][array][<?php echo $future_category; ?>][category_id]" value="<?php if(isset($carousel['category_id'])){ echo $carousel['category_id'];}?>" type="hidden">
        </td>
        <td><a onclick="$('#future_category-<?php echo $future_category; ?>').remove();" class="remove-category">Remove</a></td>
    </tr>
    </tbody>
    <script>

        $('input[name=\'future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][future_category][array][<?php echo $future_category; ?>][category_name][1]\']').autocomplete({
            delay: 500,
            source: function (request, response) {
                $.ajax({
                    url: 'index.php?route=catalog/product/autoCategory&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
                    dataType: 'json',
                    success: function(json) {
                        response($.map(json, function (item) {
                            return {
                                label: item['name'],
                                value: item['category_id'],
                            }
                        }));
                    }

                });
            },
            select:function (item) {
                $('input[name=\'future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][future_category][array][<?php echo $future_category; ?>][category_name][1]\']').val(item['label']);
                $('input[name=\'future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][future_category][array][<?php echo $future_category; ?>][category_id]\']').val(item['value']);
            }

        });
    </script>
    <?php $future_category++; } } ?>
    <tfoot>
    </tfoot>
</table>
<a onclick="addCategory(<?php echo $module_row; ?>, <?php echo $columns_count; ?>, <?php echo $s; ?>);" class="add-category">Add item</a>
</div>
</div>

<!--1111111111111start    -->


<!----home---->
<div class="future_home"<?php if($column_module['type'] != 'future_home') echo ' style="display: none"';?> >
<div class="input clearfix" style="padding-top:30px">
    <p>Module Template:</p>
    <div class="module-layouts">
        <?php foreach($templates as $template) {
                if(isset($future_templates[$template])) {
                    $i = 0;
                    echo '<div class="module-layout-title">' . $template . '</div>';
    if(!isset($column_module['future_home']['module_layout'])) $column_module['future_home']['module_layout'] = false;
    foreach($future_templates[$template] as $file_template) { ?>
    <div class="module-layout clearfix" <?php if($file_template=="recommend.tpl"){ echo 'style="display:none"';} ?>>
        <input type="radio" name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][future_home][module_layout]" value="<?php echo $file_template; ?>" <?php if($column_module['future_home']['module_layout'] == $file_template) echo 'checked="checked"'; ?> class="input-module-layout" <?php if($column_module['type'] != 'future_home') echo 'disabled="disabled"'; ?>>
        <p><?php echo $file_template; ?></p>
    </div>
    <?php $i++; }
                }
            } ?>
</div>

<div class="input clearfix">
    <p>Module Title:</p>
    <div class="list-language">
        <?php foreach ($languages as $language) { ?>
        <div class="language"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" alt="<?php echo $language['name']; ?>" width="16px" height="11px" /><input type="text" name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][future_home][title][<?php echo $language['language_id']; ?>]" value="<?php $language_id = $language['language_id']; if(isset($column_module['future_home']['title'][$language_id])) echo $column_module['future_home']['title'][$language_id]; ?>" <?php if($column_module['type'] != 'future_home') echo 'disabled="disabled"'; ?>></div>
        <?php } ?>
    </div>
</div>
<table  id="future_home-<?php echo $module_row; ?>-<?php echo $columns_count; ?>-<?php echo $s; ?>" class="table table-striped table-bordered table-hover">
    <thead>
    <tr>
        <td class="text-left">Product </td>
        <td class="text-left">image</td>
        <td class="text-right">Detele</td>
        <td></td>
    </tr>
    </thead>
    <tbody>
    <?php if(isset($column_module['future_home']['array'])) { foreach ($column_module['future_home']['array'] as $carousel) { ?>
    <tbody id="future_home-<?php echo $future_home; ?>">
    <tr>
        <td class="first"><div class="list-language">
                <?php foreach ($languages as $language) { ?>
                <div class="language">
                    <img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" alt="<?php echo $language['name']; ?>" width="16px" height="11px" />
                    <input type="text" name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][future_home][array][<?php echo $future_home; ?>][product_name][<?php echo $language['language_id']; ?>]" value="<?php $language_id = $language['language_id']; if(isset($carousel['product_name'][$language_id])) echo $carousel['product_name'][$language_id]; ?>">
                </div>
                <?php } ?>
            </div></td>
        <td>
            <a href="" id="thumb-image<?php echo $future_home?>_home" data-toggle="image" class="img-thumbnail"><img src="<?php if(isset($carousel['show_image'])){  echo $carousel['show_image'];}else{ echo '/image/cache/no_image-100x100.png'; } ?>" alt="" title="" data-placeholder="/image/cache/no_image-100x100.png"></a>
            <input name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][future_home][array][<?php echo $future_home; ?>][product_image]" value="<?php if(isset($carousel['product_image'])){ echo $carousel['product_image'];}?>" id="input-image<?php echo $future_home?>_home" type="hidden">
            <input name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][future_home][array][<?php echo $future_home; ?>][funding_id]" value="<?php if(isset($carousel['funding_id'])){ echo $carousel['funding_id'];}?>"  type="hidden">
        </td>
        <td><a onclick="$('#future_home-<?php echo $future_home; ?>').remove();" class="remove-link">Remove</a></td>
    </tr>
    </tbody>


    <script>
    $('input[name=\'future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][future_home][array][<?php echo $future_home; ?>][product_name][1]\']').autocomplete({

    delay: 500,
    source: function (request, response) {
    $.ajax({
       url: 'index.php?route=catalog/product/autoFuture&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
       dataType: 'json',
       success: function(json) {
    response($.map(json, function (item) {
       return {
            label: item['name'],
            value: item['funding_id'],
            image: item['image'],
            show_image:item['show_image']
            }
         }));
     }

    });
    },
    select:function (item) {
        $('input[name=\'future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][future_home][array][<?php echo $future_home; ?>][product_name][1]\']').val(item['label']);
        $('input[name=\'future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][future_home][array][<?php echo $future_home; ?>][funding_id]\']').val(item['value']);
        $('input[name=\'future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][future_home][array][<?php echo $future_home; ?>][product_image]\']').val(item['image']);
        var a = $('input[name=\'future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][future_home][array][<?php echo $future_home; ?>][product_image]\']').prev('a').find('img');
        a.attr("src", item['show_image']);
        }

    });

</script>

    <?php $future_home++; } } ?>
    <tfoot>
    </tfoot>
</table>
<a onclick="addFutureHome(<?php echo $module_row; ?>, <?php echo $columns_count; ?>, <?php echo $s; ?>);" class="add-carousel">Add item</a>
</div>
</div>

<!---home--->


<div class="products_tabs"<?php if($column_module['type'] != 'products_tabs') echo ' style="display: none"'; ?>>
<div class="input clearfix" style="padding-top:30px">
    <p>Module Template:</p>
    <div class="module-layouts">
        <?php foreach($templates as $template) {
						   	                  if(isset($products_tabs_templates[$template])) {
						   	                       $i = 0;
						   	                       echo '<div class="module-layout-title">' . $template . '</div>';
    if(!isset($column_module['products_tabs']['module_layout'])) $column_module['products_tabs']['module_layout'] = false;
    foreach($products_tabs_templates[$template] as $file_template) { ?>
    <div class="module-layout clearfix">
        <input type="radio" name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][products_tabs][module_layout]" value="<?php echo $file_template; ?>" <?php if($column_module['products_tabs']['module_layout'] == $file_template) echo 'checked="checked"'; ?> class="input-module-layout" <?php if($column_module['type'] != 'products_tabs') echo 'disabled="disabled"'; ?>>
        <p><?php echo $file_template; ?></p>
    </div>
    <?php $i++; }
						   	                  }
						   	             } ?>
</div>
</div>

<div class="input clearfix">
    <p>Module Title:</p>
    <div class="list-language">
        <?php foreach ($languages as $language) { ?>
        <div class="language"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" alt="<?php echo $language['name']; ?>" width="16px" height="11px" /><input type="text" name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][products_tabs][title][<?php echo $language['language_id']; ?>]" value="<?php $language_id = $language['language_id']; if(isset($column_module['products_tabs']['title'][$language_id])) echo $column_module['products_tabs']['title'][$language_id]; ?>" <?php if($column_module['type'] != 'products_tabs') echo 'disabled="disabled"'; ?>></div>
        <?php } ?>
    </div>
</div>
<div class="input clearfix">
    <p>Module href:</p>
    <div class="list-language">
        <?php foreach ($languages as $language) { ?>
        <div class="language"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" alt="<?php echo $language['name']; ?>" width="16px" height="11px" /><input type="text" name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][products_tabs][href][<?php echo $language['language_id']; ?>]" value="<?php $language_id = $language['language_id']; if(isset($column_module['products_tabs']['href'][$language_id])) echo $column_module['products_tabs']['href'][$language_id]; ?>" <?php if($column_module['type'] != 'products_tabs') echo 'disabled="disabled"'; ?>></div>
        <?php } ?>
    </div>
</div>
<div class="input clearfix">
    <p>Module Description:</p>
    <div class="list-language">
        <?php foreach ($languages as $language) { ?>
        <div class="language"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" alt="<?php echo $language['name']; ?>" width="16px" height="11px" /><input type="text" name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][products_tabs][description][<?php echo $language['language_id']; ?>]" value="<?php $language_id = $language['language_id']; if(isset($column_module['products_tabs']['description'][$language_id])) echo $column_module['products_tabs']['description'][$language_id]; ?>" <?php if($column_module['type'] != 'products_tabs') echo 'disabled="disabled"'; ?>></div>
        <?php } ?>
    </div>
</div>

<div class="input clearfix">
    <p>Image dimension (W x H) and Resize Type:</p>
    <input type="text" name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][products_tabs][width]" value="<?php if(isset($column_module['products_tabs']['width'])) echo $column_module['products_tabs']['width']; ?>" style="width:50px;margin-right: 5px" <?php if($column_module['type'] != 'products_tabs') echo 'disabled="disabled"'; ?>>
    <input type="text" name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][products_tabs][height]" value="<?php if(isset($column_module['products_tabs']['height'])) echo $column_module['products_tabs']['height']; ?>" style="width: 50px" <?php if($column_module['type'] != 'products_tabs') echo 'disabled="disabled"'; ?>>
</div>

<div class="input clearfix">
    <p>Limit products:</p>
    <input type="text" name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][products_tabs][limit]" value="<?php if(isset($column_module['products_tabs']['limit'])) echo $column_module['products_tabs']['limit']; ?>" style="width: 50px" <?php if($column_module['type'] != 'products_tabs') echo 'disabled="disabled"'; ?>>
</div>

<table id="products-tabs-<?php echo $module_row; ?>-<?php echo $columns_count; ?>-<?php echo $s; ?>">
    <thead>
    <tr>
        <td class="first">Title</td>
        <td>Get product from</td>
        <td>Image</td>
        <td>Delete</td>
    </tr>
    </thead>
    <?php if(isset($column_module['products_tabs']['products'])) { foreach ($column_module['products_tabs']['products'] as $product) { ?>
    <tbody id="product-tab-<?php echo $products_tabs; ?>">
    <tr>
        <td class="first"><div class="list-language">
                <?php foreach ($languages as $language) { ?>
                <div class="language">
                    <img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" alt="<?php echo $language['name']; ?>" width="16px" height="11px" />
                    <input type="text" name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][products_tabs][products][<?php echo $products_tabs; ?>][title][<?php echo $language['language_id']; ?>]" value="<?php $language_id = $language['language_id']; if(isset($product['title'][$language_id])) echo $product['title'][$language_id]; ?>" <?php if($column_module['type'] != 'products_tabs') echo 'disabled="disabled"'; ?>>
                </div>
                <?php } ?>
            </div></td>

        <td id="module-<?php echo $module_row; ?>-<?php echo $columns_count; ?>-module-<?php echo $s; ?>-<?php echo $products_tabs; ?>">
            <div class="input clearfix">
                <p>Get products from:</p>
                <div style="float:left;width:425px">
                    <select name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][products_tabs][products][<?php echo $products_tabs; ?>][get_products_from]" class="get-product" id="<?php echo $module_row; ?>-<?php echo $columns_count; ?>-module-<?php echo $s; ?>-<?php echo $products_tabs; ?>" <?php if($column_module['type'] != 'products_tabs') echo 'disabled="disabled"'; ?>>
                    <?php if(!isset($product['get_products_from'])) $product['get_products_from'] = false; ?>
                    <option value="latest"<?php if($product['get_products_from'] == 'latest') echo ' selected="selected"'; ?>>Latest Products</option>
                    <option value="special"<?php if($product['get_products_from'] == 'special') echo ' selected="selected"'; ?>>Special Products</option>
                    <option value="bestsellers"<?php if($product['get_products_from'] == 'bestsellers') echo ' selected="selected"'; ?>>Bestsellers Products</option>
                    <option value="products"<?php if($product['get_products_from'] == 'products') echo ' selected="selected"'; ?>>Choose a products</option>
                    <option value="category"<?php if($product['get_products_from'] == 'category') echo ' selected="selected"'; ?>>Choose a category</option>
                    <option value="random"<?php if($product['get_products_from'] == 'random') echo ' selected="selected"'; ?>>Random products</option>
                    <option value="people_also_bought"<?php if($product['get_products_from'] == 'people_also_bought') echo ' selected="selected"'; ?>>People also bought</option>
                    <option value="related"<?php if($product['get_products_from'] == 'related') echo ' selected="selected"'; ?>>Related products</option>
                    <option value="most_viewed"<?php if($product['get_products_from'] == 'most_viewed') echo ' selected="selected"'; ?>>Most viewed</option>
                    </select>

                    <div class="filter_<?php echo $module_row; ?>_<?php echo $columns_count; ?>_<?php echo $s; ?>_<?php echo $products_tabs; ?>_products panel-products-autocomplete"<?php if($product['get_products_from'] != 'products') echo ' style="display: none"'; ?>>
                    <div class="products-autocomplete clearfix">
                        <p>Products:<br><span style="font-size:11px;color:#808080">(Autocomplete)</span></p>
                        <div><input type="text" alt="<?php echo $module_row; ?>" title="<?php echo $columns_count; ?>" id="<?php echo $s; ?>-<?php echo $products_tabs; ?>" name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][products_tabs][products][<?php echo $products_tabs; ?>][product]" value="" <?php if($column_module['type'] != 'products_tabs') echo 'disabled="disabled"'; ?> /></div>
                    </div>
                    <div class="scrollbox products2">
                        <?php if(!isset($product['products'])) $product['products'] = false; ?>
                        <?php $products = explode(',', $product['products']); ?>
                        <?php $class = 'odd'; ?>
                        <?php foreach ($products as $production) { if($production > 0) { ?>
                        <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                        <?php
						   	            				                              	     	$model_catalog_product = $registry->get('model_catalog_product');
                        $product_info = $model_catalog_product->getProduct($production);
                        $product_name = false;
                        if($product_info) {
                        $product_name = $product_info['name'];
                        }
                        ?>
                        <div id="product-<?php echo $module_row; ?>-<?php echo $columns_count; ?>-<?php echo $s; ?>-<?php echo $products_tabs; ?>-<?php echo $production; ?>" class="<?php echo $class; ?>"><?php echo $product_name; ?> <img src="view/image/module_template/delete-slider.png" alt="<?php echo $module_row; ?>" title="<?php echo $columns_count; ?>" id="<?php echo $s; ?>" value="<?php echo $products_tabs; ?>" class="<?php echo $production; ?>" />
                            <input type="hidden" value="<?php echo $production; ?>" />
                        </div>
                        <?php } } ?>
                    </div>
                    <input type="hidden" name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][products_tabs][products][<?php echo $products_tabs; ?>][products]" value="<?php if(isset($product['products'])) echo $product['products']; ?>" <?php if($column_module['type'] != 'products_tabs') echo 'disabled="disabled"'; ?> />
                </div>

                <div class="filter_<?php echo $module_row; ?>_<?php echo $columns_count; ?>_<?php echo $s; ?>_<?php echo $products_tabs; ?>_categories panel-categories-autocomplete" <?php if($product['get_products_from'] != 'category') echo ' style="display: none"'; ?>>
                <div class="products-autocomplete clearfix">
                    <p>Categories:<br><span style="font-size:11px;color:#808080">(Autocomplete)</span></p>
                    <div><input type="text" alt="<?php echo $module_row; ?>" title="<?php echo $columns_count; ?>" id="<?php echo $s; ?>-<?php echo $products_tabs; ?>" name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][products_tabs][products][<?php echo $products_tabs; ?>][category]" value="" <?php if($column_module['type'] != 'products_tabs') echo 'disabled="disabled"'; ?> /></div>
                </div>
                <div class="scrollbox categories2">
                    <?php if(!isset($product['categories'])) $product['categories'] = false; ?>
                    <?php $categories = explode(',', $product['categories']); ?>
                    <?php $class = 'odd'; ?>
                    <?php foreach ($categories as $category) { if($category > 0) { ?>
                    <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                    <?php
						   	            				                              	     	$model_catalog_category = $registry->get('model_catalog_category');
                    $category_info = $model_catalog_category->getCategory($category);
                    $category_name = false;
                    if($category_info) {
                    $category_name = $category_info['name'];
                    }
                    ?>
                    <div id="category-<?php echo $module_row; ?>-<?php echo $columns_count; ?>-<?php echo $s; ?>-<?php echo $products_tabs; ?>-<?php echo $category; ?>" class="<?php echo $class; ?>"><?php echo $category_name; ?> <img src="view/image/module_template/delete-slider.png" alt="<?php echo $module_row; ?>" title="<?php echo $columns_count; ?>" value="<?php echo $products_tabs; ?>" id="<?php echo $s; ?>" class="<?php echo $category; ?>" />
                        <input type="hidden" value="<?php echo $category; ?>" />
                    </div>
                    <?php } } ?>
                </div>
                <input type="hidden" name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][products_tabs][products][<?php echo $products_tabs; ?>][categories]" value="<?php if(isset($product['categories'])) echo $product['categories']; ?>" <?php if($column_module['type'] != 'products_tabs') echo 'disabled="disabled"'; ?> />
            </div>
            </div>
            </div>
        </td>
        <td>
            <a href="" id="thumb-image<?php echo $products_tabs; ?>" data-toggle="image" class="img-thumbnail"><img width="80px" height="80px" src="<?php $language_id = $language['language_id']; if(isset($product['image'][$language_id]) && $product['image'][$language_id] != ""){ echo "/image/".$product['image'][$language_id]; }else{echo '/image/cache/no_image-100x100.png';}?>" alt="" title="" data-placeholder="<?php $language_id = $language['language_id']; if(isset($product['image'][$language_id]) && $product['image'][$language_id] != ""){ echo "/image/".$product['image'][$language_id]; }else{echo '/image/cache/no_image-100x100.png';}?>"></a>
            <input name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][products_tabs][products][<?php echo $products_tabs; ?>][image][<?php echo $language['language_id']; ?>]" value="<?php $language_id = $language['language_id']; if(isset($product['image'][$language_id])) echo $product['image'][$language_id]; ?>" <?php if($column_module['type'] != 'products_tabs') echo 'disabled="disabled"'; ?> id="input-image<?php echo $products_tabs; ?>" type="hidden">
        </td>
        <td><a onclick="$('#product-tab-<?php echo $products_tabs; ?>').remove();" class="remove-link">Remove</a></td>
    </tr>
    </tbody>

    <script type="text/javascript">
        $('input[name=\'future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][products_tabs][products][<?php echo $products_tabs; ?>][category]\']').autocomplete({
            delay: 500,
            source: function(request, response) {
                $.ajax({
                    url: 'index.php?route=catalog/category/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
                    dataType: 'json',
                    success: function(json) {
                        response($.map(json, function(item) {
                            return {
                                label: item['name'],
                                value: item['category_id']
                            }
                        }));
                    }
                });
            },
            select: function(item) {
                $('#category-<?php echo $module_row; ?>-<?php echo $columns_count; ?>-<?php echo $s; ?>-<?php echo $products_tabs; ?>-' + item['value']).remove();

                $('.filter_<?php echo $module_row; ?>_<?php echo $columns_count; ?>_<?php echo $s; ?>_<?php echo $products_tabs; ?>_categories .scrollbox').append('<div id="category-<?php echo $module_row; ?>-<?php echo $columns_count; ?>-<?php echo $s; ?>-<?php echo $products_tabs; ?>-' + item['value'] + '">' + item['label'] + '<img src="view/image/module_template/delete-slider.png" alt="<?php echo $module_row; ?>" title="<?php echo $columns_count; ?>" id="<?php echo $s; ?>" value="<?php echo $products_tabs; ?>" class="' + item['value'] + '" /><input type="hidden" value="' + item['value'] + '" /></div>');

                $('.filter_<?php echo $module_row; ?>_<?php echo $columns_count; ?>_<?php echo $s; ?>_<?php echo $products_tabs; ?>_categories .scrollbox div:odd').attr('class', 'odd');
                $('.filter_<?php echo $module_row; ?>_<?php echo $columns_count; ?>_<?php echo $s; ?>_<?php echo $products_tabs; ?>_categories .scrollbox div:even').attr('class', 'even');

                data = $.map($('.filter_<?php echo $module_row; ?>_<?php echo $columns_count; ?>_<?php echo $s; ?>_<?php echo $products_tabs; ?>_categories .scrollbox input'), function(element){
                    return $(element).attr('value');
                });

                $('input[name=\'future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][products_tabs][products][<?php echo $products_tabs; ?>][categories]\']').attr('value', data.join());

                return false;
            },
            focus: function(event, ui) {
                return false;
            }
        });

        $('input[name=\'future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][products_tabs][products][<?php echo $products_tabs; ?>][product]\']').autocomplete({
            delay: 500,
            source: function(request, response) {
                $.ajax({
                    url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
                    dataType: 'json',
                    success: function(json) {
                        response($.map(json, function(item) {
                            return {
                                label: item['name'],
                                value: item['product_id']
                            }
                        }));
                    }
                });
            },
            select: function(item) {
                $('#product-<?php echo $module_row; ?>-<?php echo $columns_count; ?>-<?php echo $s; ?>-<?php echo $products_tabs; ?>-' + item['value']).remove();

                $('.filter_<?php echo $module_row; ?>_<?php echo $columns_count; ?>_<?php echo $s; ?>_<?php echo $products_tabs; ?>_products .scrollbox').append('<div id="product-<?php echo $module_row; ?>-<?php echo $columns_count; ?>-<?php echo $s; ?>-<?php echo $products_tabs; ?>-' + item['value'] + '">' + item['label'] + '<img src="view/image/module_template/delete-slider.png" alt="<?php echo $module_row; ?>" title="<?php echo $columns_count; ?>" value="<?php echo $products_tabs; ?>" id="<?php echo $s; ?>" class="' + item['value'] + '" /><input type="hidden" value="' + item['value'] + '" /></div>');

                $('.filter_<?php echo $module_row; ?>_<?php echo $columns_count; ?>_<?php echo $s; ?>_<?php echo $products_tabs; ?>_products .scrollbox div:odd').attr('class', 'odd');
                $('.filter_<?php echo $module_row; ?>_<?php echo $columns_count; ?>_<?php echo $s; ?>_<?php echo $products_tabs; ?>_products .scrollbox div:even').attr('class', 'even');

                data = $.map($('.filter_<?php echo $module_row; ?>_<?php echo $columns_count; ?>_<?php echo $s; ?>_<?php echo $products_tabs; ?>_products .scrollbox input'), function(element){
                    return $(element).attr('value');
                });

                $('input[name=\'future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][products_tabs][products][<?php echo $products_tabs; ?>][products]\']').attr('value', data.join());

                return false;
            },
            focus: function(event, ui) {
                return false;
            }
        });
    </script>
    <?php $products_tabs++; } } ?>
    <tfoot></tfoot>
</table>
<a onclick="addProductTab(<?php echo $module_row; ?>, <?php echo $columns_count; ?>, <?php echo $s; ?>);" class="add-link">Add item</a>
</div>


<div class="collections"<?php if($column_module['type'] != 'collections') echo ' style="display: none"'; ?>>
<div class="input clearfix" style="padding-top:30px">
    <p>Module Template:</p>
    <div class="module-layouts">
        <?php foreach($templates as $template) {
						   	                  if(isset($collection_templates[$template])) {
						   	                       $i = 0;
						   	                       echo '<div class="module-layout-title">' . $template . '</div>';
    if(!isset($column_module['collections']['module_layout'])) $column_module['collections']['module_layout'] = false;
    foreach($collection_templates[$template] as $file_template) { ?>
    <div class="module-layout clearfix">
        <input type="radio" name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][collections][module_layout]" value="<?php echo $file_template; ?>" checked="checked" class="input-module-layout" <?php if($column_module['type'] != 'collections') echo 'disabled="disabled"'; ?>>
        <p><?php echo $file_template; ?></p>
    </div>
    <?php $i++; }
						   	                  }
						   	             } ?>
</div>
</div>

<div class="input clearfix">
    <p>Module Title:</p>
    <div class="list-language">
        <?php foreach ($languages as $language) { ?>
        <div class="language"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" alt="<?php echo $language['name']; ?>" width="16px" height="11px" /><input type="text" name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][collections][title][<?php echo $language['language_id']; ?>]" value="<?php $language_id = $language['language_id']; if(isset($column_module['collections']['title'][$language_id])) echo $column_module['collections']['title'][$language_id]; ?>" <?php if($column_module['type'] != 'collections') echo 'disabled="disabled"'; ?>></div>
        <?php } ?>
    </div>
</div>
<div class="input clearfix">
    <p>Image dimension (W x H) and Resize Type:</p>
    <input type="text" name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][latest_blogs][width]" value="<?php if(isset($column_module['latest_blogs']['width'])) echo $column_module['latest_blogs']['width']; ?>" style="width:50px;margin-right: 5px" <?php if($column_module['type'] != 'collections') echo 'disabled="disabled"'; ?> >
    <input type="text" name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][latest_blogs][height]" value="<?php if(isset($column_module['latest_blogs']['height'])) echo $column_module['latest_blogs']['height']; ?>" style="width: 50px" <?php if($column_module['type'] != 'collections') echo 'disabled="disabled"'; ?> >
</div>


<div class="input clearfix">
    <p>Limit collections:</p>
    <input type="text" name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][collections][limit]" value="<?php if(isset($column_module['collections']['limit'])) echo $column_module['collections']['limit']; ?>" style="width: 50px" <?php if($column_module['type'] != 'collections') echo 'disabled="disabled"'; ?>>
</div>

<table id="collections-<?php echo $module_row; ?>-<?php echo $columns_count; ?>-<?php echo $s; ?>">
    <thead>
    <tr>
        <td class="first">Title</td>
        <td>Get collection from</td>
        <td>Delete</td>
    </tr>
    </thead>
    <?php if(isset($column_module['collections']['collection'])) { foreach ($column_module['collections']['collection'] as $collection) { ?>
    <tbody id="collections-<?php echo $collections; ?>">
    <tr>
        <td class="first"><div class="list-language">
                <?php foreach ($languages as $language) { ?>
                <div class="language">
                    <img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" alt="<?php echo $language['name']; ?>" width="16px" height="11px" />
                    <input type="text" name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][collections][collection][<?php echo $collections; ?>][title][<?php echo $language['language_id']; ?>]" value="<?php $language_id = $language['language_id']; if(isset($collection['title'][$language_id])) echo $collection['title'][$language_id]; ?>" <?php if($column_module['type'] != 'collections') echo 'disabled="disabled"'; ?>>
                </div>
                <?php } ?>
            </div></td>

        <td id="module-<?php echo $module_row; ?>-<?php echo $columns_count; ?>-module-<?php echo $s; ?>-<?php echo $collections; ?>">
            <div class="input clearfix">
                <p>Get collections from:</p>
                <div style="float:left;width:425px">
                    <select name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][collections][collection][<?php echo $collections; ?>][get_products_from]" class="get-collection" id="<?php echo $module_row; ?>-<?php echo $columns_count; ?>-module-<?php echo $s; ?>-<?php echo $collections; ?>" <?php if($column_module['type'] != 'collections') echo 'disabled="disabled"'; ?>>
                    <?php if(!isset($collection['get_products_from'])) $collection['get_products_from'] = false; ?>
                    <option value="popular"<?php if($collection['get_products_from'] == 'popular') echo ' selected="selected"'; ?>>Popular list</option>
                    <option value="collections"<?php if($collection['get_products_from'] == 'collections') echo ' selected="selected"'; ?>>Choose a collections</option>

                    </select>

                    <div class="filter_<?php echo $module_row; ?>_<?php echo $columns_count; ?>_<?php echo $s; ?>_<?php echo $collections; ?>_collections panel-collections-autocomplete"<?php if($collection['get_products_from'] != 'collections') echo ' style="display: none"'; ?>>
                    <div class="collections-autocomplete clearfix">
                        <p>collection:<br><span style="font-size:11px;color:#808080">(Autocomplete)</span></p>
                        <div><input type="text" alt="<?php echo $module_row; ?>" title="<?php echo $columns_count; ?>" id="<?php echo $s; ?>-<?php echo $collections; ?>" name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][collections][collection][<?php echo $collections; ?>][product]" value="" <?php if($column_module['type'] != 'collections') echo 'disabled="disabled"'; ?> /></div>
                    </div>
                    <div class="scrollbox collections">
                        <?php if(!isset($collection['products'])) $collection['products'] = false; ?>
                        <?php $products = explode(',', $collection['products']); ?>
                        <?php $class = 'odd'; ?>
                        <?php foreach ($products as $collection_id) { if($collection_id > 0) { ?>
                        <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                        <?php
						   	            				                              	     	$model_customer_collection = $registry->get('model_catalog_product');
                        $collection_info = $model_customer_collection->getCollection($collection_id);
                        $collection_name = false;
                        if($collection_info) {
                        $collection_name = $collection_info['collection_name']."->".$collection_info['nickname']."->".$collection_info['follow_count'];
                        }
                        ?>
                        <div id="collection-<?php echo $module_row; ?>-<?php echo $columns_count; ?>-<?php echo $s; ?>-<?php echo $collections; ?>-<?php echo $collection_id; ?>" class="<?php echo $class; ?>"><?php echo $collection_name; ?> <img src="view/image/module_template/delete-slider.png" alt="<?php echo $module_row; ?>" title="<?php echo $columns_count; ?>" id="<?php echo $s; ?>" value="<?php echo $collections; ?>" class="<?php echo $collection_id; ?>" />
                            <input type="hidden" value="<?php echo $collection_id; ?>" />
                        </div>
                        <?php } } ?>
                    </div>
                    <input type="hidden" name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][collections][collection][<?php echo $collections; ?>][products]" value="<?php if(isset($collection['products'])) echo $collection['products']; ?>" <?php if($column_module['type'] != 'collections') echo 'disabled="disabled"'; ?> />
                </div>

            </div>
            </div>
        </td>

        <td><a onclick="$('#collections-<?php echo $collections; ?>').remove();" class="remove-link">Remove</a></td>
    </tr>
    </tbody>
    <script>
        $('input[name=\'future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][collections][collection][<?php echo $collections; ?>][product]\']').autocomplete({
            delay: 500,
            source: function(request, response) {
                $.ajax({
                    url: 'index.php?route=customer/collection/autocompleteCollection&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
                    dataType: 'json',
                    success: function(json) {
                        response($.map(json, function(item) {
                            return {
                                label: item['collection_name'],
                                value: item['collection_id']
                            }
                        }));
                    }
                });
            },
            select: function(item) {
                $('#collection-<?php echo $module_row; ?>-<?php echo $columns_count; ?>-<?php echo $s; ?>-<?php echo $collections; ?>-' + item['value']).remove();

                $('.filter_<?php echo $module_row; ?>_<?php echo $columns_count; ?>_<?php echo $s; ?>_<?php echo $collections; ?>_collections .scrollbox').append('<div id="collection-<?php echo $module_row; ?>-<?php echo $columns_count; ?>-<?php echo $s; ?>-<?php echo $collections; ?>-' + item['value'] + '">' + item['label'] + '<img src="view/image/module_template/delete-slider.png" alt="<?php echo $module_row; ?>" title="<?php echo $columns_count; ?>" value="<?php echo $collections; ?>" id="<?php echo $s; ?>" class="' + item['value'] + '" /><input type="hidden" value="' + item['value'] + '" /></div>');

                $('.filter_<?php echo $module_row; ?>_<?php echo $columns_count; ?>_<?php echo $s; ?>_<?php echo $collections; ?>_collections .scrollbox div:odd').attr('class', 'odd');
                $('.filter_<?php echo $module_row; ?>_<?php echo $columns_count; ?>_<?php echo $s; ?>_<?php echo $collections; ?>_collections .scrollbox div:even').attr('class', 'even');

                data = $.map($('.filter_<?php echo $module_row; ?>_<?php echo $columns_count; ?>_<?php echo $s; ?>_<?php echo $collections; ?>_collections .scrollbox input'), function(element){
                    return $(element).attr('value');
                });

                $('input[name=\'future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][collections][collection][<?php echo $collections; ?>][products]\']').attr('value', data.join());


                return false;
            },
            focus: function(event, ui) {
                return false;
            }
        });
    </script>
    <?php $collections++; } } ?>
    <tfoot></tfoot>
</table>
<a onclick="addCollection(<?php echo $module_row; ?>, <?php echo $columns_count; ?>, <?php echo $s; ?>);" class="add-link">Add item</a>
</div>













<div class="newsletter"<?php if($column_module['type'] != 'newsletter') echo ' style="display: none"'; ?>>
<div class="input clearfix" style="padding-top:30px">
    <p>Module Template:</p>
    <div class="module-layouts">
        <?php foreach($templates as $template) {
						   	               if(isset($newsletter_templates[$template])) {
						   	                    $i = 0;
						   	                    echo '<div class="module-layout-title">' . $template . '</div>';
    if(!isset($column_module['newsletter']['module_layout'])) $column_module['newsletter']['module_layout'] = false;
    foreach($newsletter_templates[$template] as $file_template) { ?>
    <div class="module-layout clearfix">
        <input type="radio" name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][newsletter][module_layout]" value="<?php echo $file_template; ?>" <?php if($column_module['newsletter']['module_layout'] == $file_template) echo 'checked="checked"'; ?> class="input-module-layout" <?php if($column_module['type'] != 'newsletter') echo 'disabled="disabled"'; ?>>
        <p><?php echo $file_template; ?></p>
    </div>
    <?php $i++; }
						   	               }
						   	          } ?>
</div>
</div>

<div id="language-newsletter-<?php echo $module_row; ?>-<?php echo $columns_count; ?>-<?php echo $s; ?>" class="htabs">
    <?php foreach ($languages as $language) { ?>
    <a href="#tab-language-newsletter-<?php echo $module_row; ?>-<?php echo $columns_count; ?>-<?php echo $s; ?>-<?php echo $language['language_id']; ?>"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>
    <?php } ?>
</div>

<?php foreach ($languages as $language) { ?>
<div id="tab-language-newsletter-<?php echo $module_row; ?>-<?php echo $columns_count; ?>-<?php echo $s; ?>-<?php echo $language['language_id']; ?>">
    <div class="input clearfix">
        <p>Module Title:</p>
        <input type="text" name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][newsletter][title][<?php echo $language['language_id']; ?>]" value="<?php $language_id = $language['language_id']; if(isset($column_module['newsletter']['title'][$language_id])) echo $column_module['newsletter']['title'][$language_id]; ?>" <?php if($column_module['type'] != 'newsletter') echo 'disabled="disabled"'; ?>>
    </div>

    <div class="input clearfix">
        <p>Module Text:</p>
        <textarea name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][newsletter][text][<?php echo $language['language_id']; ?>]" style="height: 100px" <?php if($column_module['type'] != 'newsletter') echo 'disabled="disabled"'; ?>><?php $language_id = $language['language_id']; if(isset($column_module['newsletter']['text'][$language_id])) echo $column_module['newsletter']['text'][$language_id]; ?></textarea>
    </div>

    <div class="input clearfix">
        <p>Input Placeholder:</p>
        <input type="text" name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][newsletter][input_placeholder][<?php echo $language['language_id']; ?>]" value="<?php $language_id = $language['language_id']; if(isset($column_module['newsletter']['input_placeholder'][$language_id])) echo $column_module['newsletter']['input_placeholder'][$language_id]; ?>" <?php if($column_module['type'] != 'newsletter') echo 'disabled="disabled"'; ?>>
    </div>

    <div class="input clearfix">
        <p>Subscribe button text:</p>
        <input type="text" name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][newsletter][subscribe_text][<?php echo $language['language_id']; ?>]" value="<?php $language_id = $language['language_id']; if(isset($column_module['newsletter']['subscribe_text'][$language_id])) echo $column_module['newsletter']['subscribe_text'][$language_id]; ?>" <?php if($column_module['type'] != 'newsletter') echo 'disabled="disabled"'; ?>>
    </div>

    <div class="input clearfix">
        <p>Unsubscribe button text:</p>
        <input type="text" name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][newsletter][unsubscribe_text][<?php echo $language['language_id']; ?>]" value="<?php $language_id = $language['language_id']; if(isset($column_module['newsletter']['unsubscribe_text'][$language_id])) echo $column_module['newsletter']['unsubscribe_text'][$language_id]; ?>" <?php if($column_module['type'] != 'newsletter') echo 'disabled="disabled"'; ?>>
    </div>
</div>
<?php } ?>
</div>

<div class="latest_blogs"<?php if($column_module['type'] != 'latest_blogs') echo ' style="display: none"'; ?>>

<div class="input clearfix" style="padding-top:30px">
    <p>Module Template:</p>
    <div class="module-layouts">
        <?php foreach($templates as $template) {
						   	               if(isset($latest_blogs_templates[$template])) {
						   	                    $i = 0;
						   	                    echo '<div class="module-layout-title">' . $template . '</div>';
    if(!isset($column_module['latest_blogs']['module_layout'])) $column_module['latest_blogs']['module_layout'] = false;
    foreach($latest_blogs_templates[$template] as $file_template) { ?>
    <div class="module-layout clearfix">
        <input type="radio" name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][latest_blogs][module_layout]" value="<?php echo $file_template; ?>" <?php if($column_module['latest_blogs']['module_layout'] == $file_template) echo 'checked="checked"'; ?> class="input-module-layout" <?php if($column_module['type'] != 'latest_blogs') echo 'disabled="disabled"'; ?>>
        <p><?php echo $file_template; ?></p>
    </div>
    <?php $i++; }
						   	               }
						   	          } ?>
</div>
</div>

<div class="input clearfix">
    <p>Module Title:</p>
    <div class="list-language">
        <?php foreach ($languages as $language) { ?>
        <div class="language"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" alt="<?php echo $language['name']; ?>" width="16px" height="11px" /><input type="text" name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][latest_blogs][title][<?php echo $language['language_id']; ?>]" value="<?php $language_id = $language['language_id']; if(isset($column_module['latest_blogs']['title'][$language_id])) echo $column_module['latest_blogs']['title'][$language_id]; ?>" <?php if($column_module['type'] != 'latest_blogs') echo 'disabled="disabled"'; ?>></div>
        <?php } ?>
    </div>
</div>

<div class="input clearfix">
    <p>Image dimension (W x H) and Resize Type:</p>
    <input type="text" name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][latest_blogs][width]" value="<?php if(isset($column_module['latest_blogs']['width'])) echo $column_module['latest_blogs']['width']; ?>" style="width:50px;margin-right: 5px" <?php if($column_module['type'] != 'latest_blogs') echo 'disabled="disabled"'; ?>>
    <input type="text" name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][latest_blogs][height]" value="<?php if(isset($column_module['latest_blogs']['height'])) echo $column_module['latest_blogs']['height']; ?>" style="width: 50px" <?php if($column_module['type'] != 'latest_blogs') echo 'disabled="disabled"'; ?>>
</div>

<div class="input clearfix">
    <p>Limit blogs:</p>
    <input type="text" name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][latest_blogs][limit]" value="<?php if(isset($column_module['latest_blogs']['limit'])) echo $column_module['latest_blogs']['limit']; ?>" style="width: 50px" <?php if($column_module['type'] != 'latest_blogs') echo 'disabled="disabled"'; ?>>
</div>
</div>

<div class="load_module"<?php if($column_module['type'] != 'load_module') echo ' style="display: none"'; ?>>
<div class="input clearfix">
    <p>Load module:</p>
    <select name="future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][load_module][module]" style="width: 400px" <?php if($column_module['type'] != 'load_module') echo 'disabled="disabled"'; ?>>
    <?php if(!isset($column_module['load_module']['module'])) $column_module['load_module']['module'] = false; ?>
    <?php foreach ($load_modules as $module) { ?>
    <optgroup label="<?php echo $module['name']; ?>">
        <?php foreach ($module['module'] as $module) { ?>
        <option value="<?php echo $module['code']; ?>"<?php if(isset($column_module['load_module']['module'])) { if($module['code'] == $column_module['load_module']['module']) { echo ' selected="selected"'; } } ?>><?php echo $module['name']; ?></option>
        <?php } ?>
    </optgroup>
    <?php } ?>
    </select>
</div>
</div>

</div>
</div>

<script type="text/javascript">
    $('#language-html-<?php echo $module_row; ?>-<?php echo $columns_count; ?>-<?php echo $s; ?> a').tabs();
    $('#language-box-<?php echo $module_row; ?>-<?php echo $columns_count; ?>-<?php echo $s; ?> a').tabs();
    $('#language-newsletter-<?php echo $module_row; ?>-<?php echo $columns_count; ?>-<?php echo $s; ?> a').tabs();

    $('input[name=\'future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][products][category]\']').autocomplete({
        delay: 500,
        source: function(request, response) {
            $.ajax({
                url: 'index.php?route=catalog/category/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
                dataType: 'json',
                success: function(json) {
                    response($.map(json, function(item) {
                        return {
                            label: item['name'],
                            value: item['category_id']
                        }
                    }));
                }
            });
        },
        select: function(item) {
            $('#category-<?php echo $module_row; ?>-<?php echo $columns_count; ?>-<?php echo $s; ?>-' + item['value']).remove();

            $('.filter_<?php echo $module_row; ?>_<?php echo $columns_count; ?>_<?php echo $s; ?>_categories .scrollbox').append('<div id="category-<?php echo $module_row; ?>-<?php echo $columns_count; ?>-<?php echo $s; ?>-' + item['value'] + '">' + item['label'] + '<img src="view/image/module_template/delete-slider.png" alt="<?php echo $module_row; ?>" title="<?php echo $columns_count; ?>" id="<?php echo $s; ?>" class="' + item['value'] + '" /><input type="hidden" value="' + item['value'] + '" /></div>');

            $('.filter_<?php echo $module_row; ?>_<?php echo $columns_count; ?>_<?php echo $s; ?>_categories .scrollbox div:odd').attr('class', 'odd');
            $('.filter_<?php echo $module_row; ?>_<?php echo $columns_count; ?>_<?php echo $s; ?>_categories .scrollbox div:even').attr('class', 'even');

            data = $.map($('.filter_<?php echo $module_row; ?>_<?php echo $columns_count; ?>_<?php echo $s; ?>_categories .scrollbox input'), function(element){
                return $(element).attr('value');
            });

            $('input[name=\'future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][products][categories]\']').attr('value', data.join());

            return false;
        },
        focus: function(event, ui) {
            return false;
        }
    });

    $('input[name=\'future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][products][product]\']').autocomplete({
        delay: 500,
        source: function(request, response) {
            $.ajax({
                url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
                dataType: 'json',
                success: function(json) {
                    response($.map(json, function(item) {
                        return {
                            label: item['name'],
                            value: item['product_id']
                        }
                    }));
                }
            });
        },
        select: function(item) {
            $('#product-<?php echo $module_row; ?>-<?php echo $columns_count; ?>-<?php echo $s; ?>-' + item['value']).remove();

            $('.filter_<?php echo $module_row; ?>_<?php echo $columns_count; ?>_<?php echo $s; ?>_products .scrollbox').append('<div id="product-<?php echo $module_row; ?>-<?php echo $columns_count; ?>-<?php echo $s; ?>-' + item['value'] + '">' + item['label'] + '<img src="view/image/module_template/delete-slider.png" alt="<?php echo $module_row; ?>" title="<?php echo $columns_count; ?>" id="<?php echo $s; ?>" class="' + item['value'] + '" /><input type="hidden" value="' + item['value'] + '" /></div>');

            $('.filter_<?php echo $module_row; ?>_<?php echo $columns_count; ?>_<?php echo $s; ?>_products .scrollbox div:odd').attr('class', 'odd');
            $('.filter_<?php echo $module_row; ?>_<?php echo $columns_count; ?>_<?php echo $s; ?>_products .scrollbox div:even').attr('class', 'even');

            data = $.map($('.filter_<?php echo $module_row; ?>_<?php echo $columns_count; ?>_<?php echo $s; ?>_products .scrollbox input'), function(element){
                return $(element).attr('value');
            });

            $('input[name=\'future_home_module[<?php echo $module_row; ?>][column][<?php echo $columns_count; ?>][module][<?php echo $s; ?>][products][products]\']').attr('value', data.join());

            return false;
        },
        focus: function(event, ui) {
            return false;
        }
    });
</script>
<?php $s++; } } ?>

<div id="module_<?php echo $module_row; ?>_column_<?php echo $columns_count; ?>_modules_add"></div>

<script type="text/javascript">
    $('#module_<?php echo $module_row; ?>_column_<?php echo $columns_count; ?>_modules a').tabs();
</script>

</div>
<?php $columns_count++; } } ?>

</div>

<script type="text/javascript">
    $('#tab-module-<?php echo $module_row; ?>-tabs a').tabs();
</script>
<?php $module_row++; ?>
<?php } ?>
</div>

<!-- Buttons -->
<div class="buttons"><input type="submit" name="button-save" class="button-save" value=""></div>
</div>
</div>
</div>
</form>
</div>
<script type="text/javascript"><!--
    $('.main-tabs a').tabs();
    //--></script>

<script type="text/javascript">
    var links = <?php echo $links; ?>;
    function addLink(module_row, column, modules) {
        html = '<tbody id="link-' + links + '">';
        html += '	<tr>';
        html += '		<td class="first"><div class="list-language">';
    <?php foreach ($languages as $language) { ?>
            html += '			<div class="language">';
            html += '				<img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" alt="<?php echo $language['name']; ?>" width="16px" height="11px" />';
            html += '				<input type="text" name="future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][links][array][' + links + '][name][<?php echo $language['language_id']; ?>]">';
            html += '			</div>';
        <?php } ?>
        html += '		</div></td>';
        html += '		<td><input type="text" name="future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][links][array][' + links + '][url]"></td>';
        html += '		<td><input type="text" class="sort" name="future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][links][array][' + links + '][sort]"></td>';
        html += '		<td><a onclick="$(\'#link-' + links + '\').remove();" class="remove-link">Remove</a></td>';
        html += '	</tr>';
        html += '</tbody>';

        $('#links-' + module_row + '-' + column + '-' + modules + ' tfoot').before(html);
        links++;
    }

    var products_tabs = <?php echo $products_tabs; ?>;
    function addProductTab(module_row, column, modules) {
        html = '<tbody id="product-tab-' + products_tabs + '">';
        html += '	<tr>';
        html += '		<td class="first"><div class="list-language">';
    <?php foreach ($languages as $language) { ?>
            html += '			<div class="language">';
            html += '				<img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" alt="<?php echo $language['name']; ?>" width="16px" height="11px" />';
            html += '				<input type="text" name="future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][products_tabs][products][' + products_tabs + '][title][<?php echo $language['language_id']; ?>]">';
            html += '			</div>';
        <?php } ?>
        html += '		</div></td>';
        html += '		<td id="module-' + module_row + '-' + column + '-module-' + modules + '-' + products_tabs + '">';

        html += '				<div class="input clearfix">';
        html += '					<p>Get products from:</p>';
        html += '					<div style="float:left;width:425px">';
        html += '						<select name="future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][products_tabs][products][' + products_tabs + '][get_products_from]" class="get-product" id="' + module_row + '-' + column + '-module-' + modules + '-' + products_tabs + '">';
        html += '							<option value="latest">Latest Products</option>';
        html += '							<option value="special">Special Products</option>';
        html += '							<option value="bestsellers">Bestsellers Products</option>';
        html += '							<option value="products">Choose a products</option>';
        html += '							<option value="category">Choose a category</option>';
        html += '							<option value="random">Random products</option>';
        html += '							<option value="people_also_bought">People also bought</option>';
        html += '							<option value="related">Related products</option>';
        html += '							<option value="most_viewed">Most viewed</option>';
        html += '						</select>';

        html += '						<div class="filter_' + module_row + '_' + column + '_' + modules + '_' + products_tabs + '_products panel-products-autocomplete" style="display: none">';
        html += '							<div class="products-autocomplete clearfix">';
        html += '								<p>Products:<br><span style="font-size:11px;color:#808080">(Autocomplete)</span></p>';
        html += '									<div><input type="text" alt="' + module_row + '" title="' + column + '" id="' + modules + '-' + products_tabs + '" name="future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][products_tabs][products][' + products_tabs + '][product]" value="" /></div>';
        html += '							</div>';
        html += '							<div class="scrollbox products2"></div>';
        html += '							<input type="hidden" name="future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][products_tabs][products][' + products_tabs + '][products]" value="" />';
        html += '						</div>';

        html += '						<div class="filter_' + module_row + '_' + column + '_' + modules + '_' + products_tabs + '_categories panel-categories-autocomplete" style="display: none">';
        html += '							<div class="products-autocomplete clearfix">';
        html += '								<p>Categories:<br><span style="font-size:11px;color:#808080">(Autocomplete)</span></p>';
        html += '								<div><input type="text" alt="' + module_row + '" title="' + column + '" id="' + modules + '-' + products_tabs + '" name="future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][products_tabs][products][' + products_tabs + '][category]" value="" /></div>';
        html += '							</div>';
        html += '							<div class="scrollbox categories2"></div>';
        html += '							<input type="hidden" name="future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][products_tabs][products][' + products_tabs + '][categories]" value="" />';
        html += '						</div>';
        html += '					</div>';
        html += '				</div>';

        html += '     </td>';
        html += '     <td><a href="" id="thumb-image' + products_tabs + '" data-toggle="image" class="img-thumbnail"><img src="/image/cache/no_image-100x100.png" alt="" title="" data-placeholder="/image/cache/no_image-100x100.png"></a>';
        html += '      <input name="" value="" id="input-image" type="hidden"></td>';
        html += '		<td><a onclick="$(\'#product-tab-' + products_tabs + '\').remove();" class="remove-link">Remove</a></td>';
        html += '	</tr>';
        html += '</tbody>';

        $('#products-tabs-' + module_row + '-' + column + '-' + modules + ' tfoot').before(html);

        var modules3 = products_tabs;

        $('input[name=\'future_home_module[' + module_row + '][column][' + column + '][module][' + modules + '][products_tabs][products][' + modules3 + '][category]\']').autocomplete({
            delay: 500,
            source: function(request, response) {
                $.ajax({
                    url: 'index.php?route=catalog/category/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
                    dataType: 'json',
                    success: function(json) {
                        response($.map(json, function(item) {
                            return {
                                label: item['name'],
                                value: item['category_id']
                            }
                        }));
                    }
                });
            },
            select: function(item) {
                $('#category-' + module_row + '-' + column + '-' + modules + '-' + modules3 + '-' + item['value']).remove();

                $('.filter_' + module_row + '_' + column + '_' + modules + '_' + modules3 + '_categories .scrollbox').append('<div id="category-' + module_row + '-' + column + '-' + modules + '-' + modules3 + '-' + item['value'] + '">' + item['label'] + '<img src="view/image/module_template/delete-slider.png" alt="' + module_row + '" title="' + column + '" id="' + modules + '" value="' + modules3 + '" class="' + item['value'] + '" /><input type="hidden" value="' + item['value'] + '" /></div>');

                $('.filter_' + module_row + '_' + column + '_' + modules + '_' + modules3 + '_categories .scrollbox div:odd').attr('class', 'odd');
                $('.filter_' + module_row + '_' + column + '_' + modules + '_' + modules3 + '_categories .scrollbox div:even').attr('class', 'even');

                data = $.map($('.filter_' + module_row + '_' + column + '_' + modules + '_' + modules3 + '_categories .scrollbox input'), function(element){
                    return $(element).attr('value');
                });

                $('input[name=\'future_home_module[' + module_row + '][column][' + column + '][module][' + modules + '][products_tabs][products][' + modules3 + '][categories]\']').attr('value', data.join());

                return false;
            },
            focus: function(event, ui) {
                return false;
            }
        });

        $('input[name=\'future_home_module[' + module_row + '][column][' + column + '][module][' + modules + '][products_tabs][products][' + modules3 + '][product]\']').autocomplete({
            delay: 500,
            source: function(request, response) {
                $.ajax({
                    url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
                    dataType: 'json',
                    success: function(json) {
                        response($.map(json, function(item) {
                            return {
                                label: item['name'],
                                value: item['product_id']
                            }
                        }));
                    }
                });
            },
            select: function(item) {
                $('#product-' + module_row + '-' + column + '-' + modules + '-' + modules3 + '-' + item['value']).remove();

                $('.filter_' + module_row + '_' + column + '_' + modules + '_' + modules3 + '_products .scrollbox').append('<div id="product-' + module_row + '-' + column + '-' + modules + '-' + modules3 + '-' + item['value'] + '">' + item['label'] + '<img src="view/image/module_template/delete-slider.png" alt="' + module_row + '" title="' + column + '" value="' + modules3 + '" id="' + modules + '" class="' + item['value'] + '" /><input type="hidden" value="' + item['value'] + '" /></div>');

                $('.filter_' + module_row + '_' + column + '_' + modules + '_' + modules3 + '_products .scrollbox div:odd').attr('class', 'odd');
                $('.filter_' + module_row + '_' + column + '_' + modules + '_' + modules3 + '_products .scrollbox div:even').attr('class', 'even');

                data = $.map($('.filter_' + module_row + '_' + column + '_' + modules + '_' + modules3 + '_products .scrollbox input'), function(element){
                    return $(element).attr('value');
                });

                $('input[name=\'future_home_module[' + module_row + '][column][' + column + '][module][' + modules + '][products_tabs][products][' + modules3 + '][products]\']').attr('value', data.join());

                return false;
            },
            focus: function(event, ui) {
                return false;
            }
        });

        products_tabs++;
    }

    var collections = <?php echo $collections; ?>;
    function addCollection(module_row, column, modules) {
        html = '<tbody id="collections-' + collections + '">';
        html += '	<tr>';
        html += '		<td class="first"><div class="list-language">';
    <?php foreach ($languages as $language) { ?>
            html += '			<div class="language">';
            html += '				<img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" alt="<?php echo $language['name']; ?>" width="16px" height="11px" />';
            html += '				<input type="text" name="future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][collections][collection][' + collections + '][title][<?php echo $language['language_id']; ?>]">';
            html += '			</div>';
        <?php } ?>
        html += '		</div></td>';
        html += '		<td id="module-' + module_row + '-' + column + '-module-' + modules + '-' + collections + '">';

        html += '				<div class="input clearfix">';
        html += '					<p>Get products from:</p>';
        html += '					<div style="float:left;width:425px">';
        html += '						<select name="future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][collections][collection][' + collections + '][get_products_from]" class="get-collection" id="' + module_row + '-' + column + '-module-' + modules + '-' + collections + '">';
        html += '							<option value="popular">Popular list</option>';
        html += '							<option value="collections">Choose a collections</option>';
        html += '						</select>';

        html += '						<div class="filter_' + module_row + '_' + column + '_' + modules + '_' + collections + '_collections panel-collections-autocomplete" style="display: none">';
        html += '							<div class="collections-autocomplete clearfix">';
        html += '								<p>collection:<br><span style="font-size:11px;color:#808080">(Autocomplete)</span></p>';
        html += '									<div><input type="text" alt="' + module_row + '" title="' + column + '" id="' + modules + '-' + collections + '" name="future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][collections][collection][' + collections + '][product]" value="" /></div>';
        html += '							</div>';
        html += '							<div class="scrollbox collections"></div>';
        html += '							<input type="hidden" name="future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][collections][collection][' + collections + '][products]" value="" />';
        html += '						</div>';

        html += '					</div>';
        html += '				</div>';

        html += '     </td>';
        html += '		<td><a onclick="$(\'#collections-' + collections + '\').remove();" class="remove-link">Remove</a></td>';
        html += '	</tr>';
        html += '</tbody>';

        $('#collections-' + module_row + '-' + column + '-' + modules + ' tfoot').before(html);


        var modules4 = collections;

        $('input[name=\'future_home_module[' + module_row + '][column][' + column + '][module][' + modules + '][collections][collection]['+modules4+'][product]\']').autocomplete({
            delay: 500,
            source: function(request, response) {
                $.ajax({
                    url: 'index.php?route=customer/collection/autocompleteCollection&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
                    dataType: 'json',
                    success: function(json) {
                        response($.map(json, function(item) {
                            return {
                                label: item['collection_name'],
                                value: item['collection_id']
                            }
                        }));
                    }
                });
            },
            select: function(item) {
                $('#product-' + module_row + '-' + column + '-' + modules + '-' + modules4 + '-' + item['value']).remove();

                $('.filter_' + module_row + '_' + column + '_' + modules + '_' + modules4 + '_collections .scrollbox').append('<div id="product-' + module_row + '-' + column + '-' + modules + '-' + modules4 + '-' + item['value'] + '">' + item['label'] + '<img src="view/image/module_template/delete-slider.png" alt="' + module_row + '" title="' + column + '" value="' + modules4 + '" id="' + modules + '" class="' + item['value'] + '" /><input type="hidden" value="' + item['value'] + '" /></div>');

                $('.filter_' + module_row + '_' + column + '_' + modules + '_' + modules4 + '_collections .scrollbox div:odd').attr('class', 'odd');
                $('.filter_' + module_row + '_' + column + '_' + modules + '_' + modules4 + '_collections .scrollbox div:even').attr('class', 'even');

                data = $.map($('.filter_' + module_row + '_' + column + '_' + modules + '_' + modules4 + '_collections .scrollbox input'), function(element){
                    return $(element).attr('value');
                });

                $('input[name=\'future_home_module[' + module_row + '][column][' + column + '][module][' + modules + '][collections][collection][' + modules4 + '][products]\']').attr('value', data.join());

                return false;
            },
            focus: function(event, ui) {
                return false;
            }
        });

        collections++;
    }





</script>

<script type="text/javascript">
    var modules = <?php echo $modules_count; ?>;
    function addModuleToColumn(module_row, column) {
        html = '<div id="module-' + module_row + '-' + column + '-module-' + modules + '" style="padding-top: 20px">';
        html += '	<div class="status status-off" title="0" rel="module_' + module_row + '_column_' + column + '_module_' + modules + '_status"></div><input name="future_home_module[' + module_row + '][column][' + column + '][module][' + modules + '][status]" value="0" id="module_' + module_row + '_column_' + column + '_module_' + modules + '_status" type="hidden" />';

        html += '		<div class="input clearfix">';
        html += '			<p>Sort:</p>';
        html += '			<input type="text" name="future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][sort]" value="">';
        html += '		</div>';
        html += '		<div class="input clearfix">';
        html += '			<p>Type column:</p>';
        html += '			<select name="future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][type]" class="type-column" id="' + module_row + '-' + column + '-module-' + modules + '">';
       /* html += '				<option value="html">HTML</option>';
        html += '				<option value="box">Box</option>';
        html += '				<option value="links">Links</option>';
        html += '				<option value="products">Products</option>';
        html += '				<option value="products_tabs">Products tabs</option>';
        html += '				<option value="collections">collections</option>';
        html += '				<option value="newsletter">Newsletter</option>';
        html += '				<option value="latest_blogs">Latest blogs</option>';
        html += '				<option value="load_module">Load module</option>';*/
        html += '				<option value="future_home">future home</option>';//carousel
        html += '				<option value="future_carousel">future carousel</option>';//carousel
       // html += '				<option value="future_product">future product</option>';//carousel
        html += '				<option value="future_category">future category</option>';//carousel
        html += '			</select>';
        html += '		</div>';

        html += '		<div class="type-column">';

        html += '			<div class="html" style="display: none">';
        html += '  				<div id="language-html-' + module_row + '-' + column + '-' + modules + '" class="htabs">';
    <?php foreach ($languages as $language) { ?>
            html += '    				<a href="#tab-language-html-'+ module_row + '-' + column +'-' + modules + '-<?php echo $language['language_id']; ?>"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>';
        <?php } ?>
        html += '  				</div>';

    <?php foreach ($languages as $language) { ?>
            html += '				<div id="tab-language-html-' + module_row + '-' + column + '-' + modules + '-<?php echo $language['language_id']; ?>">';
            html += '					<div class="input clearfix">';
            html += '						<p>HTML:</p>';
            html += '						<textarea name="future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][html][<?php echo $language['language_id']; ?>]"></textarea>';
            html += '					</div>';
            html += '				</div>';
        <?php } ?>
        html += '			</div>';

        html += '			<div class="box" style="display: none">';
        html += '  				<div id="language-box-' + module_row + '-' + column + '-' + modules + '" class="htabs">';
    <?php foreach ($languages as $language) { ?>
            html += '    				<a href="#tab-language-box-'+ module_row + '-' + column +'-' + modules + '-<?php echo $language['language_id']; ?>"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>';
        <?php } ?>
        html += '  				</div>';

    <?php foreach ($languages as $language) { ?>
            html += '				<div id="tab-language-box-' + module_row + '-' + column + '-' + modules + '-<?php echo $language['language_id']; ?>">';
            html += '					<div class="input clearfix">';
            html += '						<p>Module Title:</p>';
            html += '						<input type="text" name="future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][module][title][<?php echo $language['language_id']; ?>]" value="">';
            html += '					</div>';

            html += '					<div class="input clearfix">';
            html += '						<p>Module Text:</p>';
            html += '						<textarea name="future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][module][text][<?php echo $language['language_id']; ?>]"></textarea>';
            html += '					</div>';
            html += '				</div>';
        <?php } ?>
        html += '			</div>';

                html += '			<div class="links" style="display: none">';

                html += '				<div class="input clearfix" style="padding-top:30px">';
                html += '					<p>Module Template:</p>';
                html += '					<div class="module-layouts">';
            <?php foreach($templates as $template) {
                    if(isset($links_templates[$template])) {
                        $i = 0;
                        echo 'html += \'<div class="module-layout-title">' . $template . '</div>\';';
                        foreach($links_templates[$template] as $file_template) { ?>
                            html += '                         <div class="module-layout clearfix">';
                            html += '                              <input type="radio" name="future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][links][module_layout]" value="<?php echo $file_template; ?>" <?php if($i == 0) echo 'checked="checked"'; ?> class="input-module-layout">';
                            html += '                              <p><?php echo $file_template; ?></p>';
                            html += '                         </div>';
                        <?php $i++; }
                    }
                } ?>
                html += '					</div>';
                html += '				</div>';

                html += '				<div class="input clearfix">';
                html += '					<p>Module Title:</p>';
                html += '					<div class="list-language">';
            <?php foreach ($languages as $language) { ?>
                    html += '						<div class="language"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" alt="<?php echo $language['name']; ?>" width="16px" height="11px" /><input type="text" name="future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][links][title][<?php echo $language['language_id']; ?>]" value=""></div>';
                <?php } ?>
                html += '					</div>';
                html += '				</div>';

                html += '				<div class="input clearfix" style="border:none">';
                html += '					<p>Max links in one column:</p>';
                html += '					<input type="text" name="future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][links][limit]" value="5" style="width: 50px">';
                html += '				</div>';

                html += '				<table id="links-' + module_row + '-' + column + '-' + modules + '">';
                html += '					<thead>';
                html += '						<tr>';
                html += '							<td class="first">Name</td>';
                html += '							<td>Link</td>';
                html += '							<td>Sort</td>';
                html += '							<td>Delete</td>';
                html += '						</tr>';
                html += '					</thead>';
                html += '					<tfoot></tfoot>';
                html += '				</table>';
                html += '				<a onclick="addLink(' + module_row + ', ' + column + ', ' + modules + ');" class="add-link">Add item</a>';
                html += '			</div>';

                html += '			<div class="products" style="display: none">';

                html += '				<div class="input clearfix" style="padding-top:30px">';
                html += '					<p>Module Template:</p>';
                html += '					<div class="module-layouts">';
            <?php foreach($templates as $template) {
                    if(isset($products_templates[$template])) {
                        $i = 0;
                        echo 'html += \'<div class="module-layout-title">' . $template . '</div>\';';
                        foreach($products_templates[$template] as $file_template) { ?>
                            html += '                         <div class="module-layout clearfix">';
                            html += '                              <input type="radio" name="future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][products][module_layout]" value="<?php echo $file_template; ?>" <?php if($i == 0) echo 'checked="checked"'; ?> class="input-module-layout">';
                            html += '                              <p><?php echo $file_template; ?></p>';
                            html += '                         </div>';
                        <?php $i++; }
            }
        } ?>
        html += '					</div>';
        html += '				</div>';

        html += '				<div class="input clearfix">';
        html += '					<p>Module Title:</p>';
        html += '					<div class="list-language">';
    <?php foreach ($languages as $language) { ?>
            html += '						<div class="language"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" alt="<?php echo $language['name']; ?>" width="16px" height="11px" /><input type="text" name="future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][products][title][<?php echo $language['language_id']; ?>]" value=""></div>';
        <?php } ?>
        html += '					</div>';
        html += '				</div>';

        html += '				<div class="input clearfix">';
        html += '					<p>Get products from:</p>';
        html += '					<div style="float:left;width:425px">';
        html += '						<select name="future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][products][get_products_from]" class="get-product" id="' + module_row + '-' + column + '-module-' + modules + '">';
        html += '							<option value="latest">Latest Products</option>';
        html += '							<option value="special">Special Products</option>';
        html += '							<option value="bestsellers">Bestsellers Products</option>';
        html += '							<option value="products">Choose a products</option>';
        html += '							<option value="category">Choose a category</option>';
        html += '							<option value="random">Random products</option>';
        html += '							<option value="people_also_bought">People also bought</option>';
        html += '							<option value="related">Related products</option>';
        html += '							<option value="most_viewed">Most viewed</option>';
        html += '						</select>';

        html += '						<div class="filter_' + module_row + '_' + column + '_' + modules + '_products panel-products-autocomplete" style="display: none">';
        html += '							<div class="products-autocomplete clearfix">';
        html += '								<p>Products:<br><span style="font-size:11px;color:#808080">(Autocomplete)</span></p>';
        html += '									<div><input type="text" alt="' + module_row + '" title="' + column + '" id="' + modules + '" name="future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][products][product]" value="" /></div>';
        html += '							</div>';
        html += '							<div class="scrollbox products"></div>';
        html += '							<input type="hidden" name="future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][products][products]" value="" />';
        html += '						</div>';

        html += '						<div class="filter_' + module_row + '_' + column + '_' + modules + '_categories panel-categories-autocomplete" style="display: none">';
        html += '							<div class="products-autocomplete clearfix">';
        html += '								<p>Categories:<br><span style="font-size:11px;color:#808080">(Autocomplete)</span></p>';
        html += '								<div><input type="text" alt="' + module_row + '" title="' + column + '" id="' + modules + '" name="future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][products][category]" value="" /></div>';
        html += '							</div>';
        html += '							<div class="scrollbox categories"></div>';
        html += '							<input type="hidden" name="future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][products][categories]" value="" />';
        html += '						</div>';
        html += '					</div>';
        html += '				</div>';

        html += '				<div class="input clearfix">';
        html += '					<p>Image dimension (W x H) and Resize Type:</p>';
        html += '					<input type="text" name="future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][products][width]" value="80" style="width:50px;margin-right: 5px">';
        html += '					<input type="text" name="future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][products][height]" value="80" style="width: 50px">';
        html += '				</div>';

        html += '				<div class="input clearfix">';
        html += '					<p>Limit products:</p>';
        html += '					<input type="text" name="future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][products][limit]" value="3" style="width: 50px">';
        html += '				</div>';
        html += '			</div>';

        html += '			<div class="products_tabs" style="display: none">';

        html += '				<div class="input clearfix" style="padding-top:30px">';
        html += '					<p>Module Template:</p>';
        html += '					<div class="module-layouts">';
    <?php foreach($templates as $template) {
            if(isset($products_tabs_templates[$template])) {
                $i = 0;
                echo 'html += \'<div class="module-layout-title">' . $template . '</div>\';';
                foreach($products_tabs_templates[$template] as $file_template) { ?>
                    html += '                         <div class="module-layout clearfix">';
                    html += '                              <input type="radio" name="future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][products_tabs][module_layout]" value="<?php echo $file_template; ?>" <?php if($i == 0) echo 'checked="checked"'; ?> class="input-module-layout">';
                    html += '                              <p><?php echo $file_template; ?></p>';
                    html += '                         </div>';
                <?php $i++; }
            }
        } ?>
        html += '					</div>';
        html += '				</div>';

        html += '				<div class="input clearfix">';
        html += '					<p>Module Title:</p>';
        html += '					<div class="list-language">';
    <?php foreach ($languages as $language) { ?>
            html += '						<div class="language"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" alt="<?php echo $language['name']; ?>" width="16px" height="11px" /><input type="text" name="future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][products_tabs][title][<?php echo $language['language_id']; ?>]" value=""></div>';
        <?php } ?>
        html += '					</div>';
        html += '				</div>';

        html += '				<div class="input clearfix">';
        html += '					<p>Module Description:</p>';
        html += '					<div class="list-language">';
    <?php foreach ($languages as $language) { ?>
            html += '						<div class="language"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" alt="<?php echo $language['name']; ?>" width="16px" height="11px" /><input type="text" name="future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][products_tabs][description][<?php echo $language['language_id']; ?>]" value=""></div>';
        <?php } ?>
        html += '					</div>';
        html += '				</div>';

        html += '				<div class="input clearfix">';
        html += '					<p>Image dimension (W x H) and Resize Type:</p>';
        html += '					<input type="text" name="future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][products_tabs][width]" value="80" style="width:50px;margin-right: 5px">';
        html += '					<input type="text" name="future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][products_tabs][height]" value="80" style="width: 50px">';
        html += '				</div>';

        html += '				<div class="input clearfix">';
        html += '					<p>Limit products:</p>';
        html += '					<input type="text" name="future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][products_tabs][limit]" value="3" style="width: 50px">';
        html += '				</div>';

        html += '				<table id="products-tabs-' + module_row + '-' + column + '-' + modules + '">';
        html += '					<thead>';
        html += '						<tr>';
        html += '							<td class="first">Title</td>';
        html += '							<td>Get product from</td>';
        html += '							<td>Image</td>';
        html += '							<td>Delete</td>';
        html += '						</tr>';
        html += '					</thead>';
        html += '					<tfoot></tfoot>';
        html += '				</table>';
        html += '				<a onclick="addProductTab(' + module_row + ', ' + column + ', ' + modules + ');" class="add-link">Add item</a>';

        html += '			</div>';




        html += '			<div class="collections" style="display: none">';

        html += '				<div class="input clearfix" style="padding-top:30px">';
        html += '					<p>Module Template:</p>';
        html += '					<div class="module-layouts">';
    <?php foreach($templates as $template) {
            if(isset($collection_templates[$template])) {
                $i = 0;
                echo 'html += \'<div class="module-layout-title">' . $template . '</div>\';';
                foreach($collection_templates[$template] as $file_template) { ?>
                    html += '                         <div class="module-layout clearfix">';
                    html += '                              <input type="radio" name="future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][collections][module_layout]" value="<?php echo $file_template; ?>" <?php if($i == 0) echo 'checked="checked"'; ?> class="input-module-layout">';
                    html += '                              <p><?php echo $file_template; ?></p>';
                    html += '                         </div>';
                <?php $i++; }
            }
        } ?>
        html += '					</div>';
        html += '				</div>';

        html += '				<div class="input clearfix">';
        html += '					<p>Module Title:</p>';
        html += '					<div class="list-language">';
    <?php foreach ($languages as $language) { ?>
            html += '						<div class="language"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" alt="<?php echo $language['name']; ?>" width="16px" height="11px" /><input type="text" name="future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][collections][title][<?php echo $language['language_id']; ?>]" value=""></div>';
        <?php } ?>
        html += '					</div>';
        html += '				</div>';

        html += '				<div class="input clearfix">';
        html += '					<p>Image dimension (W x H) and Resize Type:</p>';
        html += '					<input type="text" name="future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][latest_blogs][width]" value="80" style="width:50px;margin-right: 5px">';
        html += '					<input type="text" name="future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][latest_blogs][height]" value="80" style="width: 50px">';
        html += '				</div>';

        html += '				<div class="input clearfix">';
        html += '					<p>Limit collections:</p>';
        html += '					<input type="text" name="future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][collections][limit]" value="3" style="width: 50px">';
        html += '				</div>';

        html += '				<table id="collections-' + module_row + '-' + column + '-' + modules + '">';
        html += '					<thead>';
        html += '						<tr>';
        html += '							<td class="first">Title</td>';
        html += '							<td>Get collections from</td>';
        html += '							<td>Delete</td>';
        html += '						</tr>';
        html += '					</thead>';
        html += '					<tfoot></tfoot>';
        html += '				</table>';
        html += '				<a onclick="addCollection(' + module_row + ', ' + column + ', ' + modules + ');" class="add-link">Add item</a>';

        html += '			</div>';
        //********写入future
        html += '			<div class="future_home">';

        html += '				<div class="input clearfix" style="padding-top:30px">';
        html += '					<p>Module Template:</p>';
        html += '					<div class="module-layouts">';
    <?php foreach($templates as $template) {
            if(isset($future_templates[$template])) {
                $i = 0;
                echo 'html += \'<div class="module-layout-title">' . $template . '</div>\';';
                foreach($future_templates[$template] as $file_template) { ?>
                    html += '                         <div class="module-layout clearfix" <?php if($file_template=="recommend.tpl") echo 'style="display:none"'; ?> >';
                    html += '                              <input type="radio" onclick="take_radio_value(this.value)" name="future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][future_home][module_layout]" value="<?php echo $file_template; ?>" <?php if($i == 0) echo 'checked="checked"'; ?> class="input-module-layout">';
                    html += '                              <p><?php echo $file_template; ?></p>';
                    html += '                         </div>';
                <?php $i++; }
            }
        } ?>
        html += '					</div>';
        html += '				</div>';

        html += '				<div class="input clearfix">';
        html += '					<p>Module Title:</p>';
        html += '					<div class="list-language">';
    <?php foreach ($languages as $language) { ?>
            html += '						<div class="language"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" alt="<?php echo $language['name']; ?>" width="16px" height="11px" /><input type="text" name="future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][future_home][title][<?php echo $language['language_id']; ?>]" value=""></div>';
        <?php } ?>
        html += '					</div>';
        html += '				</div>';

        //html += '				<div class="input clearfix">';
        //html += '					<p>Image dimension (W x H) and Resize Type:</p>';
        //html += '					<input type="text" name="future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][latest_blogs][width]" value="80" style="width:50px;margin-right: 5px">';
        //html += '					<input type="text" name="future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][latest_blogs][height]" value="80" style="width: 50px">';
        //html += '				</div>';

        //html += '				<div class="input clearfix">';
        //html += '					<p>Limit collections:</p>';
        //html += '					<input type="text" name="future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][collections][limit]" value="3" style="width: 50px">';
        //html += '				</div>';

        html += '				<table id="future_home-' + module_row + '-' + column + '-' + modules + '">';
        html += '					<thead>';
        html += '						<tr>';
        html += '							<td id="name_serarch" class="first">Product Name</td>';
        html += '							<td>Reference Picture</td>';
        html += '							<td>Delete</td>';
        html += '						</tr>';
        html += '					</thead>';
        html += '					<tfoot></tfoot>';
        html += '				</table>';
        html += '				<a onclick="addFutureHome(' + module_row + ', ' + column + ', ' + modules + ');" class="add-future">Add item</a>';
        html += '			</div>';

        //**********second
        html += '			<div class="future_carousel" style="display: none">';
        html += '				<div class="input clearfix" style="padding-top:30px">';
        html += '					<p>Module Template:</p>';
        html += '					<div class="module-layouts">';
        <?php foreach($templates as $template) {
            if(isset($carousel_templates[$template])) {
                $i = 0;
                echo 'html += \'<div class="module-layout-title">' . $template . '</div>\';';
                foreach($carousel_templates[$template] as $file_template) { ?>
                    html += '                         <div class="module-layout clearfix">';
                    html += '                              <input type="radio" name="future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][future_carousel][module_layout]" value="<?php echo $file_template; ?>" <?php if($i == 0) echo 'checked="checked"'; ?> class="input-module-layout">';
                    html += '                              <p><?php echo $file_template; ?></p>';
                    html += '                         </div>';
                <?php $i++; }
            }
                 } ?>
        html += '</div>';
        html += '				</div><div>';
        html += '<p>Carousel Setting</p>';
        html += '				<table id="future_carousel-' + module_row + '-' + column + '-' + modules + '">';
        html += '					<thead>';
        html += '						<tr>';
        html += '							<td class="first">Sort</td>';
        html += '							<td>Link</td>';
        html += '							<td>Image</td>';
        html += '							<td>Delete</td>';
        html += '						</tr>';
        html += '					</thead>';
        html += '					<tfoot></tfoot>';
        html += '				</table>';
        html += '				<a onclick="addCarousel(' + module_row + ', ' + column + ', ' + modules + ');" class="add-carousel">Add item</a>';
        html += '			</div>';
        html += '			</div>';


        //**********333333
        html += '			<div class="future_product" style="display: none">';
        html += '				<div class="input clearfix" style="padding-top:30px">';
        html += '					<p>Module Template:</p>';
        html += '					<div class="module-layouts">';
    <?php foreach($templates as $template) {
            if(isset($future_product_templates[$template])) {
                $i = 0;
                echo 'html += \'<div class="module-layout-title">' . $template . '</div>\';';
                foreach($future_product_templates[$template] as $file_template) { ?>
                    html += '                         <div class="module-layout clearfix">';
                    html += '                              <input type="radio" name="future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][future_product][module_layout]" value="<?php echo $file_template; ?>" <?php if($i == 0) echo 'checked="checked"'; ?> class="input-module-layout">';
                    html += '                              <p><?php echo $file_template; ?></p>';
                    html += '                         </div>';
                <?php $i++; }
            }
        } ?>
        html += '</div>';
        html += '				</div><div>';
        html += '<p>Product Setting</p>';
        html += '				<table id="future_product-' + module_row + '-' + column + '-' + modules + '">';
        html += '					<thead>';
        html += '						<tr>';
        html += '							<td class="first">Name Product</td>';
        html += '							<td>Link</td>';
        html += '							<td>Image</td>';
        html += '							<td>Delete</td>';
        html += '						</tr>';
        html += '					</thead>';
        html += '					<tfoot></tfoot>';
        html += '				</table>';
        html += '				<a onclick="addFutureProduct(' + module_row + ', ' + column + ', ' + modules + ');" class="add-product">Add item</a>';
        html += '			</div>';
        html += '			</div>';

        //------------------------------------
        html += '			<div class="future_category" style="display: none">';
        html += '				<div class="input clearfix" style="padding-top:30px">';
        html += '					<p>Module Template:</p>';
        html += '					<div class="module-layouts">';
    <?php foreach($templates as $template) {
            if(isset($category_templates[$template])) {
                $i = 0;
                echo 'html += \'<div class="module-layout-title">' . $template . '</div>\';';
                foreach($category_templates[$template] as $file_template) { ?>
                    html += '                         <div class="module-layout clearfix">';
                    html += '                              <input type="radio" name="future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][future_category][module_layout]" value="<?php echo $file_template; ?>" <?php if($i == 0) echo 'checked="checked"'; ?> class="input-module-layout">';
                    html += '                              <p><?php echo $file_template; ?></p>';
                    html += '                         </div>';
                <?php $i++; }
            }
        } ?>
        html += '</div>';
        html += '				</div><div>';
        html += '<p>Product Setting</p>';
        html += '				<table id="future_category-' + module_row + '-' + column + '-' + modules + '">';
        html += '					<thead>';
        html += '						<tr>';
        html += '							<td class="first">Name Category</td>';
        html += '							<td>SVG</td>';
        html += '							<td>Image</td>';
        html += '							<td>Delete</td>';
        html += '						</tr>';
        html += '					</thead>';
        html += '					<tfoot></tfoot>';
        html += '				</table>';
        html += '				<a onclick="addCategory(' + module_row + ', ' + column + ', ' + modules + ');" class="add-category">Add item</a>';
        html += '			</div>';
        html += '			</div>';



        html += '			<div class="newsletter" style="display: none">';
        html += '				<div class="input clearfix" style="padding-top:30px">';
        html += '					<p>Module Template:</p>';
        html += '					<div class="module-layouts">';
    <?php foreach($templates as $template) {
            if(isset($newsletter_templates[$template])) {
                $i = 0;
                echo 'html += \'<div class="module-layout-title">' . $template . '</div>\';';
                foreach($newsletter_templates[$template] as $file_template) { ?>
                    html += '                         <div class="module-layout clearfix">';
                    html += '                              <input type="radio" name="future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][newsletter][module_layout]" value="<?php echo $file_template; ?>" <?php if($i == 0) echo 'checked="checked"'; ?> class="input-module-layout">';
                    html += '                              <p><?php echo $file_template; ?></p>';
                    html += '                         </div>';
                <?php $i++; }
            }
        } ?>
        html += '					</div>';
        html += '				</div>';

        html += '  			<div id="language-newsletter-' + module_row + '-' + column + '-' + modules + '" class="htabs">';
    <?php foreach ($languages as $language) { ?>
            html += '    				<a href="#tab-language-newsletter-'+ module_row + '-' + column +'-' + modules + '-<?php echo $language['language_id']; ?>"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>';
        <?php } ?>
        html += '  			</div>';

    <?php foreach ($languages as $language) { ?>
            html += '				<div id="tab-language-newsletter-' + module_row + '-' + column + '-' + modules + '-<?php echo $language['language_id']; ?>">';
            html += '					<div class="input clearfix">';
            html += '						<p>Module Title:</p>';
            html += '						<input type="text" name="future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][newsletter][title][<?php echo $language['language_id']; ?>]" value="">';
            html += '					</div>';

            html += '					<div class="input clearfix">';
            html += '						<p>Module Text:</p>';
            html += '						<textarea name="future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][newsletter][text][<?php echo $language['language_id']; ?>]" style="height: 100px"></textarea>';
            html += '					</div>';

            html += '					<div class="input clearfix">';
            html += '						<p>Input Placeholder:</p>';
            html += '						<input type="text" name="future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][newsletter][input_placeholder][<?php echo $language['language_id']; ?>]" value="">';
            html += '					</div>';

            html += '					<div class="input clearfix">';
            html += '						<p>Subscribe button text:</p>';
            html += '						<input type="text" name="future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][newsletter][subscribe_text][<?php echo $language['language_id']; ?>]" value="">';
            html += '					</div>';

            html += '					<div class="input clearfix">';
            html += '						<p>Unsubscribe button text:</p>';
            html += '						<input type="text" name="future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][newsletter][unsubscribe_text][<?php echo $language['language_id']; ?>]" value="">';
            html += '					</div>';
            html += '				</div>';
        <?php } ?>
        html += '			</div>';

        html += '			<div class="latest_blogs" style="display: none">';

        html += '				<div class="input clearfix" style="padding-top:30px">';
        html += '					<p>Module Template:</p>';
        html += '					<div class="module-layouts">';
    <?php foreach($templates as $template) {
            if(isset($latest_blogs_templates[$template])) {
                $i = 0;
                echo 'html += \'<div class="module-layout-title">' . $template . '</div>\';';
                foreach($latest_blogs_templates[$template] as $file_template) { ?>
                    html += '                         <div class="module-layout clearfix">';
                    html += '                              <input type="radio" name="future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][latest_blogs][module_layout]" value="<?php echo $file_template; ?>" <?php if($i == 0) echo 'checked="checked"'; ?> class="input-module-layout">';
                    html += '                              <p><?php echo $file_template; ?></p>';
                    html += '                         </div>';
                <?php $i++; }
            }
        } ?>
        html += '					</div>';
        html += '				</div>';

        html += '				<div class="input clearfix">';
        html += '					<p>Module Title:</p>';
        html += '					<div class="list-language">';
    <?php foreach ($languages as $language) { ?>
            html += '						<div class="language"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" alt="<?php echo $language['name']; ?>" width="16px" height="11px" /><input type="text" name="future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][latest_blogs][title][<?php echo $language['language_id']; ?>]" value=""></div>';
        <?php } ?>
        html += '					</div>';
        html += '				</div>';

        html += '				<div class="input clearfix">';
        html += '					<p>Image dimension (W x H) and Resize Type:</p>';
        html += '					<input type="text" name="future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][latest_blogs][width]" value="80" style="width:50px;margin-right: 5px">';
        html += '					<input type="text" name="future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][latest_blogs][height]" value="80" style="width: 50px">';
        html += '				</div>';

        html += '				<div class="input clearfix">';
        html += '					<p>Limit blogs:</p>';
        html += '					<input type="text" name="future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][latest_blogs][limit]" value="3" style="width: 50px">';
        html += '				</div>';
        html += '			</div>';

        html += '			<div class="load_module" style="display: none">';
        html += '		          <div class="input clearfix">';
        html += '			          <p>Load module:</p>';
        html += '			          <select name="future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][load_module][module]" style="width: 400px">';

    <?php foreach ($load_modules as $module) { ?>
            html += '                         <optgroup label="<?php echo $module['name']; ?>">';
        <?php foreach ($module['module'] as $module) { ?>
                html += '                              <option value="<?php echo $module['code']; ?>"><?php echo $module['name']; ?></option>';
            <?php } ?>
            html += '                         </optgroup>';
        <?php } ?>

        html += '			          </select>';
        html += '		          </div>';
        html += '			</div>';

        html += '		</div>';
        html += '</div>';

        $('#module_' + module_row + '_column_' + column + '_modules > img').before('<a href="#module-' + module_row + '-' + column + '-module-' + modules + '" id="element-' + modules + '">' + modules + ' &nbsp;<img src="view/image/module_template/delete-slider.png" alt="" onclick="$(\'#element-' + modules + '\').remove(); $(\'#module-' + module_row + '-' + column + '-module-' + modules + '\').remove(); return false;" /></a>');

        $('#module_' + module_row + '_column_' + column + '_modules_add').before(html);
        $('#module_' + module_row + '_column_' + column + '_modules a').tabs();
        $('#language-html-' + module_row + '-' + column + '-' + modules + ' a').tabs();
        $('#language-box-' + module_row + '-' + column + '-' + modules + ' a').tabs();
        $('#language-newsletter-' + module_row + '-' + column + '-' + modules + ' a').tabs();
        $('#element-' + modules).trigger('click');

        var modules2 = modules;

        $('input[name=\'future_home_module[' + module_row + '][column][' + column + '][module][' + modules2 + '][products][category]\']').autocomplete({
            delay: 500,
            source: function(request, response) {
                $.ajax({
                    url: 'index.php?route=catalog/category/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
                    dataType: 'json',
                    success: function(json) {
                        response($.map(json, function(item) {
                            return {
                                label: item['name'],
                                value: item['category_id']
                            }
                        }));
                    }
                });
            },
            select: function(item) {
                $('#category-' + module_row + '-' + column + '-' + modules2 + '-' + item['value']).remove();

                $('.filter_' + module_row + '_' + column + '_' + modules2 + '_categories .scrollbox').append('<div id="category-' + module_row + '-' + column + '-' + modules2 + '-' + item['value'] + '">' + item['label'] + '<img src="view/image/module_template/delete-slider.png" alt="' + module_row + '" title="' + column + '" id="' + modules2 + '" class="' + item['value'] + '" /><input type="hidden" value="' + item['value'] + '" /></div>');

                $('.filter_' + module_row + '_' + column + '_' + modules2 + '_categories .scrollbox div:odd').attr('class', 'odd');
                $('.filter_' + module_row + '_' + column + '_' + modules2 + '_categories .scrollbox div:even').attr('class', 'even');

                data = $.map($('.filter_' + module_row + '_' + column + '_' + modules2 + '_categories .scrollbox input'), function(element){
                    return $(element).attr('value');
                });

                $('input[name=\'future_home_module[' + module_row + '][column][' + column + '][module][' + modules2 + '][products][categories]\']').attr('value', data.join());

                return false;
            },
            focus: function(event, ui) {
                return false;
            }
        });

        $('input[name=\'future_home_module[' + module_row + '][column][' + column + '][module][' + modules2 + '][products][product]\']').autocomplete({
            delay: 500,
            source: function(request, response) {
                $.ajax({
                    url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
                    dataType: 'json',
                    success: function(json) {
                        response($.map(json, function(item) {
                            return {
                                label: item['name'],
                                value: item['product_id']
                            }
                        }));
                    }
                });
            },
            select: function(item) {
                $('#product-' + module_row + '-' + column + '-' + modules2 + '-' + item['value']).remove();

                $('.filter_' + module_row + '_' + column + '_' + modules2 + '_products .scrollbox').append('<div id="product-' + module_row + '-' + column + '-' + modules2 + '-' + item['value'] + '">' + item['label'] + '<img src="view/image/module_template/delete-slider.png" alt="' + module_row + '" title="' + column + '" id="' + modules2 + '" class="' + item['value'] + '" /><input type="hidden" value="' + item['value'] + '" /></div>');

                $('.filter_' + module_row + '_' + column + '_' + modules2 + '_products .scrollbox div:odd').attr('class', 'odd');
                $('.filter_' + module_row + '_' + column + '_' + modules2 + '_products .scrollbox div:even').attr('class', 'even');

                data = $.map($('.filter_' + module_row + '_' + column + '_' + modules2 + '_products .scrollbox input'), function(element){
                    return $(element).attr('value');
                });

                $('input[name=\'future_home_module[' + module_row + '][column][' + column + '][module][' + modules2 + '][products][products]\']').attr('value', data.join());

                return false;
            },
            focus: function(event, ui) {
                return false;
            }
        });

        modules++;
    }
</script>

<script type="text/javascript">
    var column = <?php echo $columns_count; ?>;
    function addcolumn(module_row) {
        html = '<div id="tab-module-' + module_row + '-column-' + column + '" class="tab-content3">';
        html += '		<div class="status status-off" title="0" rel="module_' + module_row + '_column_' + column + '_status"></div><input name="future_home_module[' + module_row + '][column][' + column + '][status]" value="0" id="module_' + module_row + '_column_' + column + '_status" type="hidden" />';

        html += '		<div class="input clearfix">';
        html += '			<p>Column width:</p>';
        html += '			<select name="future_home_module['+ module_row +'][column][' + column + '][width]" class="change-column-width" id="module-' + module_row + '-column-' + column + '">';
        html += '				<option value="1">1/12</option>';
        html += '				<option value="2">2/12</option>';
        html += '				<option value="3">3/12</option>';
        html += '				<option value="4">4/12</option>';
        html += '				<option value="5">5/12</option>';
        html += '				<option value="6">6/12</option>';
        html += '				<option value="7">7/12</option>';
        html += '				<option value="8">8/12</option>';
        html += '				<option value="9">9/12</option>';
        html += '				<option value="10">10/12</option>';
        html += '				<option value="11">11/12</option>';
        html += '				<option value="12">12/12</option>';
        html += '				<option value="advanced">Advanced</option>';
        html += '			</select>';
        html += '		</div>';

        html += '		<div class="input clearfix simple-width">';
        html += '			<p>Disable on mobile:</p>';
        html += '			<select name="future_home_module['+ module_row +'][column][' + column + '][disable_on_mobile]">';
        html += '				<option value="0">No</option>';
        html += '				<option value="1">Yes</option>';
        html += '			</select>';
        html += '		</div>';

        html += '		<div class="input clearfix advanced-width" style="display: none">';
        html += '			<p>Column width on extra small devices (<768px):</p>';
        html += '			<select name="future_home_module['+ module_row +'][column][' + column + '][width_xs]">';
        html += '				<option value="1">1/12</option>';
        html += '				<option value="2">2/12</option>';
        html += '				<option value="3">3/12</option>';
        html += '				<option value="4">4/12</option>';
        html += '				<option value="5">5/12</option>';
        html += '				<option value="6">6/12</option>';
        html += '				<option value="7">7/12</option>';
        html += '				<option value="8">8/12</option>';
        html += '				<option value="9">9/12</option>';
        html += '				<option value="10">10/12</option>';
        html += '				<option value="11">11/12</option>';
        html += '				<option value="12">12/12</option>';
        html += '				<option value="hidden">hidden</option>';
        html += '			</select>';
        html += '		</div>';

        html += '		<div class="input clearfix advanced-width" style="display: none">';
        html += '			<p>Column width on small devices (≥768px):</p>';
        html += '			<select name="future_home_module['+ module_row +'][column][' + column + '][width_sm]">';
        html += '				<option value="1">1/12</option>';
        html += '				<option value="2">2/12</option>';
        html += '				<option value="3">3/12</option>';
        html += '				<option value="4">4/12</option>';
        html += '				<option value="5">5/12</option>';
        html += '				<option value="6">6/12</option>';
        html += '				<option value="7">7/12</option>';
        html += '				<option value="8">8/12</option>';
        html += '				<option value="9">9/12</option>';
        html += '				<option value="10">10/12</option>';
        html += '				<option value="11">11/12</option>';
        html += '				<option value="12">12/12</option>';
        html += '				<option value="hidden">hidden</option>';
        html += '			</select>';
        html += '		</div>';

        html += '		<div class="input clearfix advanced-width" style="display: none">';
        html += '			<p>Column width on medium devices (≥992px):</p>';
        html += '			<select name="future_home_module['+ module_row +'][column][' + column + '][width_md]">';
        html += '				<option value="1">1/12</option>';
        html += '				<option value="2">2/12</option>';
        html += '				<option value="3">3/12</option>';
        html += '				<option value="4">4/12</option>';
        html += '				<option value="5">5/12</option>';
        html += '				<option value="6">6/12</option>';
        html += '				<option value="7">7/12</option>';
        html += '				<option value="8">8/12</option>';
        html += '				<option value="9">9/12</option>';
        html += '				<option value="10">10/12</option>';
        html += '				<option value="11">11/12</option>';
        html += '				<option value="12">12/12</option>';
        html += '				<option value="hidden">hidden</option>';
        html += '			</select>';
        html += '		</div>';

        html += '		<div class="input clearfix advanced-width" style="display: none">';
        html += '			<p>Column width on large devices (≥1200px):</p>';
        html += '			<select name="future_home_module['+ module_row +'][column][' + column + '][width_lg]">';
        html += '				<option value="1">1/12</option>';
        html += '				<option value="2">2/12</option>';
        html += '				<option value="3">3/12</option>';
        html += '				<option value="4">4/12</option>';
        html += '				<option value="5">5/12</option>';
        html += '				<option value="6">6/12</option>';
        html += '				<option value="7">7/12</option>';
        html += '				<option value="8">8/12</option>';
        html += '				<option value="9">9/12</option>';
        html += '				<option value="10">10/12</option>';
        html += '				<option value="11">11/12</option>';
        html += '				<option value="12">12/12</option>';
        html += '				<option value="hidden">hidden</option>';
        html += '			</select>';
        html += '		</div>';

        html += '		<div class="input clearfix">';
        html += '			<p>Sort:</p>';
        html += '			<input type="text" name="future_home_module['+ module_row +'][column][' + column + '][sort]" value="">';
        html += '		</div>';

        html += '	<h4 style="margin-top: 20px">Add modules to the column</h4>';

        html += '		<div id="module_' + module_row + '_column_' + column + '_modules" class="tabs_add_element clearfix">';
        html += '			<img src="view/image/module_template/add.png" alt="" onclick="addModuleToColumn(' + module_row + ', ' + column + ');">';
        html += '		</div>';

        html += '		<div id="module_' + module_row + '_column_' + column + '_modules_add"></div>';

        html += '</div>';

        $('#tab-module-' + module_row + '').append(html);

        $('#tab-module-' + module_row + '-tabs .column-add').before('<a href="#tab-module-' + module_row + '-column-' + column + '" id="column-' + column + '">Column &nbsp;<img src="view/image/module_template/delete-slider.png" alt="" onclick="$(\'#column-' + column + '\').remove(); $(\'#tab-module-' + module_row + '-column-' + column + '\').remove(); return false;" /></a>');

        $('#tab-module-' + module_row + '-tabs a').tabs();

        $('#column-' + column).trigger('click');
        column++;
    }
</script>
<script>
    function addtr() {
         var div_html        = "";
        var carousel        = $('#insert_you_carousel');
        var carousel_length = $('#insert_you_carousel tr').length;
        div_html += '    <tr>';
        div_html += '        <td class="text-left"><input class="form-control" type="text" name="future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][future_carousel][sort][]"/></td>';
        div_html += '        <td class="text-left"><input class="form-control" type="text" name="future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][future_carousel][link][]"/></td>';
        div_html += '        <td class="text-left">';
        div_html += '            <a href="" id="thumb-image0" data-toggle="image" class="img-thumbnail" >';
        div_html += '            <img src="http://127.0.0.1/image/cache/no_image-100x100.png" alt=""></a>';
        div_html += '            <input type="hidden" name="future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][future_carousel][image][]" value="<?php echo $image; ?>" id="input-image" />';
        div_html += '       </td>';
        div_html += '   </tr>';
        if(carousel_length==0)
        {
            carousel.html(div_html);
        } else {
            var current_html = $('#insert_you_carousel').html();
               carousel.html(current_html + div_html);
        }
    }

</script>
<script type="text/javascript"><!--
    var module_row = <?php echo $module_row; ?>;

    function addImage() {
        html  = '<tr id="image-row' + module_row + '">';
        html += '  <td class="text-left">';
    <?php foreach ($languages as $language) { ?>
            html += '    <div class="input-group">';
            html += '       <span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span><input type="text" name="future_home_module['+ module_row +'][column]['+ module_row +'][module]['+ module_row +'][future_carousel][products]['+ module_row +'][sort]['+ module_row +']" value="" placeholder="" class="form-control" />';
            html += '    </div>';
        <?php } ?>
        html += '  </td>';
        html += '  <td class="text-left" style="width: 30%;"><input type="text" name="future_home_module['+ module_row +'][column]['+ module_row +'][module]['+ module_row +'][future_carousel][products]['+ module_row +'][link]['+ module_row +']" value="" placeholder="" class="form-control" /></td>';
        html += '  <td class="text-left"><a href="" id="thumb-image' + module_row + '" data-toggle="image" class="img-thumbnail"><img src="<?php echo $placeholder; ?>" alt="" title="" data-placeholder="" /></a><input type="hidden" name="future_home_module['+ module_row +'][column]['+ module_row +'][module]['+ module_row +'][future_carousel][products]['+ module_row +'][image]['+ module_row +']" value="" id="input-image' + module_row + '" /></td>';
        html += '  <td class="text-left"><button type="button" onclick="$(\'#image-row' + module_row  + '\').remove();" data-toggle="tooltip" title="remove" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>';
        html += '</tr>';

        $('#images tbody').append(html);

        module_row++;
    }
    //--></script>

<script type="text/javascript"><!--
    var module_row = <?php echo $module_row; ?>;

    function addModule() {
        html  = '<div id="tab-module-' + module_row + '" class="tab-content">';

        html += '	<div id="tab-module-' + module_row + '-tabs" class="module-tabs">';
        html += '		<a href="#tab-module-' + module_row + '-settings">Settings</a>';
        html += '		<span class="column-add">Add Column &nbsp;<img src="view/image/module_template/add.png" alt="" onclick="addcolumn(' + module_row + ');" /></span>';
        html += '	</div>';

        html += '	<div id="tab-module-' + module_row + '-settings" class="tab-content3">';
        html += '  		<h4>Design settings</h4>';
        html += '  		<table class="form">';
        html += '    		<tr>';
        html += '      			<td>Add custom class:</td>';
        html += '      			<td><input type="text" name="future_home_module[' + module_row + '][custom_class]" value="" /></td>';
        html += '    		</tr>';
        html += '    		<tr>';
        html += '      			<td>Margins (px):<br><small style="color:#a3a3a3;font-size: 10px">(Top - right - bottom - left)</small></td>';
        html += '      			<td><input type="text" name="future_home_module[' + module_row + '][margin_top]" style="display: inline-block;margin-right:10px;" size="2" value="0" /> - <input type="text" name="future_home_module[' + module_row + '][margin_right]" size="2" style="display: inline-block;margin-right:10px;margin-left: 10px" value="0" /> - <input type="text" name="future_home_module[' + module_row + '][margin_bottom]" size="2" style="display: inline-block;margin-right:10px;margin-left: 10px" value="0" /> - <input type="text" name="future_home_module[' + module_row + '][margin_left]" style="display: inline-block;margin-right:10px;margin-left: 10px" size="2" value="0" /></td>';
        html += '    		</tr>';
        html += '    		<tr>';
        html += '      			<td>Paddings (px):<br><small style="color:#a3a3a3;font-size: 10px">(Top - right - bottom - left)</small></td>';
        html += '      			<td><input type="text" name="future_home_module[' + module_row + '][padding_top]" style="display: inline-block;margin-right:10px;" size="2" value="0" /> - <input type="text" name="future_home_module[' + module_row + '][padding_right]" size="2" style="display: inline-block;margin-right:10px;margin-left: 10px" value="0" /> - <input type="text" name="future_home_module[' + module_row + '][padding_bottom]" size="2" style="display: inline-block;margin-right:10px;margin-left: 10px" value="0" /> - <input type="text" name="future_home_module[' + module_row + '][padding_left]" style="display: inline-block;margin-right:10px;margin-left: 10px" size="2" value="0" /></td>';
        html += '    		</tr>';
        html += '    		<tr>';
        html += '      			<td>Force full width:</td>';
        html += '      			<td><select name="future_home_module[' + module_row + '][force_full_width]">';
        html += '        		<option value="0">No</option>';
        html += '        		<option value="1">Yes</option>';
        html += '      			</select></td>';
        html += '    		</tr>';
        html += '    		<tr>';
        html += '      			<td>Background color:</td>';
        html += '      			<td><input type="text" name="future_home_module[' + module_row + '][background_color]" class="colorpicker-input" value="" /></td>';
        html += '    		</tr>';
        html += '    		<tr>';
        html += '      			<td>Background image type:</td>';
        html += '      			<td><select name="future_home_module[' + module_row + '][background_image_type]">';
        html += '        		<option value="0">None</option>';
        html += '        		<option value="1">Standard</option>';
        html += '        		<option value="2">Parallax</option>';
        html += '      			</select></td>';
        html += '    		</tr>';
        html += '		     <tr>';
        html += '			     <td>Background image:</td>';
        html += '			     <td>';
        html += '				     <a href="" id="thumb-'+ module_row +'" class="img-thumbnail img-edit" data-toggle="image"><img src="<?php echo $placeholder; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a>';
        html += '				     <input type="hidden" name="future_home_module['+ module_row +'][background_image]" value="" id="input-'+ module_row +'" />';
        html += '			     </td>';
        html += '			</tr>';
        html += '    		<tr>';
        html += '      			<td>Position:</td>';
        html += '      			<td><select name="future_home_module[' + module_row + '][background_image_position]">';
        html += '        		<option value="top left">Top left</option>';
        html += '        		<option value="top center">Top center</option>';
        html += '        		<option value="top right">Top right</option>';
        html += '        		<option value="bottom left">Bottom left</option>';
        html += '        		<option value="bottom center">Bottom center</option>';
        html += '        		<option value="bottom right">Bottom right</option>';
        html += '        		<option value="50% 0">50% 0</option>';
        html += '      			</select></td>';
        html += '    		</tr>';
        html += '    		<tr>';
        html += '      			<td>Repeat:</td>';
        html += '      			<td><select name="future_home_module[' + module_row + '][background_image_repeat]">';
        html += '        		<option value="no-repeat">no-repeat</option>';
        html += '        		<option value="repeat-x">repeat-x</option>';
        html += '        		<option value="repeat-y">repeat-y</option>';
        html += '        		<option value="repeat">repeat</option>';
        html += '      			</select></td>';
        html += '    		</tr>';
        html += '    		<tr>';
        html += '      			<td>Attachment:</td>';
        html += '      			<td><select name="future_home_module[' + module_row + '][background_image_attachment]">';
        html += '        		<option value="scroll">scroll</option>';
        html += '        		<option value="fixed">fixed</option>';
        html += '      			</select></td>';
        html += '    		</tr>';
        html += '  		</table>';

        html += '  		<h4 style="padding-top: 30px">Layout settings</h4>';
        html += '  		<table class="form">';
        html += '    		<tr>';
        html += '     		 	<td>Layout:</td>';
        html += '      			<td><select name="future_home_module[' + module_row + '][layout_id]">';
        html += '           		<option value="88888" selected>6#Future(HOME)</option>';
        html += '      			</select></td>';
        html += '   		 </tr>';
        html += '    		<tr>';
        html += '      			<td>Position:</td>';
        html += '      			<td><select name="future_home_module[' + module_row + '][position]">';
       /* html += '				          <option value="header_notice">Header notice</option>';
        html += '				          <option value="top_block">Top block</option>';
        html += '				          <option value="slideshow">Slideshow</option>';
        html += '				          <option value="preface_left">Preface left</option>';
        html += '				          <option value="preface_right">Preface right</option>';
        html += '				          <option value="preface_fullwidth">Preface fullwidth</option>';
        html += '				          <option value="column_left">Column left</option>';
        html += '				          <option value="content_big_column">Content big column</option>';
        html += '				          <option value="content_top">Content top</option>';
        html += '				          <option value="product_custom_block">Product Custom Block</option>';
        html += '				          <option value="column_right">Column right</option>';
        html += '				          <option value="content_bottom">Content bottom</option>';
        html += '				          <option value="customfooter_top">CustomFooter Top</option>';
        html += '				          <option value="customfooter">CustomFooter</option>';
        html += '				          <option value="customfooter_bottom">CustomFooter Bottom</option>';
        html += '				          <option value="footer_top">Footer top</option>';
        html += '				          <option value="footer">Footer</option>';
        html += '				          <option value="footer_bottom">Footer bottom</option>';
        html += '				          <option value="bottom">Bottom</option>';*/
        html += '				          <option value="header">Header</option>';
        html += '				          <option value="middle">Middle</option>';
        html += '				          <option value="bottom">Bottom</option>';
        html += '				          <option value="other">Other</option>';
        html += '      			</select></td>';
        html += '    		</tr>';
        html += '    		<tr>';
        html += '      			<td>Status:</td>';
        html += '      			<td><select name="future_home_module[' + module_row + '][status]">';
        html += '        		<option value="1">Enabled</option>';
        html += '        		<option value="0">Disabled</option>';
        html += '      			</select></td>';
        html += '    		</tr>';
        html += '    		<tr>';
        html += '      			<td>Sort Order:</td>';
        html += '      			<td><input type="text" name="future_home_module[' + module_row + '][sort_order]" value="" size="3" /></td>';
        html += '    		</tr>';
        html += '    		<tr>';
        html += '      			<td>Disable on mobile:</td>';
        html += '      			<td><select name="future_home_module[' + module_row + '][disable_on_mobile]">';
        html += '        		<option value="0">No</option>';
        html += '        		<option value="1">Yes</option>';
        html += '      			</select></td>';
        html += '    		</tr>';
        html += '  		</table>';
        html += '	</div>';

        html += '</div>';

        $('.tabs').append(html);

        $('.colorpicker-input').ColorPicker({
            onChange: function (hsb, hex, rgb, el) {
                $(el).val("#" +hex);
                $(el).css("border-right", "20px solid #" + hex);
            },
            onShow: function (colpkr) {
                $(colpkr).show();
                return false;
            },
            onHide: function (colpkr) {
                $(colpkr).hide();
                return false;
            }
        });

        $('#tab-module-' + module_row + '-tabs a').tabs();

        $('#module-add').before('<a href="#tab-module-' + module_row + '" id="module-' + module_row + '">Module ' + module_row + ' &nbsp;<img src="view/image/module_template/delete-slider.png" alt="" onclick="$(\'#module-' + module_row + '\').remove(); $(\'#tab-module-' + module_row + '\').remove(); $(\'.main-tabs a:first\').trigger(\'click\'); return false;" /></a>');

        $('.main-tabs a').tabs();

        $('#module-' + module_row).trigger('click');

        module_row++;
    }
    //--></script>
<script>
    var future_home = <?php echo $future_home; ?>;
    function addFutureHome(module_row, column, modules)
    {

        html = '<tbody id="future_home-' + future_home + '">';
        html += '	<tr>';
        html += '		<td class="first"><div class="list-language">';
    <?php foreach ($languages as $language) { ?>
        html += '			<div class="language">';
        html += '				<img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" alt="<?php echo $language['name']; ?>" width="16px" height="11px" />';
        html += '				<input type="text" name="future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][future_home][array][' + future_home + '][product_name][<?php echo $language['language_id']; ?>]">';
        html += '			</div>';
    <?php } ?>
        html += '		</div></td><td>';
        html += '       <a href="" id="thumb-image' + future_home + '_home" data-toggle="image" class="img-thumbnail"><img src="/image/cache/no_image-100x100.png" alt="" title="" data-placeholder="/image/cache/no_image-100x100.png"></a>';
        html += '      <input name="future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][future_home][array][' + future_home + '][product_image]" value="" id="input-image' + future_home + '_home" type="hidden">';
        html += '      <input name="future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][future_home][array][' + future_home + '][funding_id]" value=""  type="hidden"></td>';
        html += '		<td><a onclick="$(\'#future_home-' + future_home + '\').remove();" class="remove-carousel">Remove</a></td>';
        html += '	</tr>';
        html += '</tbody>';

        $('#future_home-' + module_row + '-' + column + '-' + modules + ' tfoot').before(html);

        var modules6 = future_home;
        $('input[name=\'future_home_module[' + module_row + '][column][' + column + '][module][' + modules + '][future_home][array][' + modules6 + '][product_name][1]\']').autocomplete({
            delay: 500,
            source: function (request, response) {
                $.ajax({
                   url: 'index.php?route=catalog/product/autoFuture&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
                   dataType: 'json',
                    success: function(json) {
                       response($.map(json, function (item) {
                           return {
                               label: item['name'],
                               value: item['funding_id'],
                               image: item['image'],
                               show_image:item['show_image']
                           }
                       }));
                    }

                });
            },
            select:function (item) {
                $('input[name=\'future_home_module[' + module_row + '][column][' + column + '][module][' + modules + '][future_home][array][' + modules6 + '][product_name][1]\']').val(item['label']);
                $('input[name=\'future_home_module[' + module_row + '][column][' + column + '][module][' + modules + '][future_home][array][' + modules6 + '][funding_id]\']').val(item['value']);
                $('input[name=\'future_home_module[' + module_row + '][column][' + column + '][module][' + modules + '][future_home][array][' + modules6 + '][product_image]\']').val(item['image']);
                var a = $('input[name=\'future_home_module[' + module_row + '][column][' + column + '][module][' + modules + '][future_home][array][' + modules6 + '][product_image]\']').prev('a').find('img');
                a.attr("src", item['show_image']);
            }

        });
        future_home++;

    }
</script>
<script>
    var future_image = <?php echo $future_image; ?>;
    function addCarousel(module_row, column, modules)
    {

        html = '<tbody id="future_carousel-' + future_image + '">';
        html += '	<tr>';
        html += '		<td class="first"><div class="list-language">';
    <?php foreach ($languages as $language) { ?>
        html += '			<div class="language">';
        html += '				<img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" alt="<?php echo $language['name']; ?>" width="16px" height="11px" />';
        html += '				<input type="text" name="future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][future_carousel][array][' + future_image + '][sort][<?php echo $language['language_id']; ?>]">';
        html += '			</div>';
    <?php } ?>
        html += '		</div></td><td>';
        html += '				<input type="text" name="future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][future_carousel][array][' + future_image + '][link]" >';
        html += '     </td>';
        html += '     <td><a href="" id="thumb-image' + future_image + '_image" data-toggle="image" class="img-thumbnail"><img src="/image/cache/no_image-100x100.png" alt="" title="" data-placeholder="/image/cache/no_image-100x100.png"></a>';
        html += '      <input name="future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][future_carousel][array][' + future_image + '][image]" value="" id="input-image' + future_image + '_image" type="hidden"></td>';
        html += '		<td><a onclick="$(\'#future_carousel-' + future_image + '\').remove();" class="remove-carousel">Remove</a></td>';
        html += '	</tr>';
        html += '</tbody>';

        $('#future_carousel-' + module_row + '-' + column + '-' + modules + ' tfoot').before(html);
        future_image++;

    }
</script>

<script>
    var future_product = <?php echo $future_product; ?>;
    function addFutureProduct(module_row, column, modules)
    {

        html = '<tbody id="future_product-' + future_product + '">';
        html += '	<tr>';
        html += '		<td class="first"><div class="list-language">';
    <?php foreach ($languages as $language) { ?>
        html += '			<div class="language">';
        html += '				<img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" alt="<?php echo $language['name']; ?>" width="16px" height="11px" />';
        html += '				<input class="future_product" type="text" name="future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][future_product][array][' + future_product + '][product_name][<?php echo $language['language_id']; ?>]">';
        html += '			</div>';
    <?php } ?>
        html += '		</div></td><td>';
        html += '				<input type="text" name="future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][future_product][array][' + future_product + '][link]" >';
        html += '     </td>';
        html += '     <td><a href="" id="thumb-image' + future_product + '_product" data-toggle="image" class="img-thumbnail"><img src="/image/cache/no_image-100x100.png"  alt="" title="" data-placeholder="/image/cache/no_image-100x100.png"></a>';
        html += '      <input name="future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][future_product][array][' + future_product + '][image]" value="" id="input-image' + future_product + '_product" type="hidden">';
        html += '      <input name="future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][future_product][array][' + future_product + '][product_id]" value=""  type="hidden"></td>';
        html += '		<td><a onclick="$(\'#future_product-' + future_product + '\').remove();" class="remove-product">Remove</a></td>';
        html += '	</tr>';
        html += '</tbody>';

        $('#future_product-' + module_row + '-' + column + '-' + modules + ' tfoot').before(html);

        var modules3 = future_product;
        $('input[name=\'future_home_module[' + module_row + '][column][' + column + '][module][' + modules + '][future_product][array][' + modules3 + '][product_name][1]\']').autocomplete({
            delay: 500,
            source: function(request, response) {
                $.ajax({
                    url: 'index.php?route=catalog/product/autoProduct&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
                    dataType: 'json',
                    success: function(json) {
                        response($.map(json, function(item) {
                            return {
                                label: item['name'],
                                value: item['product_id']
                            }
                        }));
                    }
                });
            },
            select: function(item) {
                $('input[name=\'future_home_module[' + module_row + '][column][' + column + '][module][' + modules + '][future_product][array][' + modules3 + '][product_name][1]\']').val(item['label']);
                $('input[name=\'future_home_module[' + module_row + '][column][' + column + '][module][' + modules + '][future_product][array][' + modules3 + '][product_id]\']').val(item['value']);
                $.ajax({
                    url: 'index.php?route=module/discover_recommend/product_ajax&token=<?php echo $token; ?>&product_id='+item['value'],
                    dateType: 'json',
                    success:function (json) {
                                var obj = JSON.parse(json);
                                var domain = window.location.host;
                                var url = obj.url.split(domain+'/');
                                obj.url = url[1];
                                $('input[name=\'future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][future_product][array][' + modules3 + '][link]\']').val(obj.url);
                                $('input[name=\'future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][future_product][array][' + modules3 + '][image]\']').val(obj.image);
                                var a = $('input[name=\'future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][future_product][array][' + modules3 + '][image]\']').prev('a').find('img');
                                    a.attr("src", obj.image_show);
                    }
                });
                //$('#product-' + module_row + '-' + column + '-' + modules + '-' + modules3 + '-' + item['value']).remove();

                //$('.filter_' + module_row + '_' + column + '_' + modules + '_' + modules3 + '_products .scrollbox').append('<div id="product-' + module_row + '-' + column + '-' + modules + '-' + modules3 + '-' + item['value'] + '">' + item['label'] + '<img src="view/image/module_template/delete-slider.png" alt="' + module_row + '" title="' + column + '" value="' + modules3 + '" id="' + modules + '" class="' + item['value'] + '" /><input type="hidden" value="' + item['value'] + '" /></div>');

                //$('.filter_' + module_row + '_' + column + '_' + modules + '_' + modules3 + '_products .scrollbox div:odd').attr('class', 'odd');
                //$('.filter_' + module_row + '_' + column + '_' + modules + '_' + modules3 + '_products .scrollbox div:even').attr('class', 'even');

               /* data = $.map($('.filter_' + module_row + '_' + column + '_' + modules + '_' + modules3 + '_products .scrollbox input'), function(element){
                    return $(element).attr('value');
                });*/

                //$('input[name=\'future_home_module[' + module_row + '][column][' + column + '][module][' + modules + '][products_tabs][products][' + modules3 + '][products]\']').attr('value', data.join());

                return false;
            },
            focus: function(event, ui) {
                return false;
            }
        });
        future_product++;

    }
</script>

<script>
    var future_category = <?php echo $future_category; ?>;
    function addCategory(module_row, column, modules)
    {

        html = '<tbody id="future_category-' + future_category + '">';
        html += '	<tr>';
        html += '		<td class="first"><div class="list-language">';
    <?php foreach ($languages as $language) { ?>
        html += '			<div class="language">';
        html += '				<img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" alt="<?php echo $language['name']; ?>" width="16px" height="11px" />';
        html += '				<input type="text" name="future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][future_category][array][' + future_category + '][category_name][<?php echo $language['language_id']; ?>]">';
        html += '			</div>';
    <?php } ?>
        html += '		</div></td><td>';
        html += '				<input type="text" name="future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][future_category][array][' + future_category + '][icon]" >';
        html += '     </td>';
        html += '     <td><a href="" id="thumb-image' + future_category + '_category" data-toggle="image" class="img-thumbnail"><img src="/image/cache/no_image-100x100.png" alt="" title="" data-placeholder="/image/cache/no_image-100x100.png" ></a>';
        html += '      <input name="future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][future_category][array][' + future_category + '][image]" value="" id="input-image' + future_category + '_category" type="hidden">';
        html += '      <input name="future_home_module['+ module_row +'][column][' + column + '][module][' + modules + '][future_category][array][' + future_category + '][category_id]" value=""  type="hidden"></td>'
        html += '		<td><a onclick="$(\'#future_category-' + future_category + '\').remove();" class="remove-category">Remove</a></td>';
        html += '	</tr>';
        html += '</tbody>';

        $('#future_category-' + module_row + '-' + column + '-' + modules + ' tfoot').before(html);

        var modules8 = future_category;
        $('input[name=\'future_home_module[' + module_row + '][column][' + column + '][module][' + modules + '][future_category][array][' + modules8 + '][category_name][1]\']').autocomplete({
            delay: 500,
            source: function (request, response) {
                $.ajax({
                    url: 'index.php?route=catalog/product/autoCategory&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
                    dataType: 'json',
                    success: function(json) {
                        response($.map(json, function (item) {
                            return {
                                label: item['name'],
                                value: item['category_id'],
                            }
                        }));
                    }

                });
            },
            select:function (item) {
                $('input[name=\'future_home_module[' + module_row + '][column][' + column + '][module][' + modules + '][future_category][array][' + modules8 + '][category_name][1]\']').val(item['label']);
                $('input[name=\'future_home_module[' + module_row + '][column][' + column + '][module][' + modules + '][future_category][array][' + modules8 + '][category_id]\']').val(item['value']);
            }

        });
        future_category++;
    }
</script>

<script type="text/javascript">
    jQuery(document).ready(function($) {
        $('body').on('click', '.scrollbox.products img', function () {
            $(this).parent().remove();
            $('.filter_' + $(this).attr("alt") + '_' + $(this).attr("title") + '_' + $(this).attr("id") + '_products .scrollbox div:odd').attr('class', 'odd');
            $('.filter_' + $(this).attr("alt") + '_' + $(this).attr("title") + '_' + $(this).attr("id") + '_products .scrollbox div:even').attr('class', 'even');

            data = $.map($('.filter_' + $(this).attr("alt") + '_' + $(this).attr("title") + '_' + $(this).attr("id") + '_products .scrollbox input'), function(element){
                return $(element).attr('value');
            });

            $('input[name=\'future_home_module[' + $(this).attr("alt") + '][column][' + $(this).attr("title") + '][module][' + $(this).attr("id") + '][products][products]\']').attr('value', data.join());
        });

        $('body').on('click', '.scrollbox.categories img', function () {
            $(this).parent().remove();
            $('.filter_' + $(this).attr("alt") + '_' + $(this).attr("title") + '_' + $(this).attr("id") + '_categories .scrollbox div:odd').attr('class', 'odd');
            $('.filter_' + $(this).attr("alt") + '_' + $(this).attr("title") + '_' + $(this).attr("id") + '_categories .scrollbox div:even').attr('class', 'even');

            data = $.map($('.filter_' + $(this).attr("alt") + '_' + $(this).attr("title") + '_' + $(this).attr("id") + '_categories .scrollbox input'), function(element){
                return $(element).attr('value');
            });

            $('input[name=\'future_home_module[' + $(this).attr("alt") + '][column][' + $(this).attr("title") + '][module][' + $(this).attr("id") + '][products][categories]\']').attr('value', data.join());
        });

        $('body').on('click', '.scrollbox.products2 img', function () {
            $(this).parent().remove();
            $('.filter_' + $(this).attr("alt") + '_' + $(this).attr("title") + '_' + $(this).attr("id") + '_' + $(this).attr("value") + '_products .scrollbox div:odd').attr('class', 'odd');
            $('.filter_' + $(this).attr("alt") + '_' + $(this).attr("title") + '_' + $(this).attr("id") + '_' + $(this).attr("value") + '_products .scrollbox div:even').attr('class', 'even');

            data = $.map($('.filter_' + $(this).attr("alt") + '_' + $(this).attr("title") + '_' + $(this).attr("id") + '_' + $(this).attr("value") + '_products .scrollbox input'), function(element){
                return $(element).attr('value');
            });

            $('input[name=\'future_home_module[' + $(this).attr("alt") + '][column][' + $(this).attr("title") + '][module][' + $(this).attr("id") + '][products_tabs][products][' + $(this).attr("value") + '][products]\']').attr('value', data.join());
        });

        $('body').on('click', '.scrollbox.collections img', function () {
            $(this).parent().remove();
            $('.filter_' + $(this).attr("alt") + '_' + $(this).attr("title") + '_' + $(this).attr("id") + '_' + $(this).attr("value") + '_collections .scrollbox div:odd').attr('class', 'odd');
            $('.filter_' + $(this).attr("alt") + '_' + $(this).attr("title") + '_' + $(this).attr("id") + '_' + $(this).attr("value") + '_collections .scrollbox div:even').attr('class', 'even');

            data = $.map($('.filter_' + $(this).attr("alt") + '_' + $(this).attr("title") + '_' + $(this).attr("id") + '_' + $(this).attr("value") + '_collections .scrollbox input'), function(element){
                return $(element).attr('value');
            });

            $('input[name=\'future_home_module[' + $(this).attr("alt") + '][column][' + $(this).attr("title") + '][module][' + $(this).attr("id") + '][collections][collection][' + $(this).attr("value") + '][products]\']').attr('value', data.join());
        });


        $('body').on('click', '.scrollbox.categories2 img', function () {
            $(this).parent().remove();
            $('.filter_' + $(this).attr("alt") + '_' + $(this).attr("title") + '_' + $(this).attr("id") + '_' + $(this).attr("value") + '_categories .scrollbox div:odd').attr('class', 'odd');
            $('.filter_' + $(this).attr("alt") + '_' + $(this).attr("title") + '_' + $(this).attr("id") + '_' + $(this).attr("value") + '_categories .scrollbox div:even').attr('class', 'even');

            data = $.map($('.filter_' + $(this).attr("alt") + '_' + $(this).attr("title") + '_' + $(this).attr("id") + '_' + $(this).attr("value") + '_categories .scrollbox input'), function(element){
                return $(element).attr('value');
            });

            $('input[name=\'future_home_module[' + $(this).attr("alt") + '][column][' + $(this).attr("title") + '][module][' + $(this).attr("id") + '][products_tabs][products][' + $(this).attr("value") + '][categories]\']').attr('value', data.join());
        });

        $('#advanced_grid').on('change', '.type-column', function () {
            var id_module = $(this).attr("id");
            $("#" + id_module +".type-column option:selected").each(function() {
                $("#module-" + id_module + " .type-column > div").css("display", "none");
                $("#module-" + id_module + " .type-column > div input, #module-" + id_module + " .type-column > div textarea, #module-" + id_module + " .type-column > div select").attr("disabled", "disabled");
                $("#module-" + id_module + " .type-column > div." + $(this).val()).css("display", "block");
                $("#module-" + id_module + " .type-column > div." + $(this).val() + " input, #module-" + id_module + " .type-column > div." + $(this).val() + " textarea, #module-" + id_module + " .type-column > div." + $(this).val() + " select").removeAttr("disabled");
            });

        });

        $('#advanced_grid').on('change', '.change-column-width', function () {
            var id_module = $(this).attr("id");
            $("#" +  id_module + " option:selected").each(function() {
                if($(this).val() == 'advanced') {
                    $("#tab-" + id_module + " .advanced-width").show();
                    $("#tab-" + id_module + " .simple-width").hide();
                } else {
                    $("#tab-" + id_module + " .advanced-width").hide();
                    $("#tab-" + id_module + " .simple-width").show();
                }
            });

        });

        $('#advanced_grid').on('change', '.get-product', function () {
            var id_module = $(this).attr("id");
            $("#module-" + id_module + " .panel-products-autocomplete").hide();
            $("#module-" + id_module + " .panel-categories-autocomplete").hide();
            $("#" + id_module +".get-product option:selected").each(function() {
                if($(this).val() == 'products') {
                    $("#module-" + id_module + " .panel-products-autocomplete").show();
                } else if($(this).val() == 'category') {
                    $("#module-" + id_module + " .panel-categories-autocomplete").show();
                }
            });

        });

        $('#advanced_grid').on('change', '.get-collection', function () {
            var id_module = $(this).attr("id");
            $("#module-" + id_module + " .panel-collections-autocomplete").hide();
            $("#" + id_module +".get-collection option:selected").each(function() {
                if($(this).val() == 'collections') {
                    $("#module-" + id_module + " .panel-collections-autocomplete").show();
                }
            });

        });

        $('#advanced_grid').on('click', '.status', function () {

            var styl = $(this).attr("rel");
            var co = $(this).attr("title");

            if(co == 1) {

                $(this).removeClass('status-on');
                $(this).addClass('status-off');
                $(this).attr("title", "0");

                $("#"+styl+"").val(0);

            }

            if(co == 0) {

                $(this).addClass('status-on');
                $(this).removeClass('status-off');
                $(this).attr("title", "1");

                $("#"+styl+"").val(1);

            }

        });

    });
</script>
<?php echo $footer; ?>