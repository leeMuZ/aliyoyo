<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="livehelp-form-setting" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
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
    <div class="alert alert-success"><i class="fa fa-check"></i> <?php echo $success; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_form; ?></h3>
      </div>
      <div class="panel-body">


         <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" class="form-horizontal group-border-dashed" id="livehelp-form-setting">

             <ul class="nav nav-pills">
               <li class="active"><a href="#tab-general" data-toggle="tab"><?php echo $tab_general; ?></a></li>
               <li><a href="#tab-admin" data-toggle="tab"><?php echo $tab_admin; ?></a></li>
               <li><a href="#tab-store" data-toggle="tab"><?php echo $tab_store; ?></a></li>
             </ul>

            <div class="tab-content">
               <!-- TAB GENERAL -->
               <div class="tab-pane active" id="tab-general">
                  <!-- INPUT ABSOLUTE PATH -->
                  <div class="form-group">
                     <label for="input_absolute_path" class="col-sm-4 control-label">
                     <span class="has-tooltip" data-toggle="tooltip" data-placement="top" title="<?php echo $title_absolute_path; ?>">
                     <?php echo $entry_absolute_path; ?>
                     </span>
                     </label>
                     <div class="col-sm-4">
                        <input type="text" class="form-control" name="absolute_path" value="<?php echo $absolute_path; ?>" id="input_absolute_path">
                        <?php if($sample_emoticon) { ?>
                        <br>
                        <small><?php echo $text_sample_image_display; ?></small>
                        <p>
                           <img id="abs_path_verify" src="<?php echo $absolute_path . $sample_emoticon; ?>" data-src="<?php echo $sample_emoticon; ?>" alt="<?php echo $text_sample_image; ?>">
                        </p>
                        <?php } ?>
                     </div>
                  </div>
                  <!-- INPUT TEXT_MAX_LENGTH -->
                  <div class="form-group<?php echo (!empty($error_text_max_length) ? " has-error" : ""); ?>">
                     <label class="col-sm-4 control-label">
                     <?php echo $entry_text_max_length; ?>
                     </label>
                     <div class="col-sm-4">
                        <input type="text" class="form-control" name="text_max_length" value="<?php echo $text_max_length; ?>">
                        <?php if (!empty($error_text_max_length)) { ?>
                        <span class="help-block"><?php echo $error_text_max_length; ?></span>
                        <?php } ?>
                     </div>
                  </div>
                  <!-- INPUT DATA WAREHOUSE STATUS -->
                  <div class="form-group">
                     <label class="col-sm-4 control-label">
                     <?php echo $entry_data_warehouse_status; ?>
                     </label>
                     <div class="col-sm-4">
                        <div class="switch-toggle switch-2">
                           <input id="data_warehouse_status_enable"  name="data_warehouse_status" type="radio" value="1" <?php echo ($data_warehouse_status ? "checked" : ""); ?>>
                           <label for="data_warehouse_status_enable" onclick=""><?php echo $text_enabled; ?></label>
                           <input id="data_warehouse_status_disable" name="data_warehouse_status" type="radio" value="0" <?php echo (!$data_warehouse_status ? "checked" : ""); ?>>
                           <label for="data_warehouse_status_disable" onclick=""><?php echo $text_disabled; ?></label>
                           <a></a>
                        </div>
                     </div>
                  </div>

                  <!-- INPUT AUTOSIGN USER TO OPERATOR-->
                  <div class="form-group hidden">
                     <label class="col-sm-4 control-label">
                        <span class="has-tooltip" data-toggle="tooltip" data-placement="top" title="<?php echo $title_auto_user_sign; ?>">
                        <?php echo $entry_auto_user_sign; ?>
                        </span>
                     </label>
                     <div class="col-sm-4">
                        <div class="radio radio-inline">
                           <label>
                              <input type="radio" name="auto_user_sign" value="1"<?php echo ($auto_user_sign ? ' checked="checked"' : ''); ?>>
                              <?php echo $text_enabled; ?>
                           </label>
                        </div>
                        <div class="radio radio-inline">
                           <label>
                              <input type="radio" name="auto_user_sign" value="0"<?php echo (!$auto_user_sign ? ' checked="checked"' : ''); ?>>
                              <?php echo $text_disabled; ?>
                           </label>
                        </div>
                     </div>
                  </div>

                  <legend><i class="fa fa-cube"></i> <?php echo $text_plugin; ?></legend>

                  <!-- INPUT SMILEY_STATUS -->
                  <div class="form-group">
                     <label class="col-sm-4 control-label">
                     <?php echo $entry_smiley_status; ?>
                     </label>
                     <div class="col-sm-4">
                        <div class="switch-toggle switch-2">
                           <input id="smiley_status_enable"  name="smiley_status" type="radio" value="1" <?php echo ($smiley_status ? "checked" : ""); ?>>
                           <label for="smiley_status_enable" onclick=""><?php echo $text_enabled; ?></label>
                           <input id="smiley_status_disable" name="smiley_status" type="radio" value="0" <?php echo (!$smiley_status ? "checked" : ""); ?>>
                           <label for="smiley_status_disable" onclick=""><?php echo $text_disabled; ?></label>
                           <a></a>
                        </div>
                     </div>
                  </div>
                  <!-- INPUT BBCODE_STATUS -->
                  <div class="form-group">
                     <label class="col-sm-4 control-label">
                     <?php echo $entry_bbcode_status; ?>
                     </label>
                     <div class="col-sm-4">
                        <div class="switch-toggle switch-2">
                           <input id="bbcode_status_enable"  name="bbcode_status" type="radio" value="1" <?php echo ($bbcode_status ? "checked" : ""); ?>>
                           <label for="bbcode_status_enable" onclick=""><?php echo $text_enabled; ?></label>
                           <input id="bbcode_status_disable" name="bbcode_status" type="radio" value="0" <?php echo (!$bbcode_status ? "checked" : ""); ?>>
                           <label for="bbcode_status_disable" onclick=""><?php echo $text_disabled; ?></label>
                           <a></a>
                        </div>
                     </div>
                  </div>

                  <legend><i class="fa fa-user-times"></i> <?php echo $text_offline; ?></legend>

                  <!-- INPUT OFFLINE FORM -->
                  <div class="form-group">
                     <label class="col-sm-4 control-label">
                     <?php echo $entry_offline_form; ?>
                     </label>
                     <div class="col-sm-4">
                        <div class="switch-toggle switch-2">
                           <input id="offline_form_enable"  name="offline_form" type="radio" value="1" <?php echo ($offline_form ? "checked" : ""); ?>>
                           <label for="offline_form_enable" onclick=""><?php echo $text_enabled; ?></label>
                           <input id="offline_form_disable" name="offline_form" type="radio" value="0" <?php echo (!$offline_form ? "checked" : ""); ?>>
                           <label for="offline_form_disable" onclick=""><?php echo $text_disabled; ?></label>
                           <a></a>
                        </div>
                     </div>
                  </div>
                  <!-- INPUT ALERT_EMAILS -->
                  <div class="form-group">
                     <label for="input_offline_form_emails" class="col-sm-4 control-label">
                     <?php echo $entry_offline_form_emails; ?>
                     </label>
                     <div class="col-sm-4">
                        <input id="input_offline_form_emails" type="text" name="offline_form_emails" value="<?php echo $offline_form_emails; ?>" placeholder="<?php echo $text_entry_email; ?>" class="form-control">
                        <span class="help-block">
                           <?php echo $text_help_offline_form_emails; ?>
                        </span>
                     </div>
                  </div>

                  <legend><i class="fa fa-ban"></i> <?php echo $text_spam_filter; ?></legend>

                  <!-- INPUT SPAM FILTER STATUS -->
                  <div class="form-group">
                     <label class="col-sm-4 control-label">
                     <?php echo $entry_spam_filter_status; ?>
                     </label>
                     <div class="col-sm-4">
                        <div class="radio radio-inline">
                           <label>
                              <input type="radio" name="spam_filter_status" value="1"<?php echo ($spam_filter_status ? ' checked="checked"' : ''); ?>>
                              <?php echo $text_enabled; ?>
                           </label>
                        </div>
                        <div class="radio radio-inline">
                           <label>
                              <input type="radio" name="spam_filter_status" value="0"<?php echo (!$spam_filter_status ? ' checked="checked"' : ''); ?>>
                              <?php echo $text_disabled; ?>
                           </label>
                        </div>
                     </div>
                  </div>
                  <!-- INPUT SPAM FILTER SCORE LIMIT -->
                  <div class="form-group">
                     <label for="input_spam_filter_score_limit" class="col-sm-4 control-label">
                     <?php echo $entry_spam_filter_score_limit; ?>
                     </label>
                     <div class="col-sm-4">
                        <div class="input-group">
                           <input type="text" class="form-control" name="spam_filter_score_limit" value="<?php echo $spam_filter_score_limit; ?>" id="input_spam_filter_score_limit">
                           <div class="input-group-addon"><?php echo $text_count; ?></div>
                        </div>
                     </div>
                  </div>
                  <!-- INPUT SPAM FILTER PENALTY -->
                  <div class="form-group">
                     <label for="input_spam_filter_penalty" class="col-sm-4 control-label">
                     <span class="has-tooltip" data-toggle="tooltip" data-placement="top" title="<?php echo $title_spam_filter_penalty; ?>">
                     <?php echo $entry_spam_filter_penalty; ?>
                     </span>
                     </label>
                     <div class="col-sm-4">
                        <div class="input-group">
                           <input type="text" class="form-control" name="spam_filter_penalty" value="<?php echo $spam_filter_penalty; ?>" id="input_spam_filter_penalty">
                           <div class="input-group-addon">s</div>
                        </div>
                     </div>
                  </div>

                  <!-- INPUT SPAM FILTER RANGE -->
                  <div class="form-group">
                     <label for="input_spam_filter_range" class="col-sm-4 control-label">
                     <span class="has-tooltip" data-toggle="tooltip" data-placement="top" title="<?php echo $title_spam_filter_range; ?>">
                     <?php echo $entry_spam_filter_range; ?>
                     </span>
                     </label>
                     <div class="col-sm-4">
                        <div class="input-group">
                           <input type="text" class="form-control" name="spam_filter_range" value="<?php echo $spam_filter_range; ?>" id="input_spam_filter_range">
                           <div class="input-group-addon">s</div>
                        </div>
                     </div>
                  </div>

                  <!-- NEW CUSTOM UPDATE -->
                  <legend><i class="fa fa-eye"></i> <?php echo $text_appearance; ?></legend>

                  <!-- INPUT DRAGABLE BOX -->
                  <div class="form-group">
                     <label class="col-sm-4 control-label">
                     <?php echo $entry_dragable_widget_status; ?>
                     </label>
                     <div class="col-sm-4">
                        <div class="radio radio-inline">
                           <label>
                              <input type="radio" name="dragable_widget_status" value="1"<?php echo ($dragable_widget_status ? ' checked="checked"' : ''); ?>>
                              <?php echo $text_enabled; ?>
                           </label>
                        </div>
                        <div class="radio radio-inline">
                           <label>
                              <input type="radio" name="dragable_widget_status" value="0"<?php echo (!$dragable_widget_status ? ' checked="checked"' : ''); ?>>
                              <?php echo $text_disabled; ?>
                           </label>
                        </div>
                     </div>
                  </div>

                  <!-- INPUT THEME -->
                  <div class="form-group">
                     <label class="col-sm-4 control-label">
                     <?php echo $entry_widget_theme; ?>
                     </label>
                     <div class="col-sm-4">
                        <select name="widget_theme" class="form-control">
                           <option value=""><?php echo $text_default; ?></option>
                           <?php foreach ($themes as $theme) { ?>
                              <option value="<?php echo $theme; ?>"<?php echo ($widget_theme == $theme ? " selected" :  ""); ?>><?php echo $theme; ?></option>
                           <?php } ?>
                        </select>
                        <?php if(isset($error_theme)) { ?>
                           <div class="help-text text-warning">
                              <?php echo $error_theme; ?>
                           </div>
                        <?php } ?>
                     </div>
                  </div>

                  <!-- INPUT STICK -->
                  <div class="form-group">
                     <label class="col-sm-4 control-label">
                     <?php echo $entry_stick_position; ?>
                     </label>
                     <div class="col-sm-4">
   
                        <div class="radio">
                           <label>
                              <input type="radio" name="stick_position" value="right"<?php echo ($stick_position == "right" ? ' checked="checked"' : ''); ?>>
                              <?php echo $text_stick_right; ?>
                           </label>
                        </div>
                        <div class="radio">
                           <label>
                              <input type="radio" name="stick_position" value="left"<?php echo ($stick_position == "left" ? ' checked="checked"' : ''); ?>>
                              <?php echo $text_stick_left; ?>
                           </label>
                        </div>
                        <div class="radio">
                           <label>
                              <input type="radio" name="stick_position" value="bottom"<?php echo ($stick_position == "bottom" ? ' checked="checked"' : ''); ?>>
                              <?php echo $text_stick_bottom; ?>
                           </label>
                        </div>

                     </div>
                  </div>

                  <!-- INPUT PAGE TITLE ALERT -->
                  <div class="form-group">
                     <label class="col-sm-4 control-label">
                        <span class="has-tooltip" data-toggle="tooltip" data-placement="top" title="<?php echo $title_page_title_alert; ?>">
                        <?php echo $entry_page_title_alert; ?>
                        </span>
                     </label>
                     <div class="col-sm-4">
                        <div class="radio radio-inline">
                           <label>
                              <input type="radio" name="page_title_alert" value="1"<?php echo ($page_title_alert ? ' checked="checked"' : ''); ?>>
                              <?php echo $text_enabled; ?>
                           </label>
                        </div>
                        <div class="radio radio-inline">
                           <label>
                              <input type="radio" name="page_title_alert" value="0"<?php echo (!$page_title_alert ? ' checked="checked"' : ''); ?>>
                              <?php echo $text_disabled; ?>
                           </label>
                        </div>
                     </div>
                  </div>


                  <!-- INPUT PAGE TITLE ALERT -->
                  <div class="form-group">
                     <label class="col-sm-4 control-label">
                        <span class="has-tooltip" data-toggle="tooltip" data-placement="top" title="<?php echo $title_custom_message_slidebar; ?>">
                        <?php echo $entry_custom_message_slidebar; ?>
                        </span>
                     </label>
                     <div class="col-sm-4">
                        <div class="radio radio-inline">
                           <label>
                              <input type="radio" name="custom_message_slidebar" value="1"<?php echo ($custom_message_slidebar ? ' checked="checked"' : ''); ?>>
                              <?php echo $text_enabled; ?>
                           </label>
                        </div>
                        <div class="radio radio-inline">
                           <label>
                              <input type="radio" name="custom_message_slidebar" value="0"<?php echo (!$custom_message_slidebar ? ' checked="checked"' : ''); ?>>
                              <?php echo $text_disabled; ?>
                           </label>
                        </div>
                     </div>
                  </div>
               </div>

               <!-- TAB ADMIN -->
               <div class="tab-pane" id="tab-admin">
                  
                        <!-- INPUT REFRESH_RATE -->
                        <div class="form-group<?php echo (!empty($error_admin_refresh_rate) ? " has-error" : ""); ?>">
                           <label for="input_admin_refresh_rate" class="col-sm-4 control-label required">
                           <span class="has-tooltip" data-toggle="tooltip" data-placement="top" title="<?php echo $title_refresh_rate; ?>">
                           <?php echo $entry_refresh_rate; ?>
                           </span>
                           </label>
                           <div class="col-sm-4">
                              <div class="input-group">
                                 <input type="text" class="form-control" name="admin_refresh_rate" value="<?php echo $admin_refresh_rate; ?>" id="input_admin_refresh_rate">
                                 <div class="input-group-addon">ms</div>
                              </div>
                              <?php if (!empty($error_admin_refresh_rate)) { ?>
                              <span class="help-block"><?php echo $error_admin_refresh_rate; ?></span>
                              <?php } ?>
                           </div>
                        </div>
                        <!-- INPUT ADMIN INACTIVE TIMEOUT -->
                        <div class="form-group<?php echo (!empty($error_admin_inactive_timeout) ? " has-error" : ""); ?>">
                           <label class="col-sm-4 control-label required">
                           <span class="has-tooltip" data-toggle="tooltip" data-placement="top" title="<?php echo $title_admin_inactive_timeout; ?>">
                           <?php echo $entry_admin_inactive_timeout; ?>
                           </span>
                           </label>
                           <div class="col-sm-4">
                              <div class="input-group">
                                 <input type="text" class="form-control" name="admin_inactive_timeout" value="<?php echo $admin_inactive_timeout; ?>">
                                 <div class="input-group-addon">s</div>
                              </div>
                              <?php if (!empty($error_admin_inactive_timeout)) { ?>
                              <span class="help-block"><?php echo $error_admin_inactive_timeout; ?></span>
                              <?php } ?>
                           </div>
                        </div>
                        <!-- INPUT ADMIN INACTIVE ACTION -->
                        <div class="form-group">
                           <label class="col-sm-4 control-label">
                           <span class="has-tooltip" data-toggle="tooltip" data-placement="top" title="<?php echo $title_admin_inactive_action; ?>">
                           <?php echo $entry_admin_inactive_action; ?>
                           </span>
                           </label>
                           <div class="col-sm-4">
                              <select name="admin_inactive_action" class="form-control selectpicker">
                                 <option value="-1"><?php echo $text_logout; ?></option>
                                 <?php if($statuses) { ?>
                                 <optgroup label="<?php echo $text_toggle_status; ?>">
                                    <?php foreach ($statuses as $status) { ?>
                                    <option value="<?php echo $status['status_id']; ?>"><?php echo $status['name']; ?></option>
                                    <?php } ?>
                                 </optgroup>
                                 <?php } ?>
                              </select>
                           </div>
                        </div>
                        <legend><?php echo $text_sounds; ?></legend>
                        <table class="table table-hover table-bordered">
                           <thead>
                              <tr>
                                 <th><?php echo $column_filename; ?></th>
                                 <th class="active text-center"><small><?php echo $column_new_message; ?></small></th>
                                 <th class="active text-center"><small><?php echo $column_message_sent; ?></small></th>
                                 <th class="active text-center"><small><?php echo $column_user_logged; ?></small></th>
                                 <th class="active text-center"><small><?php echo $column_user_logout; ?></small></th>
                                 <th class="active text-center"><small><?php echo $column_special_function; ?></small></th>
                                 <th class="text-right"><?php echo $column_test_sound; ?></th>
                              </tr>
                           </thead>
                           <tbody>
                              <tr>
                                 <td>
                                    <span class="text-danger"><?php echo $text_off; ?></span>
                                 </td>
                                 <td class="active text-center">
                                    <input type="radio" name="admin_sound_new_message" value=""<?php echo (!$admin_sound_new_message ? " checked" : ""); ?>>
                                 </td>
                                 <td class="active text-center">
                                    <input type="radio" name="admin_sound_message_sent" value=""<?php echo (!$admin_sound_message_sent ? " checked" : ""); ?>>
                                 </td>
                                 <td class="active text-center">
                                    <input type="radio" name="admin_sound_user_logged" value=""<?php echo (!$admin_sound_user_logged ? " checked" : ""); ?>>
                                 </td>
                                 <td class="active text-center">
                                    <input type="radio" name="admin_sound_user_logout" value=""<?php echo (!$admin_sound_user_logout ? " checked" : ""); ?>>
                                 </td>
                                 <td class="active text-center">
                                    <input type="radio" name="admin_sound_special" value=""<?php echo (!$admin_sound_special ? " checked" : ""); ?>>
                                 </td>
                                 <td class="text-right">
                                 </td>
                              </tr>
                              <?php $i = 1; ?>
                              <?php foreach ($sounds as $sound) { ?>
                              <tr>
                                 <td><?php echo $sound; ?></td>
                                 <td class="active text-center">
                                    <input type="radio" name="admin_sound_new_message" value="<?php echo $sound; ?>"<?php echo ($admin_sound_new_message == $sound ? " checked" : ""); ?>>
                                 </td>
                                 <td class="active text-center">
                                    <input type="radio" name="admin_sound_message_sent" value="<?php echo $sound; ?>"<?php echo ($admin_sound_message_sent == $sound ? " checked" : ""); ?>>
                                 </td>
                                 <td class="active text-center">
                                    <input type="radio" name="admin_sound_user_logged" value="<?php echo $sound; ?>"<?php echo ($admin_sound_user_logged == $sound ? " checked" : ""); ?>>
                                 </td>
                                 <td class="active text-center">
                                    <input type="radio" name="admin_sound_user_logout" value="<?php echo $sound; ?>"<?php echo ($admin_sound_user_logout == $sound ? " checked" : ""); ?>>
                                 </td>
                                 <td class="active text-center">
                                    <input type="radio" name="admin_sound_special" value="<?php echo $sound; ?>"<?php echo ($admin_sound_special == $sound ? " checked" : ""); ?>>
                                 </td>
                                 <td class="text-right">
                                    <audio id="sound-<?php echo $i; ?>" src="../image/sounds/<?php echo $sound; ?>">
                                       <p>Your browser does not support the <code>audio</code> element</p>
                                    </audio>
                                    <button onclick="document.getElementById('sound-<?php echo $i; ?>').play();" type="button" class="btn btn-default btn-sm"> <i class="fa fa-play"></i> </button>
                                 </td>
                              </tr>
                              <?php $i++; ?>
                              <?php } ?>
                           </tbody>
                        </table>

               </div>

               <!-- TAB STORE -->
               <div class="tab-pane" id="tab-store">
                        <!-- INPUT REFRESH_RATE -->
                        <div class="form-group<?php echo (!empty($error_store_refresh_rate) ? " has-error" : ""); ?>">
                           <label for="input_store_refresh_rate" class="col-sm-4 control-label required">
                           <span class="has-tooltip" data-toggle="tooltip" data-placement="top" title="<?php echo $title_refresh_rate; ?>">
                           <?php echo $entry_refresh_rate; ?>
                           </span>
                           </label>
                           <div class="col-sm-4">
                              <div class="input-group">
                                 <input type="text" class="form-control" name="store_refresh_rate" value="<?php echo $store_refresh_rate; ?>" id="input_store_refresh_rate">
                                 <div class="input-group-addon">ms</div>
                              </div>
                              <?php if (!empty($error_store_refresh_rate)) { ?>
                              <span class="help-block"><?php echo $error_store_refresh_rate; ?></span>
                              <?php } ?>
                           </div>
                        </div>

                        <!-- INPUT STORE INACTIVE TIMEOUT -->
                        <div class="form-group<?php echo (!empty($error_store_inactive_timeout) ? " has-error" : ""); ?>">
                           <label class="col-sm-4 control-label required">
                           <span class="has-tooltip" data-toggle="tooltip" data-placement="top" title="<?php echo $title_store_inactive_timeout; ?>">
                           <?php echo $entry_store_inactive_timeout; ?>
                           </span>
                           </label>
                           <div class="col-sm-4">
                              <div class="input-group">
                                 <input type="text" class="form-control" name="store_inactive_timeout" value="<?php echo $store_inactive_timeout; ?>">
                                 <div class="input-group-addon">s</div>
                              </div>
                              <?php if (!empty($error_store_inactive_timeout)) { ?>
                              <span class="help-block"><?php echo $error_store_inactive_timeout; ?></span>
                              <?php } ?>
                           </div>
                        </div>
                        <!-- INPUT CART UPDATE INTERVAL -->
                        <div class="form-group">
                           <label for="input_cart_update_interval" class="col-sm-4 control-label required">
                           <span class="has-tooltip" data-toggle="tooltip" data-placement="top" title="<?php echo $title_cart_update_interval; ?>">
                           <?php echo $entry_cart_update_interval; ?>
                           </span>
                           </label>
                           <div class="col-sm-4">
                              <div class="input-group">
                                 <input type="text" class="form-control" name="cart_update_interval" value="<?php echo $cart_update_interval; ?>" id="input_cart_update_interval">
                                 <div class="input-group-addon"><?php echo $text_iteration; ?></div>
                              </div>
                           </div>
                        </div>
                        <!-- INPUT STORE_HEADING_LANGUAGE -->
                        <div class="form-group">
                           <label class="col-sm-4 control-label">
                           <?php echo $entry_store_heading_title; ?>
                           </label>
                           <div class="col-sm-4">
                              <?php foreach ($languages as $language) { ?>
                              <div class="input-group">
                                 <div class="input-group-addon">
                                    <img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" alt="<?php echo $language['name']; ?>" />  
                                 </div>
                                 <input type="text" class="form-control" name="store_heading_title[<?php echo $language['language_id']; ?>]" value="<?php echo (isset($store_heading_title[$language['language_id']]) ? $store_heading_title[$language['language_id']] : ''); ?>">
                              </div>
                              <?php } ?>
                              <span class="help-block">
                              <?php echo $text_accepting_html; ?>
                              </span>
                           </div>
                        </div>
                        <legend><?php echo $text_sounds; ?></legend>
                        <table class="table table-hover table-bordered">
                           <thead>
                              <tr>
                                 <th><?php echo $column_filename; ?></th>
                                 <th class="active text-center"><small><?php echo $column_new_message; ?></small></th>
                                 <th class="active text-center"><small><?php echo $column_message_sent; ?></small></th>
                                 <th class="active text-center"><small><?php echo $column_operator_logged; ?></small></th>
                                 <th class="active text-center"><small><?php echo $column_operator_logout; ?></small></th>
                                 <th class="active text-center"><small><?php echo $column_special_function; ?></small></th>
                                 <th class="text-right"><?php echo $column_test_sound; ?></th>
                              </tr>
                           </thead>
                           <tbody>
                              <tr>
                                 <td>
                                    <span class="text-danger"><?php echo $text_off; ?></span>
                                 </td>
                                 <td class="active text-center">
                                    <input type="radio" name="store_sound_new_message" value=""<?php echo (!$store_sound_new_message ? " checked" : ""); ?>>
                                 </td>
                                 <td class="active text-center">
                                    <input type="radio" name="store_sound_message_sent" value=""<?php echo (!$store_sound_message_sent ? " checked" : ""); ?>>
                                 </td>
                                 <td class="active text-center">
                                    <input type="radio" name="store_sound_operator_logged" value=""<?php echo (!$store_sound_operator_logged ? " checked" : ""); ?>>
                                 </td>
                                 <td class="active text-center">
                                    <input type="radio" name="store_sound_operator_logout" value=""<?php echo (!$store_sound_operator_logout ? " checked" : ""); ?>>
                                 </td>
                                 <td class="active text-center">
                                    <input type="radio" name="store_sound_special" value=""<?php echo (!$store_sound_special ? " checked" : ""); ?>>
                                 </td>
                                 <td class="text-right">
                                 </td>
                              </tr>
                              <?php $i = 1; ?>
                              <?php foreach ($sounds as $sound) { ?>
                              <tr>
                                 <td><?php echo $sound; ?></td>
                                 <td class="active text-center">
                                    <input type="radio" name="store_sound_new_message" value="<?php echo $sound; ?>"<?php echo ($store_sound_new_message == $sound ? " checked" : ""); ?>>
                                 </td>
                                 <td class="active text-center">
                                    <input type="radio" name="store_sound_message_sent" value="<?php echo $sound; ?>"<?php echo ($store_sound_message_sent == $sound ? " checked" : ""); ?>>
                                 </td>
                                 <td class="active text-center">
                                    <input type="radio" name="store_sound_operator_logged" value="<?php echo $sound; ?>"<?php echo ($store_sound_operator_logged == $sound ? " checked" : ""); ?>>
                                 </td>
                                 <td class="active text-center">
                                    <input type="radio" name="store_sound_operator_logout" value="<?php echo $sound; ?>"<?php echo ($store_sound_operator_logout == $sound ? " checked" : ""); ?>>
                                 </td>
                                 <td class="active text-center">
                                    <input type="radio" name="store_sound_special" value="<?php echo $sound; ?>"<?php echo ($store_sound_special == $sound ? " checked" : ""); ?>>
                                 </td>
                                 <td class="text-right">
                                    <button onclick="document.getElementById('sound-<?php echo $i; ?>').play();" type="button" class="btn btn-default btn-sm"> <i class="fa fa-play"></i> </button>
                                 </td>
                              </tr>
                              <?php $i++; ?>
                              <?php } ?>
                           </tbody>
                        </table>
               </div>
            </div>
         </form>
      </div>
   </div>
</div>
<script type="text/javascript">
   $(function(){
    <?php if($sample_emoticon) { ?>
    $('#input_absolute_path').on("change", function(){
      var img = $('#abs_path_verify');
      img.attr("src", $(this).val() + img.data("src"));
    });
    <?php } ?>
   });
</script>
<?php echo $footer; ?>