<!-- guanggaowei -->
<?php if(isset(${$type}['array'])):?>
<div class="guanggaowei clearfix col-sm-12">
    <ul class="regularly-item-list">
        <li class="first viewport-flip">
            <div class="flip-box flip out turnoff">
                <a href="">
                    <p>6 FUTURE <br>Find Smarter Life Here!</p>
                    <p>
                        <span>View more</span>
                        <span>>></span>
                    </p>
                </a>
            </div>
            <div class="flip-box flip yuanyou">
                <p>6 FUTURE <br>Find Smarter Life Here!</p>
                <p>
                    <span>View more</span>
                    <span>>></span>
                </p>
            </div>
        </li>
        <?php

                     foreach( ${$type}['array'] as $k=>$v){
        ?>
        <li class="last viewport-flip" style="<?php if ( ($k%3)==0 ){ echo 'margin-right:0';}?>" >
            <div class="flip-box flip out tupianfanzhuan">
                <a href="<?php echo $v['url'];?>">
                    <p><?php echo $v['product_name'][1];?></p>
                    <div class="progress">
                        <div class="progress-bar" style="width: <?php echo $v['price']['percent'];?>%; ">
                        </div>
                    </div>
                    <p class="little-margin">Pledged: $<?php echo $v['price']['now_pay'];?></p>
                    <p class="little-margin"><?php echo $v['price']['left'];?></p>
                </a>

            </div>
            <div class="flip-box flip">
                <img src="<?php echo $v['product_image'];?>" alt="">
            </div>
        </li>
        <?php
              }
         ?>
    </ul>
</div>
<?php endif; ?>