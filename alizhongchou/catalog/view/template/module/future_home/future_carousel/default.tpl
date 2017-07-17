<?php if(isset(${$type}['array'])):?>
<div class="home-banner">
    <div class="swiper-container">
        <div class="swiper-wrapper">
            <?php   foreach(${$type}['array']  as $v):

             ?>
            <div class="swiper-slide">
                <a href="<?php echo $v['link'];?>">
                    <img src="<?php echo $v['image'];?>" alt=""/>
                </a>
            </div>
            <?php
                endforeach;
            ?>
        </div>
        <!-- Add Pagination -->
        <div class="swiper-pagination"></div>
        <!-- Add Arrows -->
        <div class="swiper-button-next">
            <i class="fa fa-angle-right qiehuan"></i>
        </div>
        <div class="swiper-button-prev">
            <i class="fa fa-angle-left qiehuan"></i>
        </div>
    </div>
</div>
<?php endif; ?>