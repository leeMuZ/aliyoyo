<script src="catalog/view/stylesheet/js/jquery.min.js"></script>
<script src="catalog/view/stylesheet/js/jquery.countdown.js"></script>
<!-- <script src="js/script.js"></script> -->
<script src="catalog/view/stylesheet/js/bootstrap.min.js"></script>
<script src="catalog/view/stylesheet/js/swiper-3.3.1.min.js"></script>
<script src="catalog/view/stylesheet/js/bbb.min.js"></script>
<script src="catalog/view/stylesheet/js/bbb.js" id="bbbScript" data="<?php echo $max;?>"></script>
<script>
    // daohang caidan =================================================================
    $(document).on("mouseover",".mouseoverli",function(){
        $(this).children(".yincangfenlei").show();
        $(this).children('.parttenulone-a').css('color', '#26cada');
        // $(this).siblings('li').children('.parttenulone-a').css('color', '#353535');
    })
    $(document).mouseout(function(e){
        var _con = $('.mouseoverli,.yincangfenlei');   // 设置目标区域
        if(!_con.is(e.target) && _con.has(e.target).length === 0){ // Mark 1
            $(".yincangfenlei").hide(); // 功能代码
            $(".mouseoverli").children('.parttenulone-a').css('color', '#353535');

        }
    });
    // sousuokuang
    var num=1;
    $(".parttenultwo-span").click(function(event) {
        if(num){
            $(".inputsearch").animate({"width":"30%"},500);
            $(".inputsearch").css('border', '1px solid #ccc');
            num=0;
            $(".inputsearch-input").change(function(event) {
                var inputtext=$(".inputsearch-input").val();
                if(inputtext!=""){
                    location.href = "http://www.baidu.com";
                    $(".inputsearch-input").val("");
                }else{
                    $(".inputsearch").animate({"width":"0%"},500);
                    $(".inputsearch").css('border', '0px solid #ccc');
                }
            });
        }else{
            $(".inputsearch").animate({"width":"0%"},500);
            $(".inputsearch").css('border', '0px solid #ccc');
            num=1;
        }
    });

    // // daohang caidan end=================================================================

    $(document).ready(function() {
        $('.xialatubiao').click(function() {
            open($(this).siblings('select'));
        });
    });
    function open(elem) {
        if (document.createEvent) {
            var e = document.createEvent("MouseEvents");
            e.initMouseEvent("mousedown", true, true, window, 0, 0, 0, 0, 0, false, false, false, false, 0, null);
            elem[0].dispatchEvent(e);
        } else if (element.fireEvent) {
            elem[0].fireEvent("onmousedown");
        }
    }
    // 倒计时-===========================
    window.jQuery(function ($) {
        "use strict";
        $('time').countDown({
            with_separators: false
        });

    });
    // 倒计时 end-===========================
    // 收藏的那个==============
    $(document).delegate('.huistar', 'click', function(event) {
        $('.huistar').addClass('colorright');
        $('.huistar').children('span').text('Saved');
        $('.huistar').addClass('huistarclick');

    });
    $(document).delegate('.huistarclick', 'click', function(event) {
        $('.huistarclick').removeClass('colorright');
        $('.huistarclick').children('span').text('Remind me');
        $('.huistarclick').removeClass('huistarclick');
    });
    // 收藏的那个 end==============
    $(".inforlink li").click(function(){
        $(this).children('.btn').addClass('forlinkactive');
        $(this).siblings().children('.btn').removeClass('forlinkactive');
        $(".campaigntableall .campaigntable").eq($(this).index()).addClass('campaigntableall-active').siblings().removeClass('campaigntableall-active');

    })
    // read me 部分==============
    $(".turn-off").click(function(event) {
        var cmessage = $(this).attr('data-text');
        $("#show_message_div").removeClass('campaigntableall-active');
        $("#show_message_div").addClass('campaigntable yincang');
        $('#'+cmessage).addClass('campaigntableall-active');
    });
    // =====================================================
    $(".pledgeall li").hover(function() {
        var text1="All gone!";
        var text2=$(this).children().children('.gone').html();
        if(text2==text1){
            $(this).addClass('pledgeallli-anotherhover');
            $(this).children().children('.gone').addClass('goneactive');
            $(this).children('.btn-block').addClass('btn-blockactive');

        }else{
            $(this).addClass('pledgealllihover');
            $(this).children().children('.gone').addClass('goneactive');
            $(this).children().children('.btn-block').addClass('btn-blockactive');
        }
    },function() {
        $(this).removeClass('pledgealllihover');
        $(this).removeClass('pledgeallli-anotherhover');
        $(this).children().children('.gone').removeClass('goneactive');
        $(this).children('.btn-block').removeClass('btn-blockactive');
    });
    $(".pledgeall li").click(function() {
        var text1="All gone!";
        var text2=$(this).children().children('.gone').html();
        // var everyoneneirong='<div class="everyoneneirong"><div class="xuxian"></div><div class="form-group" id="selecttttt"><label for="sel">Shipping destination</label><select class="form-control" id="sel"><option>china</option><option>2</option><option>3</option><option>4</option><option>5</option></select><i class="fa fa-angle-down xialatubiao" ></i></div><div class="form-group"><label for="tax">Pledge amount</label><input type="text" class="form-control" id="tax" placeholder="$54"></div><button type="button" class="btn btn-primary btn-lg btn-block">Continue</button></div>';
        if(text2==text1){

        }else{
            $(this).children('.everyoneneirong').css('display', 'block');
        }

    });
    $(window).scroll(function(){
        if($(window).scrollTop()>700){
            $(".scroll-inforlink").addClass('scroll-inforlink-active');
            $(".inforlink").addClass('inforlink-ul-active');
            $(".inforlink li").addClass('inforlink-li-active');
            $(".scroll-project").show();
        }else{
            $(".scroll-inforlink").removeClass('scroll-inforlink-active');
            $(".inforlink").removeClass('inforlink-ul-active');
            $(".inforlink li").removeClass('inforlink-li-active');
            $(".scroll-project").hide();
        }
    });

    $('.a_share').click(function (event) {
        $('#share_message').css("display","");
        $('#st-1').children().css("display","");
    });
</script>