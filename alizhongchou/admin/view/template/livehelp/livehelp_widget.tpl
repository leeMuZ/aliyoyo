<div id="livehelp" class="bar-tacked">
   <!-- WRAPPER FOR POPUP BOXES -->
   <div id="lh-popup">    
   </div>
   <!-- MAIN MODULE TOOLBAR -->
   <div id="lh-bar" class="">
      <!-- Module Logo -->
      <div class="lh-bar-logo">
         <i class="icon-bubbles icon-2x"></i> &nbsp;&nbsp; <?php echo $heading_title; ?>
      </div>
      <!-- BAR NAME LIST -->
      <div class="lh-bar-names">
         <ul id="lh-name-list" class="lh-name-list">
            <?php if($is_logged && $threads) { ?>
            <?php foreach ($threads as $thread) { ?>
            <?php 
               $classes = array(); 
               if(!$thread['is_online']) $classes[] = "lh-closed";
               if($thread['customer_id']) $classes[] = "lh-registred";
               ?>
            <li id="lh-name-<?php echo $thread['thread_id']; ?>" class="lh-name">
               <a href="javascript:register_popup('<?php echo $thread['thread_id']; ?>', '<?php echo $thread['user_name']; ?>');" data-thread-id="<?php echo $thread['thread_id']; ?>" class="btn <?php echo implode(" ", $classes); ?>">
               <?php echo $thread['user_name']; ?> <span></span>
               </a>
            </li>
            <?php } ?>
            <?php } ?>
         </ul>
      </div>
      <!-- BAR TOOLS -->
      <div class="lh-bar-toolbox">
         <!-- SETTING BUTTONs -->
         <button id="livehelp-bar-tack" type="button" class="btn btn-link pull-right" title="" data-toggle="tooltip" data-original-title="<?php echo $title_tack_toggle; ?>"><i class="icon-pushpin"></i></button>
         <?php if ($is_logged) { ?>
         <button id="livehelp-sound-toggle" type="button" onclick="javascript:LivehelpChat.toggleSound(event);" class="btn btn-link pull-right" title="" data-toggle="tooltip" data-original-title="<?php echo $title_sound_toggle; ?>"><i class="icon-volume-high"></i></button>
         <?php } ?>
         <div class="dropup pull-right">
            <button class="btn btn-link dropdown-toggle" type="button" data-toggle="dropdown">
            <?php if ($is_logged) { ?>
            <span id="lh-status-index" class="lh-online"><?php echo $text_online; ?></span>
            <?php } else { ?>
            <span id="lh-status-index" class="lh-offline"><?php echo $text_offline; ?></span>
            <?php } ?>
            <i class="icon-caret-up"></i>
            </button>
            <ul class="dropdown-menu pull-right keep-on-click-dropdown" style="margin-right:15px;">
               <li class="dropdown-header"><?php echo $text_current_state; ?></li>
               <li class="dropdown-header">
                  <button id="livehelp-sign-in" type="button" class="btn btn-success btn-sm"<?php echo ($is_logged ? ' disabled="disabled"' : ''); ?>><?php echo $button_sign_in; ?></button>
                  <button id="livehelp-sign-out" type="button" class="btn btn-danger btn-sm"<?php echo (!$is_logged ? ' disabled="disabled"' : ''); ?>><?php echo $button_sign_out; ?></button>
               </li>
               <?php if($is_logged) { ?>
               <li role="separator" class="divider"></li>
               <li class="dropdown-header"><?php echo $text_status; ?></li>
               <li class="dropdown-header">
                  <select name="lh_status_id" class="lh-form-select">
                     <option value=""></option>
                     <?php foreach ($statuses as $status) { ?>
                     <option value="<?php echo $status['status_id']; ?>"<?php echo ($status_id == $status['status_id'] ? ' selected' : ''); ?>><?php echo $status['name']; ?></option>
                     <?php } ?>
                  </select>
               </li>
               <?php } ?>
            </ul>
         </div>
      </div>
   </div>
