<?php if(isset(${$type}['array'])):?>
<div class="bottoms">
    <div class="clearfix col-sm-12 InDemand-top">
        <span>Aliyoyo Product Marketplace</span>
        <a href="http://www.aliyoyo.com/">View more</a>
    </div>
    <div class="swiper-container">
        <div class="swiper-wrapper">
           <?php
            $length = count(${$type}['array']);
            $num    = ceil($length/4);
            sort(${$type}['array']);
            for($n=1;$n<$num+1;$n++) {
               if($n==$num){
                  $x = $length;
               }else{
                  $x = $n*4;
               }
              ?>
            <div class="swiper-slide <?php if($n==1){ echo 'active';} ?>">
                <div class="product-grid">
                   <?php
                    for($i=($n-1)*4;$i<$x;$i++) {
                    ?>
                    <div class="col-sm-3 ">
                        <div class="product clearfix product-hover">
                            <div class="left">
                                <div class="image ">
                                    <a href="<?php echo ${$type}['array'][$i]['link'];?>" target="_blank">
                                        <img src="<?php echo  ${$type}['array'][$i]['image'];?>" alt="<?php echo ${$type}['array'][$i]['product_name'][1];?>" class="zoom-image-effect">
                                    </a>
                                </div>
                            </div>
                            <div class="right">
                                <div class="name">
                                    <a href="<?php echo ${$type}['array'][$i]['link'];?>"><?php echo ${$type}['array'][$i]['product_name'][1];?></a>
                                </div>
                                <div class="price">$<?php echo ${$type}['array'][$i]['price']?> </div>
                            </div>
                        </div>
                     </div> <?php } ?>
                </div>

            </div><?php  } ?>
        </div>
    </div>
    <div class="swiper-button-next">
        <i class="fa fa-angle-right"></i>
    </div>
    <div class="swiper-button-prev">
        <i class="fa fa-angle-left"></i>
    </div>
</div>
<?php endif;?>
