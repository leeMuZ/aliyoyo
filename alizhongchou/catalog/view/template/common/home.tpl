<?php echo $header; ?>
<?php
include_once( DIR_TEMPLATE."/lib/module.php" );
$modules_old_opencart = new Modules($registry);
?>
<!-- ========================banner bufen======================================== -->
<?php


$banner_result = $modules_old_opencart->getModules('header');

if($banner_result):
foreach($banner_result as $k=>$v):
   echo $v;
endforeach;
endif;
?>
<!-- ========================banner bufen end======================================== -->

<!-- ==================================fanzhuan tupian================================================== -->
<div class="container">

    <?php
    $banner_result = $modules_old_opencart->getModules('middle');
    if($banner_result):
    foreach($banner_result as $k=>$v):
    echo $v;
    endforeach;
    endif;
    ?>
</div>
<!--  Product Marketplace -->

<div class="Marketplace clearfix col-sm-12">
    <div class="container">
        <?php
$banner_result = $modules_old_opencart->getModules('bottom');
        if($banner_result):
        foreach($banner_result as $k=>$v):
        echo $v;
        endforeach;
        endif;
        ?>
    </div>


</div>
<!-- Mostfunded -->
<?php
$banner_result = $modules_old_opencart->getModules('other');
    if($banner_result):
    foreach($banner_result as $k=>$v):
    echo $v;
    endforeach;
    endif;
?>
</div>

<script src="catalog/view/stylesheet/js/swiper-3.3.1.min.js"></script>
<script>
var mySwiper = $('.home-banner .swiper-container').swiper({
    mode:'horizontal',
    pagination:'.home-banner .swiper-pagination',
    nextButton: '.swiper-button-next',
    prevButton: '.swiper-button-prev',
    slidesPerView: 1,
    paginationClickable: true,
    spaceBetween: 30,
    autoplay: 2500,
    loop: true
});

var swiper = $('.Marketplace .swiper-container').swiper({
    pagination: '.Marketplace .swiper-pagination',
    nextButton: '.swiper-button-next',
    prevButton: '.swiper-button-prev',
    slidesPerView: 1,
    paginationClickable: true,
    spaceBetween: 30,
    autoplay: 2500,
    loop: true
});

    // =====================================广告位占位============================

    $(function(){
        var $regularlyItems=$(".regularly-item-list li");
//        $regularlyItems.each(function(){
//            var _$this=$(this);
//            _$this.children(".flip-box").eq(0).addClass("out").removeClass("in");
//            setTimeout(function() {
//                _$this.find(".flip-box").show().eq(1).addClass("in").removeClass("out");
//                _$this.children(".flip-box").eq(0).hide();
//            }, 500);
//        });
        $regularlyItems.hover(function(){
            var _$this=$(this);
            _$this.children(".flip-box").eq(1).addClass("out").removeClass("in");
            setTimeout(function() {
                _$this.find(".flip-box").show().eq(0).addClass("in").removeClass("out");
                _$this.children(".flip-box").eq(1).hide();
            }, 225);
        },function(){
            var _$this=$(this);
            _$this.children(".flip-box").eq(0).addClass("out").removeClass("in");
            setTimeout(function() {
                _$this.find(".flip-box").show().eq(1).addClass("in").removeClass("out");
                _$this.children(".flip-box").eq(0).hide();
            }, 400);
        });
    });
    //
$(".categories-div").hover(function() {
    $(this).children(".xianshidiv").addClass('xianshidiv-active');
    $(this).siblings().children('.xianshidiv').removeClass('xianshidiv-active');
    $(this).children('.xianshidiv').children('svg').children('.aliyoyo-icon').css('fill','#101010');
}, function() {
    $(this).children(".xianshidiv").removeClass('xianshidiv-active');
    $(this).children('.xianshidiv').children('svg').children('path').removeClass('redsvgactive');
    $(this).children('.xianshidiv').children('svg').children('.aliyoyo-icon').css('fill','#fff');

});


$(function () {
    $('.progress-value').each(function () {
        num = $(this).text();
        length = $(this).text().length;
        num_1 = num.substring(0, length-1);
        if (num_1 < 5)
        {
            $(this).parent().css("width", "5%");
        }
    });

});
</script>

<?php echo $footer; ?>