</div>
<?php if($is_logged) { ?>
<div id="lh-modal-dialog"></div>
<?php if ($setting['smiley_status']) { ?>
<div id="lh-smile-list" style="display:none;">
   <div class="emoticon-list">
      <?php foreach ($emoticons as $key => $emoticon) { ?>
      <a onclick="javascript:LivehelpChat.insertEmoticon(this, '<?php echo (addslashes($emoticon[0])); ?>');" class="emoticon-item emote-<?php echo $key; ?>"></a>
      <?php } ?>
      <div style="clear:both;"></div>
   </div>
</div>
<?php } ?>
<?php if ($setting['bbcode_status']) { ?>
<div id="lh-bbcode-list" style="display:none;">
   <div class="bbcode-list">
      <a onclick="javascript:LivehelpChat.insertBBCode(this, 'b');" title="<?php echo $title_bold; ?>"><i class="icon-bold"></i></a>
      <a onclick="javascript:LivehelpChat.insertBBCode(this, 'i');" title="<?php echo $title_italic; ?>"><i class="icon-italic"></i></a>
      <a onclick="javascript:LivehelpChat.insertBBCode(this, 'u');" title="<?php echo $title_underline; ?>"><i class="icon-underline"></i></a>
      <a onclick="javascript:LivehelpChat.insertBBCode(this, 'url');" title="<?php echo $title_link; ?>"><i class="icon-link"></i></a>
      <a onclick="javascript:LivehelpChat.insertBBCode(this, 'img');" title="<?php echo $title_image; ?>"><i class="icon-image"></i></a>
      <a onclick="javascript:LivehelpChat.insertBBCode(this, 'youtube');" title="<?php echo $title_youtube; ?>"><i class="icon-youtube"></i></a>
      <div style="clear:both;"></div>
   </div>
</div>
<?php } ?>
<ul id="lh-thread-action" style="display:none;">
   <?php if(count($operators)) { ?>
   <li class="dropdown-header lh-hidden-on-closed"><?php echo $text_toggle_operator; ?></li>
   <li class="dropdown-header lh-hidden-on-closed">
      <select onchange="javascript:LivehelpChat.toggleOperator(this);" class="lh-action-toggle-operator">
         <option value=""></option>
         <?php foreach ($operators as $operator) { ?>
         <option value="<?php echo $operator['operator_id']; ?>"><?php echo ($operator['name'] ? $operator['name'] : $operator['username']); ?></option>
         <?php } ?>
      </select>
   </li>
   <li role="separator" class="divider lh-hidden-on-closed"></li>
   <?php } ?>
   <li class="dropdown-header"><?php echo $text_thread_manage; ?></li>
   <li><a onclick="javascript:LivehelpChat.insertAction(this, 'kick');" class="lh-action lh-action-kick"><?php echo $text_kick; ?></a></li>
   <li><a onclick="javascript:LivehelpChat.insertAction(this, 'ban');" class="lh-action lh-action-ban"><?php echo $text_ban; ?></a></li>
   <li class="lh-visible-on-closed"><a onclick="javascript:LivehelpChat.insertAction(this, 'remove');" class="lh-action lh-action-remove"><i class="fa fa-ban"></i> <?php echo $text_remove; ?></a></li>
</ul>
<?php } ?>
<script type="text/javascript">
   var operation_url = 'index.php?route=livehelp/livehelp_widget/operation&token=<?php echo $token; ?>';
   // Tack bar
   var tackedBar = localStorage.getItem("lh_bar_tacked");
   if (tackedBar == "false") $('#livehelp').removeClass('bar-tacked');
   $(function() {
      $('#lh-name-list').responsivebar();
      <?php if ($is_logged) { ?>
      var threads = {};
      <?php foreach ($threads as $thread) { ?>
      threads[<?php echo $thread['thread_id']; ?>] = {
         username: '<?php echo $thread['user_name']; ?>',
         customer_id: <?php echo $thread['customer_id']; ?>,
         customer_link: '<?php echo $thread['customer_link']; ?>',
         date_added: '<?php echo $thread['date_added']; ?>',
         date_modified: '<?php echo $thread['date_modified']; ?>',
         date_closed: <?php echo (int)$thread['date_closed']; ?>,
         user_readed: <?php echo $thread['user_readed']; ?>,
         operator_readed: <?php echo $thread['operator_readed']; ?>,
         last_id: 0,
         user_ip: '<?php echo $thread['user_ip']; ?>',
         user_agent: '<?php echo $thread['user_agent']; ?>',
         user_cart: <?php echo json_encode($thread['user_cart']); ?>,
         referer: '<?php echo $thread['referer']; ?>',
         language_id: <?php echo $thread['language_id']; ?>,
         ping_diff: <?php echo (int)$thread['ping_diff']; ?>,
         is_online: <?php echo (int)$thread['is_online']; ?>,
      }
      <?php } ?>
      LivehelpChat.init({
            timeout: <?php echo (int)$setting['admin_refresh_rate']; ?>,
            textMaxLength: <?php echo (int)$setting['text_max_length']; ?>,
            ajaxUrl: operation_url,
            soundAlert: {
               newMessage: <?php echo ($setting['admin_sound_new_message'] ? "'" . $setting['admin_sound_new_message'] . "'" : "null"); ?>,
               messageSent: <?php echo ($setting['admin_sound_message_sent'] ? "'" . $setting['admin_sound_message_sent'] . "'" : "null"); ?>,
               userLogged: <?php echo ($setting['admin_sound_user_logged'] ? "'" . $setting['admin_sound_user_logged'] . "'" : "null"); ?>,
               userLogout: <?php echo ($setting['admin_sound_user_logout'] ? "'" . $setting['admin_sound_user_logout'] . "'" : "null"); ?>,
               special: <?php echo ($setting['admin_sound_special'] ? "'" . $setting['admin_sound_special'] . "'" : "null"); ?>,
            },
            languageId: <?php echo $language_id; ?>,
            languageCode: '<?php echo $language_code; ?>',
         },
         threads,
         <?php echo json_encode($js_language); ?>
      );
      // Handler for toggling admin status
      $('select[name="lh_status_id"]').on("change", function() {
         var $select = $(this);
         $select.prop('disabled', true);
         $.post(operation_url, {
            operation: "changeStatus",
            status_id: this.value
         }, function(data) {
            if (data['success']) alert(data['success'], "success", 10000);
            $select.prop('disabled', false);
         }, "json");
      });
      <?php } ?>
      $('#livehelp-bar-tack').bind("click", function() {
         $('#livehelp').toggleClass('bar-tacked');
         localStorage.setItem("lh_bar_tacked", $('#livehelp').hasClass('bar-tacked'));
      });
      // Login \/ logout
      $('#livehelp-sign-in').click(function() {
         $.post(operation_url, {
            operation: "login"
         }, function(data) {
            location.reload();
         }, "json");
      });
      $('#livehelp-sign-out').click(function() {
         // confirm dialog
         var result = confirm("<?php echo $text_signout_confirm; ?>");
         if (result) {
            $.post(operation_url, {
               operation: "logout"
            }, function(data) {
               location.reload();
            }, "json");
         }
      });
   });
</script>