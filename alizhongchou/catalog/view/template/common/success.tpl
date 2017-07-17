<?php echo $header; ?>
<link href="catalog/view/stylesheet/css/paysuccess.css" rel="stylesheet" type="text/css"/>
<script src="catalog/view/javascript/js/swiper-3.3.1.min.js" type="text/javascript"></script>
<div class="container">
  <div class="paysuccess" style="margin-top: 60px;">
    <h3><i class="fa fa-check-circle-o"></i>Congratulations, pay success! Please wait patiently during delivery.</h3>
    <p>
      <span>Order number：</span>
      <span>#<?php echo isset($order_id)?$order_id:"No Order";?></span>
    </p>
    <p class="p_miaoshu">If the project is successful, we will complete the delivery within 3-7 working days. If the project is not successful after the end of time, we will return to your account.</p>
    <a href="<?php echo $return_home;?>"><button class="btn paybtn1">Return  home</button></a>
    <a href="<?php echo $view_more;?>"><button class="btn paybtn2">View order</button></a>
  </div>
</div>
<!--  Product Marketplace -->
<div class="Marketplace col-sm-12 clearfix">
  <div class="container">
    <div class="bottoms">
      <div class="clearfix col-sm-12 InDemand-top">
        <span>Maybe you like</span>
      </div>
      <div class="swiper-container">
        <div class="swiper-wrapper">
          <?php
          $length = count($pick_you);
            $num    = ceil($length/3);
            sort($pick_you);
            for($n=1;$n<$num+1;$n++) :
               if($n==$num){
                  $x = $length;
               }else{
                  $x = $n*3;
               }
          ?>
          <div class="swiper-slide <?php if($n==1){ echo ' swiper-container-horizontal';} ?>">
            <div class="product-grid">
              <?php
              for($i=($n-1)*3;$i<$x;$i++): ?>
              <div class="col-sm-4 col-xs-6">
                <div class="product clearfix product-hover">
                  <div class="left">
                    <div class="image ">
                      <a href="<?php echo $pick_you[$i]['url']?>" target="_blank">
                        <img src="<?php echo $pick_you[$i]['image'];?>" alt="<?php echo $pick_you[$i]['name'];?>" class="zoom-image-effect">
                      </a>
                    </div>
                  </div>
                  <div class="right">
                    <div class="name">
                      <a href="<?php echo $pick_you[$i]['url']?>"><?php echo $pick_you[$i]['name'];?></a>
                    </div>
                    <div class="nduanluo">
                      <?php echo $pick_you[$i]['introduce']?>
                    </div>
                    <div class="progress">
                      <div class="progress-bar" style="width:<?php echo $pick_you[$i]['sale'];?>%; ">
                        <div class="progress-value"> <?php echo $pick_you[$i]['sale']?>%</div>
                      </div>
                    </div>
                    <div class="pledge">
                      <p class="pledge-left l">
                        Pledged: $<?php echo $pick_you[$i]['total_goal']?>
                      </p>
                      <p class="pledge-right r">
                        <?php echo $pick_you[$i]['date_end'];?>
                      </p>
                    </div>
                  </div>
                </div>
              </div>
              <?php endfor;?>
            </div>
          </div>
          <?php endfor;?>
        </div>

      </div>
      <div class="swiper-button-next">
        <i class="fa fa-angle-right"></i>
      </div>
      <div class="swiper-button-prev">
        <i class="fa fa-angle-left"></i>
      </div>
    </div>
  </div>
</div>
<!--  Product Marketplace end-->
<script>
    var swiper = new Swiper('.swiper-container', {
        pagination: '.swiper-pagination',
        nextButton: '.swiper-button-next',
        prevButton: '.swiper-button-prev',
        slidesPerView: 1,
        paginationClickable: true,
        spaceBetween: 30,
        loop: true
    });
</script>
<script>
    $(document).ready(function () {
        $('.progress-value').each(function () {
            num = $(this).text();
            length = $(this).text().length;
            num_1 = num.substring(0, length - 1);
            if (num_1 < 5) {
                $(this).parent().css("width", "5%");
            }
        });
    });
</script>
<?php echo $footer; ?>
