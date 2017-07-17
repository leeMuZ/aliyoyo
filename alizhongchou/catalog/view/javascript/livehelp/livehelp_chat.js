var LivehelpChat = {
   // Settings
   setting: {
      sound: 1,
      soundFolder: "image/sounds/",
      soundAlert: {                    // Path to file
         newMessage: null,
         messageSent: null,
         operatorJoin: null,
         operatorLeave: null,
         special: null
      },
      textMaxLength: 500,              // Maximum length of messages
      antiSpam: 0,
      antiSpam_scoreLimit: 10,         // Maximum messages in one range
      antiSpam_penalty: 60,            // 60 seconds
      antiSpam_range: 20,              // 20 seconds
      ajaxUrl: null,
      timeout: 5000,
      languageId: 1,
      languageCode: "en",
      customSlider: false,             // If simpleBar is enabled
      titleAlert: false,               // Alert new messages count in page title
   },
   lastMsgId: 0,
   lastReadedId: 0,
   onBootUpdated: 0,
   newMessageCount: 0,
   pageTitleInterval: null,
   isOnline: 0,
   timer: null,
   stopTimer: 0,
   antiFlood: {                        // Temporary data for antiSpam filter
      score: 0,
      lastact: null,
   },
   language: {                         // Localisation
      en: {
         text_operator_signed: "Operator has joined into your chat",
         text_operator_online_again: "Operator is again online",
         text_operator_away: "Operator is unavailable for some time or go offline",
         error_kicked: "You has been kicked from the chat!",
         text_muted_for_time: "You have been muted for the next %s seconds!",
         text_entry_url: "Entry link",
         text_entry_youtube: "Entry youtube embed link",
      }
   },
   temp: {
      'page_title' : '',
      'operator'   : '',
   },
   // ------------------------------------------------------------------ \\
   // ---------------             METHODS               --------------- \\
   // ------------------------------------------------------------------ \\
   init: function(settings, language) {
      if (typeof settings['lastReaded'] !== 'undefined') this.lastReadedId = settings['lastReaded'];
      if (typeof settings['isOnline'] !== 'undefined') this.isOnline = settings['isOnline'];
      this.setting = $.extend({}, this.setting, settings || {});
      this.language = $.extend({}, this.language, language || {});

      this.setting['customSlider'] = $(".lb-msg-wrapper[data-simplebar-direction]").length ? $(".lb-msg-wrapper[data-simplebar-direction]") : false;
      this.temp['page_title'] = document.title;

      this.temp['operator'] = $('h5.lh-oi-name').text();

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
            $('.lh-js-sound-toggle i').removeClass("icon1-volume-mute").addClass("icon1-volume-high");
         else
            $('.lh-js-sound-toggle i').removeClass("icon1-volume-high").addClass("icon1-volume-mute");
      } 
   },
   verifyInit: function() {
      if (!this.setting.ajaxUrl ||
         this.setting.timeout < 1000) {
         throw new Error("Major variables not specified!");
      }
      if (!this.setting.soundAlert['newMessage'] &&
         !this.setting.soundAlert['messageSent'] &&
         !this.setting.soundAlert['operatorJoin'] &&
         !this.setting.soundAlert['operatorLeave'] &&
         !this.setting.soundAlert['special']) {
         this.setting['sound'] = 0;
         localStorage.removeItem("sound")
      }
      if (typeof this.language[this.setting['languageCode']] === 'undefined') {
         throw new Error("Unsupported language code!");
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
   startTimer: function() {
      if (this.stopTimer == 1) return;
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
      $('.lh-textarea-input').on("keydown", function(event) {
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
            var data = {};
            if (!_txt.val().replace("\n", "").trim().length) return false; // prevent sending empty string
            // Do antispam stuff before submit
            if (_t.setting.antiSpam) {
               if (!_t.antiFlood['lastact'])
                  _t.antiFlood['lastact'] = new Date().getTime();
               if (_t.antiFlood['score'] >= _t.setting.antiSpam_scoreLimit && (new Date().getTime() < _t.antiFlood['lastact'] + _t.setting.antiSpam_penalty * 1000)) {
                  _t.insertMessage('<span class="text-danger">' + _t.getLang('text_muted_for_time', _t.setting.antiSpam_penalty) + '</span>', 3);
                  return;
               }
               if ((new Date().getTime() - _t.antiFlood['lastact']) < (_t.setting.antiSpam_range * 1000)) {
                  _t.antiFlood['score']++;
                  if (_t.antiFlood['score'] == _t.setting.antiSpam_scoreLimit)
                     data['spamBlock'] = 1;
               } else {
                  _t.antiFlood['lastact'] = new Date().getTime();
                  _t.antiFlood['score'] = 1;
               }
            }
            data['lastId'] = _t.lastMsgId;
            data['text'] = _txt.val();
            _t.makeRequest("new_msg", data);
            _t.clearText($('.lh-textarea-input')); // also prevent before multiple submiting
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
      });
      // Catching focused into box
      $('#livehelp').on("chatBox.focused", function() {
         var $t = $(this);
         if (!$t.hasClass("lh-active-box")) return;
         _t.removeNewStatus();
         if (_t.lastMsgId > _t.lastReadedId) {
            _t.newMessageCount = 0;
            _t.lastReadedId = _t.lastMsgId;
            _t.makeRequest("update_readed", {
               lastReaded: _t.lastReadedId
            });
         }
      });
   },
   makeRequest: function(method, data) {
      var _t = this;
      if (typeof data === 'undefined') data = {};
      clearInterval(_t.timer);
      _t.timer = null;
      try {
         switch (method) {
            case 'new_msg':
               data.operation = 'new_msg';
               $.post(this.setting.ajaxUrl, data, function(result) {
                  if (result['error']) {
                     _t.insertMessage('<span class="text-danger">' + result['error'] + '</span>', 3);
                  } else {
                     _t.lastMsgId = result['message_id'];
                     _t.insertMessage(result['text'], result['initiator'], result['date_added']);
                     $('.lh-textarea-input').focus();
                     _t.playSound('msg_sent');
                  }
               }, "json");
               break;
            default:
               data['lastId'] = _t.lastMsgId;
               $.post(this.setting.ajaxUrl, data, function(result) {
                  if (result['error']) throw new Error(result['error']);
                  if (result['operator']) {
                     if (_t.isOnline != parseInt(result['operator'][0]['is_logged'])) {
                        _t.changeOperatorState(parseInt(result['operator'][0]['is_logged']));
                     }
                  }
                  var newStatus = 0;
                  if (result['messages']) {
                     for (var key in result['messages']) {
                        var msg = result['messages'][key];
                        if (msg['initiator'] != "1" && msg['message_id'] > _t.lastReadedId) {
                           newStatus++;
                        }
                        _t.insertMessage(msg['text'], parseInt(msg['initiator']), msg['date_added']);
                     }
                     if (newStatus) {
                        _t.setNewStatus(_t.newMessageCount + newStatus);
                        _t.newMessageCount = _t.newMessageCount + newStatus;
                     } else if (_t.newMessageCount + newStatus == 0) {
                        _t.removeNewStatus();
                     }
                     _t.lastMsgId = result['lastId'];
                  }
                  // Check if kicked
                  if (parseInt(result['kicked']) && !_t.stopTimer) {
                     _t.insertMessage('<span class="text-danger">' + _t.getLang('error_kicked') + '</span>', 3);
                     _t.stopTimer = 1;
                     return;
                  }
               }, "json");
               break;
         }
      } catch (e) {
         console.log(e);
      }
      
      this.startTimer();
   },
   // MESSAGE FUNCTIONS
   //
   insertMessage: function(text, initiator, time) {
      var html = '',
         init_class,
         author = '';

      switch (initiator) {
         case 1:
            init_class = "sent";
            author = this.getLang('text_me');
            break;
         case 2:
            init_class = "received";
            author = this.temp['operator'];
            break;
         default:
            init_class = "bot-generated";
            break;
      }
      html += '<div class="msg msg-' + init_class + '">';
      if (time || author) {
         html += ' <div class="msg-head">';
            if(author) html += ' <span class="msg-author">' + author + '</span>';
            if(time) html += ' <span class="msg-date">' + time + '</span>';
         html += ' </div>';
      }
      html += ' <div class="msg-body">';
      html += text.replace("\n", "<br>");
      html += ' </div>';
      html += '</div>';
      $('.lh-messages').append(html);
                                                            
      if(this.setting['customSlider']) this.recalcSlideBar();
      this.scrollToBottom();
   },
   insertAction: function(action, data) {},
   // SPECIAL FUNCTIONS
   logout: function() {
      $.post(this.setting.ajaxUrl, {
         operation: "signout"
      }, function() {
         location.reload();
      }, "json");
   },
   // ChatBox function
   setNewStatus: function(count) {
      $('#livehelp').addClass("lh-active-box");
      $('#livehelp').find('.lh-badge').html('<span class="badge-box">' + count + '</span>' || '');
      this.playSound('new_msg');

      if(this.setting['titleAlert']) this.setPageTitleAlert(count);
   },
   removeNewStatus: function() {
      $('#livehelp').removeClass("lh-active-box");
      $('#livehelp').find('.lh-badge').html("");

      if(this.setting['titleAlert']) this.breakPageTitleAlert();
   },
   changeOperatorState: function(state) {
      if (state) {
         this.insertMessage(this.getLang('text_operator_online_again'), 3);
         this.playSound('op_join');
      } else {
         this.insertMessage(this.getLang('text_operator_away'), 3);
         this.playSound('op_leave');
      }
      this.isOnline = state;
   },
   // Textarea functions
   changeTextareaHeight: function(textarea) {
      var currentHeight = parseInt(textarea.css("height"));
      if (currentHeight < 74) {
         textarea.css("height", (currentHeight + 20) + "px");
      }
   },
   insertText: function(code) {
      var $textarea = $('.lh-textarea-input');
      var caret_pos = this.caretPos($textarea);
      var str_begin = $textarea.val().substring(0, caret_pos);
      var str_end = $textarea.val().substring(caret_pos);
      $textarea.val(str_begin + " " + code + " " + str_end);
      $textarea.focus();
      $('.lh-smiley-plugin, .lh-bbcode-plugin').popover('hide');
   },
   insertBBCode: function(bbCode) {
      var _t = this;
      switch (bbCode) {
         case 'url':
            str = prompt(_t.getLang('text_entry_url'), "http://");
            if (str) {
               _t.insertText('[url]' + str + '[/url]')
            }
            break;
         case 'youtube':
            str = prompt(_t.getLang('text_entry_youtube'), "https://www.youtube.com/embed/");
            if (str) {
               _t.insertText('[youtube]' + str + '[/youtube]')
            }
            break;
         default:
            this.insertText('[' + bbCode + '][/' + bbCode + ']');
      }
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
   scrollToBottom: function() {
      if(this.setting['customSlider'])
         this.setting['customSlider'].simplebar('scrollTo', $('.lh-messages').height());
      else 
         $('.lh-messages').get(0).scrollTop = $('.lh-messages').get(0).scrollHeight;
   },
   /* SOUNDS */
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
               case 'op_join':
               case 'op_switch':
                  if (!this.setting.soundAlert['operatorJoin']) break;
                  audioBlock.children("source").remove();
                  audioBlock.append('<source src="' + this.setting['soundFolder'] + this.setting.soundAlert['operatorJoin'] + '" type="audio/mpeg">');
                  audioBlock.get(0).load();
                  audioBlock.get(0).play();
                  break;
               case 'op_leave':
                  if (!this.setting.soundAlert['operatorLeave']) break;
                  audioBlock.children("source").remove();
                  audioBlock.append('<source src="' + this.setting['soundFolder'] + this.setting.soundAlert['operatorLeave'] + '" type="audio/mpeg">');
                  audioBlock.get(0).load();
                  audioBlock.get(0).play();
                  break;
               case 'redirect':
               case 'expirate':
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
      $('.lh-js-sound-toggle i').toggleClass("icon1-volume-high icon1-volume-mute");
   },

   recalcSlideBar: function()
   {
      this.setting['customSlider'].simplebar('recalculate');
   },

   // Page title alerts
   setPageTitleAlert: function(msgCount)
   {
      var t = this;

      t.pageTitleInterval = setInterval(function() {
         if(document.title.length > t.temp['page_title'].length) {
            document.title = t.temp['page_title'];
         } else {
            document.title = "(" + msgCount + ") " + t.temp['page_title'];
         }
      }, 1500);
   },
   breakPageTitleAlert: function() {
      document.title = this.temp['page_title'];
      clearInterval(this.pageTitleInterval);
      this.pageTitleInterval = null;
   },
};
