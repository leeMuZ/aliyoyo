var LivehelpChat = {
   // Settings
   setting: {
      sound: 1,
      soundFolder: "../image/sounds/",
      soundAlert: {
         newMessage: null,
         messageSent: null,
         userLogged: null,
         userLogout: null,
         special: null
      },
      smiley: 0,
      textMaxLength: 500,
      ajaxUrl: null,
      timeout: 5000,
      languageId: 1,
      languageCode: "en",
      saveOpened: false,
   },
   // Languages
   language: {
      en: {
         text_operator_signed: "Operator has joined into your chat",
         text_username: "Username:",
         text_ip: "IP address:",
         text_user_agent: "User agent:",
         text_referer: "Referer:",
         text_customer: "Customer:",
         text_registred: "Registred user",
         text_not_registred: "Visitor",
         text_date_added: "Date added:",
         text_closed: "Closed",
         text_ban_success: "user was successfuly banned!",
         text_last_activity: "Last activity:",
         text_before: "Before",
         text_user_away: "User is already %s long away or went offline",
         text_user_back_online: "User is again online",
         text_right_now: "Right now",
         text_user_cart: "Customer Cart",
         text_cart_items: "item(s)",
         text_cart_total: "Cart total",
         text_in_stock: "In Stock",
         text_out_stock: "Out Stock",
         text_product_id: "Product ID",
         text_product_name: "Name",
         text_product_qty: "Quantity",
         text_empty_cart: "Customer\'s shopping cart is empty",
      }
   },
   threads: {},
   onBootUpdated: 0,
   timer: null,
   openThread: [], // What popup box are open for load messeages into them
   // ------------------------------------------------------------------ \\
   // ---------------      		 METHODS     		     --------------- \\
   // ------------------------------------------------------------------ \\
   // -----------------
   // BOOT & CORE FUNCTIONS
   // -----------------
   init: function(settings, threads, language) {
      if (typeof settings['lastReaded'] !== 'undefined') this.lastReadedId = settings['lastReaded'];
      this.setting = $.extend({}, this.setting, settings || {});
      this.threads = $.extend({}, this.threads, threads || {});
      this.language = $.extend({}, this.language, language || {});
      
      try {
         this.initSessionVariables();
         this.initEventListener();
         this.verifyInit();
         if (!this.onBootUpdated) {
            this.makeRequest(null);
            this.onBootUpdated = 1;
         }
         this.startTimer();
      } catch (e) {
         console.log(e);
      }
   },
   initSessionVariables: function() {
      if (localStorage.getItem("sound") !== null) {
         this.setting['sound'] = parseInt(localStorage.getItem("sound"));
         if (this.setting['sound'])
            $('#livehelp-sound-toggle i').removeClass("icon-volume-mute").addClass("icon-volume-high");
         else
            $('#livehelp-sound-toggle i').removeClass("icon-volume-high").addClass("icon-volume-mute");
      }
      if (this.setting['saveOpened'] && localStorage.getItem("openThread") !== null) {
         this.openThread = localStorage.getItem("openThread").split(",");
         // Make them open - click on them
         for (var key in this.openThread) {
            $('#lh-name-' + this.openThread[key] + " a").trigger("click");
         };
      }
   },
   verifyInit: function() {
      if (!this.setting.ajaxUrl ||
         this.setting.timeout < 1000) {
         throw new Error("Major variables not specified!");
      }
      if (!this.setting.soundAlert['newMessage'] &&
         !this.setting.soundAlert['messageSent'] &&
         !this.setting.soundAlert['userLogged'] &&
         !this.setting.soundAlert['userLogout'] &&
         !this.setting.soundAlert['special']) {
         this.setting['sound'] = 0;
         localStorage.removeItem("sound")
      }
      if (typeof this.language[this.setting['languageCode']] === 'undefined') {
         throw new Error("Unsupported language code");
         this.setting['languageCode'] = "en";
      }
   },
   getLang: function(key, replace) {
      if (this.language[this.setting['languageCode']][key]) {
         return (replace ? this.language[this.setting['languageCode']][key].replace("%s", replace) : this.language[this.setting['languageCode']][key]);
      } else {
         return key;
      }
   },
   // Spustí interval automatické aktualizace
   startTimer: function() {
      var _t = this,
         y = 0;
      _t.timer = setInterval(function() {
         if (!y) _t.makeRequest(null);
         y++;
      }, _t.setting.timeout);
   },
   // Binding all listens
   initEventListener: function() {
      var _t = this;
      $('#lh-popup').delegate('.lh-textarea-input', "keydown", function(event) {
         var _txt = $(this);
         // Make new line SHIFT + ENTER
         if (event.keyCode == 13 && event.shiftKey) {
            var content = _txt.val();
            _txt.value = content + "\n";
            _t.changeTextareaHeight(_txt);
            event.stopPropagation();
         }
         // SUBMIT TEXTAREA
         else if (event.keyCode == 13 || event.keyCode == 10) {
            event.preventDefault();
            if (!_txt.val().replace("\n", "").trim().length) return false; // prevent sending empty string
            _t.makeRequest("new_msg", {
               msg_thread_id: parseInt(_txt.attr("name")),
               msg_text: _txt.val(),
            });
            _t.clearText(_txt); // also prevent before multiple submiting
         }
         // VERIFY STRING LENGTH AND AUTO TEXTAREA EXPAND
         else {
            if (this.clientHeight < this.scrollHeight)
               _t.changeTextareaHeight(_txt);
            if (_t.setting['textMaxLength'] && _txt.val().length > _t.setting['textMaxLength']) {
               _txt.val(_txt.val().substr(0, _t.setting['textMaxLength']));
               return;
            }
         }
      }).delegate('.lh-thread-get-info', "click", function(e) {
         _t.getTreadInfo(parseInt($(this).closest('.popup-box').data('thread-id')));
      });
      // Catching focus and open box
      $('#lh-name-list').delegate(".lh-name > a", "click", function() {
         var thread_id = parseInt($(this).data("thread-id")),
            operation = null,
            data = {};
         if ($(this).hasClass('lh-new-msg') && (!_t.threads[thread_id]['last_id'] || (_t.threads[thread_id]['last_id'] > _t.threads[thread_id]['operator_readed']))) {
            operation = "update_readed";
            data['update_readed_thread'] = thread_id;
            data['update_readed_id'] = _t.threads[thread_id]['last_id'];
            //_t.threads[thread_id]['operator_readed'] = _t.threads[thread_id]['last_id'];
         }
         _t.setThreadOpen(thread_id);
         _t.removeActiveThreadNode(thread_id);
         _t.makeRequest(operation, data);
      });
      $('#lh-popup').delegate(".popup-box-active", "click", function() {
         var thread_id = parseInt($(this).data("thread-id")),
            data = {};
         data['update_readed_thread'] = thread_id;
         data['update_readed_id'] = _t.threads[thread_id]['last_id'];
         _t.removeActiveThreadNode(thread_id);
         _t.makeRequest("update_readed", data);
      });
   },
   // -----------------
   // SPECIAL FUNCTIONS
   // -----------------
   logout: function() {
      $.post(this.setting.ajaxUrl, {
         operation: "signout"
      }, function() {
         location.reload();
      }, "json");
   },
   toggleOperator: function(el) {
      if (!el.value) return;
      $(el).closest('.dropdown').trigger("click");
      var data = {
         toggle_operator: {
            operator_id: el.value,
            thread_id: $(el).closest('.popup-box').data('thread-id')
         }
      };
      this.makeRequest("toggle_operator", data);
      this.closeThread(data.toggle_operator['thread_id']);
      $(el).closest('.dropdown').remove();
   },
   insertAction: function(el, action, data) {
      var _t = this,
         operation, thread_id = parseInt($(el).closest('.popup-box').data('thread-id'));
      if (typeof data === 'undefined') data = {};
      switch (action) {
         case "kick":
            operation = "action_kick";
            data['kicked_thread_id'] = thread_id;
            _t.makeRequest(operation, data);
            break;
         case "ban":
            operation = "action_ban";
            data['baned_thread_id'] = thread_id;
            str = prompt(_t.getLang('entry_comment'), "");
            if (str) {
               data['baned_comment'] = str;
            } else {
               data['baned_comment'] = '';
            }
            _t.makeRequest(operation, data);
            break;
         case "remove":
            if (!_t.threads[thread_id]['date_closed']) return;
            operation = "action_remove";
            data['remove_thread_id'] = thread_id;
            _t.makeRequest(operation, data);
            _t.removeThread(thread_id);
            _t.playSound('removed');
            break;
         default:
            operation = action;
            _t.makeRequest(operation, data);
            break;
      }
   },
   makeRequest: function(method, data) {
      var _t = this,
         $textarea;
      if (typeof data === 'undefined') data = new Object;
      clearInterval(_t.timer);
      _t.timer = null;
      data['operation'] = method || null;
      try {
         data['threads'] = new Array;
         for (var key in _t.openThread) {
            var thread_data, t_id = parseInt(_t.openThread[key]);
            thread_data = {
               thread_id: t_id,
               last_id: _t.threads[t_id]['last_id'],
               //last_readed : _t.threads[t_id]['operator_readed'],
            };
            data['threads'].push(thread_data)
         };
         $.post(this.setting.ajaxUrl, data, function(result) {
            if (result['error']) throw new Error(result['error']);
            for (var key in result['threads']) {
               var lastId = 0;
               // Nedefinovaný ID -> nový thread
               if (typeof _t.threads[key] === 'undefined') {
                  _t.addThread(result['threads'][key]);
               } else {
                  _t.threads[key]['operator_readed'] = parseInt(result['threads'][key]['operator_readed']);
                  _t.threads[key]['ping_diff'] = parseInt(result['threads'][key]['ping_diff']);
                  _t.threads[key]['user_cart'] = result['threads'][key]['user_cart'];
                  // Verify online status
                  if (_t.threads[key]['is_online'] != parseInt(result['threads'][key]['is_online'])) {
                     _t.setThreadState(key, parseInt(result['threads'][key]['is_online']));
                  }
                  if (parseInt(result['threads'][key]['date_closed'])) {
                     _t.closeThread(key);
                     _t.threads[key]['date_closed'] = parseInt(result['threads'][key]['date_closed']);
                  }
               }
               // Mark threads with new messages
               if (parseInt(result['threads'][key]['total_new'])) {
                  _t.setActiveThreadNode(key, parseInt(result['threads'][key]['total_new']));
               }
            };
            // messages
            if (result['messages']) {
               for (var thread_id in result['messages']) {
                  for (var msg_id in result['messages'][thread_id]) {
                     var msg = result['messages'][thread_id][msg_id],
                        newStatus = false;
                     if (!newStatus && msg['initiator'] == "1" && msg['message_id'] > _t.threads[thread_id]['operator_readed']) {
                        newStatus = true;
                     }
                     _t.insertMessage(thread_id, msg['message'], parseInt(msg['initiator']), msg['date_added'], newStatus);
                     lastId = parseInt(msg['message_id']);
                  }
                  if (lastId > _t.threads[thread_id]['last_id']) _t.threads[thread_id]['last_id'] = lastId;
               }
            }
            if (result['success']) alert(result['success']);
         }, "json");
         if (method == "new_msg") {
            _t.playSound('msg_sent');
         }
      } catch (e) {
         console.log(e);
      }
      this.startTimer();
   },
   // -----------------
   // THREADS FUNCTIONS
   // -----------------
   addThread: function(data) {
      var nodeClasses = [];
      this.threads[data['thread_id']] = {
         username: data['user_name'],
         customer_id: data['customer_id'],
         customer_link: data['customer_link'],
         date_added: data['date_added'],
         date_modified: data['date_modified'],
         date_closed: parseInt(data['date_closed']),
         operator_readed: parseInt(data['operator_readed']),
         last_id: 0,
         user_ip: data['user_ip'],
         user_agent: data['user_agent'],
         user_cart: data['user_cart'],
         referer: data['referer'],
         language_id: data['language_id'],
         ping_diff: parseInt(data['ping_diff']),
         is_online: data['is_online'],
      }
      if (parseInt(data['customer_id'])) nodeClasses.push("lh-registred");
      $('#lh-name-list').responsivebar("addNode", {
         id: data['thread_id'],
         name: data['user_name'],
         nodeClass: nodeClasses
      });
      this.playSound('user_join');
   },
   removeThread: function(thread_id) {
      $('#lh-name-list').responsivebar("removeNode", {
         id: thread_id
      });
      $('#lh-thread-popup-' + thread_id).remove();
   },
   setThreadOpen: function(thread_id) {
      if (this.openThread.indexOf(thread_id) === -1) {
         this.openThread.push(thread_id);
         if (this.setting['saveOpened']) {
            localStorage.setItem('openThread', this.openThread.join(','));
         }
      }
   },
   setActiveThreadNode: function(thread_id, count) {
      if (!count) count = '';
      // Bar node active
      var _li = $('#lh-name-' + thread_id);
      _li.children('a').addClass('lh-new-msg');
      if (count) _li.children('a').children('span').text('(' + count + ')');
      // Popup active
      if ($('#lh-thread-popup-' + thread_id).length)
         $('#lh-thread-popup-' + thread_id).addClass('popup-box-active').find(".popup-head .badge").text( count );
   },
   removeActiveThreadNode: function(thread_id) {
      $('#lh-name-' + thread_id + ' a').removeClass('lh-new-msg').children('span').text('');
      $('#lh-thread-popup-' + thread_id).removeClass('popup-box-active').find(".popup-head .badge").text('');
   },
   getTreadInfo: function(id) {
      var html = '';

     html += '<div class="modal fade" id="lh-modal-dialog-modal" tabindex="-1" role="dialog">';
     html += '<div class="modal-dialog" role="document">';
     html += '<div class="modal-content">';
     html += '<div class="modal-header">';
     html += '<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>';
     html += '<h4 class="modal-title" id="exampleModalLabel">' + this.threads[id]['username'] + '</h4>';
     html += '</div>';
     html += '<div class="modal-body">';

     html += '<dl class="lh-user-info well">';
      html += '<dt>' + this.getLang('text_username') + '</dt>';
      html += '<dd class="text-left">' + this.threads[id]['username'] + '</dd>';
      html += '<dt>' + this.getLang('text_customer') + '</dt>';
      if (this.threads[id]['customer_link']) {
         html += '<dd class="text-left"><a href="' + this.threads[id]['customer_link'] + '">' + this.getLang('text_registred') + '</a></dd>';
      } else {
         html += '<dd class="text-left">' + this.getLang('text_not_registred') + '</dd>';
      }
      html += '<dt>' + this.getLang('text_ip') + '</dt>';
      html += '<dd class="text-left">' + this.threads[id]['user_ip'] + '</dd>';
      html += '<dt>' + this.getLang('text_date_added') + '</dt>';
      html += '<dd class="text-left">' + this.threads[id]['date_added'] + '</dd>';
      html += '<dt>' + this.getLang('text_user_agent') + '</dt>';
      html += '<dd class="text-left">' + this.threads[id]['user_agent'] + '</dd>';
      html += '<dt>' + this.getLang('text_referer') + '</dt>';
      html += '<dd class="text-left">' + this.threads[id]['referer'] + '</dd>';
      html += '<dt>' + this.getLang('text_last_activity') + '</dt>';
      if (this.threads[id]['ping_diff']) {
         html += '<dd class="text-left">' + this.getLang('text_before') + " " + this.mkDiffTime(this.threads[id]['ping_diff']) + '</dd>';
      } else {
         html += '<dd class="text-left">' + this.getLang('text_right_now') + '</dd>';
      }
      html += '</dl>';
      if (this.threads[id]['user_cart']) {
         html += '<hr>';
         html += '<h4><i class="icon-cart"></i> ' + this.getLang('text_user_cart') + ' <small class="label label-danger">' + this.threads[id]['user_cart']['items'] + ' ' + this.getLang('text_cart_items') + ' - ' + this.threads[id]['user_cart']['total'] + '</small></h4>';
         html += '<table class="table table-hover">';
         html += '   <thead>';
         html += '      <tr>';
         html += '         <th>' + this.getLang('text_product_id') + '</th>';
         html += '         <th>' + this.getLang('text_product_name') + '</th>';
         html += '         <th>' + this.getLang('text_product_qty') + '</th>';
         html += '      </tr>';
         html += '   </thead>';
         html += '   <tbody>';
         if(this.threads[id]['user_cart']['items']) {
            for (var product_id in this.threads[id]['user_cart']['products']) {
               var cart_item = this.threads[id]['user_cart']['products'][product_id];
               html += '      <tr>';
               html += '         <td>' + product_id + '</td>';
               html += '         <td>' + cart_item['name'] + ' ' + (parseInt(cart_item['stock']) ? '<span class="label label-success">' + this.getLang('text_in_stock') + '</span>' : '<span class="label label-danger">' + this.getLang('text_out_stock') + '</span>') + '</td>';
               html += '         <td>' + cart_item['qty'] + '</td>';
               html += '      </tr>';
            };           
         } else {
            html += '  <tr><td colspan="3" class="text-center">' + this.getLang('text_empty_cart') + '</td></tr>';  
         }
         html += '   </tbody>';
         html += '</table>'
      }

     html += '</div>';
     html += '</div>';
     html += '</div>';
     html += '</div>';

      $('#lh-modal-dialog').html(html);
      $( "#lh-modal-dialog-modal" ).modal();
   },
   closeThread: function(thread_id) {
      // Remove threadId from openedThreads
      var index = this.openThread.indexOf(parseInt(thread_id));
      if (index !== -1) this.openThread.splice(index, 1);
      $('#lh-thread-popup-' + thread_id).addClass('lh-closed-thread').find('.popup-head .badge').text(this.getLang('text_closed'));
   },
   setThreadState: function(thread_id, state) {
      if (state) { // if is online
         var _t = this;
         $('#lh-name-' + thread_id + ' a').removeClass('lh-closed');
         var text = _t.getLang("text_user_back_online");
         this.insertMessage(thread_id, text, 3);
         this.playSound('user_join');
      } else {
         var _t = this;
         $('#lh-name-' + thread_id + ' a').addClass('lh-closed');
         var text = _t.getLang("text_user_away", _t.mkDiffTime(_t.threads[thread_id]['ping_diff']));
         this.insertMessage(thread_id, text, 3);
         this.playSound('user_leave');
      }
      _t.threads[thread_id]['is_online'] = state;
   },
   mkDiffTime: function(time) {
      var timeStr = '';
      var msec = parseInt(time);
      var hh = Math.floor(msec / 60 / 60);
      msec -= hh * 60 * 60;
      var mm = Math.floor(msec / 60);
      msec -= mm * 60;
      var ss = Math.floor(msec);
      msec -= ss;
      if (hh) timeStr += hh + "h ";
      if (mm) timeStr += mm + "m ";
      if (ss) timeStr += ss + "s ";
      return timeStr || 0;
   },
   // -----------------
   // MESSAGE FUNCTIONS
   // -----------------
   insertMessage: function(thread_id, text, initiator, time, newMsg) {
      var html = '',
         init_class,
         messageBox = $('#lh-thread-popup-' + thread_id + ' .popup-messages');
      if (!messageBox.length) return;
      switch (initiator) {
         case 1:
            init_class = "received"
            break;
         case 2:
            init_class = "sent"
            break;
         default:
            init_class = "bot-generated"
            break;
      }
      html += '<div class="msg msg-' + init_class + '">';
      if (typeof time !== 'undefined') {
         html += ' <div class="msg-head">';
         html += ' <span class="msg-date">' + time + '</span>';
         html += ' </div>';
      }
      html += ' <div class="msg-body">';
      html += text.replace("\n", "<br>");
      html += ' </div>';
      html += '</div>';
      messageBox.append(html);
      messageBox.get(0).scrollTop = messageBox.get(0).scrollHeight;
      if (newMsg)
         this.playSound('new_msg');
   },
   // -----------------
   // TEXTAREA FUNCTIONS
   // -----------------
   changeTextareaHeight: function(textarea) {
      var currentHeight = parseInt(textarea.css("height"));
      if (currentHeight < 74) {
         textarea.css("height", (currentHeight + 20) + "px");
      }
   },
   insertText: function(textarea, code) {
      var caret_pos = this.caretPos(textarea);
      var str_begin = textarea.val().substring(0, caret_pos);
      var str_end = textarea.val().substring(caret_pos);
      textarea.val(str_begin + " " + code + " " + str_end);
      textarea.focus();
   },
   insertEmoticon: function(el, code) {
      var inputBlock = $(el).closest('.popup-input');
      this.insertText(inputBlock.find("textarea"), code);
      inputBlock.find('.lh-smiley-plugin').popover('hide');
   },
   insertBBCode: function(el, bbCode) {
      var _t = this,
         textarea = $(el).closest('.popup-input').find("textarea");
      switch (bbCode) {
         case 'url':
            str = prompt(_t.getLang('text_entry_url'), "http://");
            if (str) {
               _t.insertText(textarea, '[url]' + str + '[/url]')
            }
            break;
         case 'youtube':
            str = prompt(_t.getLang('text_entry_youtube'), "https://www.youtube.com/embed/");
            if (str) {
               _t.insertText(textarea, '[youtube]' + str + '[/youtube]')
            }
            break;
         default:
            this.insertText(textarea, '[' + bbCode + '][/' + bbCode + ']');
      }
      $(el).closest('.popup-input').find('.lh-bbcode-plugin').popover('hide');
   },
   clearText: function(el) {
      el.val('');
      el.css("height", "34px");
   },
   caretPos: function(el) {
      if (typeof el === "undefined" || !el.length) return;
      el = el[0];
      var pos = 0;
      // IE Support
      if (document.selection) {
         el.focus();
         var Sel = document.selection.createRange();
         var SelLength = document.selection.createRange().text.length;
         Sel.moveStart('character', -el.value.length);
         pos = Sel.text.length - SelLength;
      }
      // Firefox support
      else if (el.selectionStart || el.selectionStart == '0') {
         pos = el.selectionStart;
      }
      return pos;
   },
   // -----------------
   // SOUND FUNCTIONS
   // -----------------
   loadSound: function() {
      var soundBlock = $("<audio></audio>");
      soundBlock.attr("id", "lh-js-audio-block");
      $('#livehelp').append(soundBlock);
   },
   playSound: function(chatEvent) {
      if (this.setting['sound']) {
         if (!$('#lh-js-audio-block').length)
            this.loadSound();
         var audioBlock = $('#lh-js-audio-block');
         try {
            switch (chatEvent) {
               case 'new_msg':
                  if (!this.setting.soundAlert['newMessage']) break;
                  audioBlock.children("source").remove();
                  audioBlock.append('<source src="' + this.setting['soundFolder'] + this.setting.soundAlert['newMessage'] + '" type="audio/mpeg">');
                  audioBlock.get(0).load();
                  audioBlock.get(0).play();
                  break;
               case 'msg_sent':
                  if (!this.setting.soundAlert['messageSent']) break;
                  audioBlock.children("source").remove();
                  audioBlock.append('<source src="' + this.setting['soundFolder'] + this.setting.soundAlert['messageSent'] + '" type="audio/mpeg">');
                  audioBlock.get(0).load();
                  audioBlock.get(0).play();
                  break;
               case 'user_join':
                  if (!this.setting.soundAlert['userLogged']) break;
                  audioBlock.children("source").remove();
                  audioBlock.append('<source src="' + this.setting['soundFolder'] + this.setting.soundAlert['userLogged'] + '" type="audio/mpeg">');
                  audioBlock.get(0).load();
                  audioBlock.get(0).play();
                  break;
               case 'user_leave':
                  if (!this.setting.soundAlert['userLogout']) break;
                  audioBlock.children("source").remove();
                  audioBlock.append('<source src="' + this.setting['soundFolder'] + this.setting.soundAlert['userLogout'] + '" type="audio/mpeg">');
                  audioBlock.get(0).load();
                  audioBlock.get(0).play();
                  break;
               case 'redirect':
               case 'expirate':
               case 'removed':
                  if (!this.setting.soundAlert['special']) break;
                  audioBlock.children("source").remove();
                  audioBlock.append('<source src="' + this.setting['soundFolder'] + this.setting.soundAlert['special'] + '" type="audio/mpeg">');
                  audioBlock.get(0).load();
                  audioBlock.get(0).play();
                  break;
            }
         } catch (e) {
            console.log(e);
         }
      }
   },
   toggleSound: function(e) {
      e.preventDefault();
      e.stopPropagation();
      if (localStorage.getItem("sound") === null) {
         this.setting.sound = 0;
      } else {
         this.setting.sound = (parseInt(localStorage.getItem("sound")) === 1 ? 0 : 1);
      }
      localStorage.setItem("sound", this.setting.sound);
      $('#livehelp-sound-toggle i').toggleClass("icon-volume-high icon-volume-mute");
   }
};
