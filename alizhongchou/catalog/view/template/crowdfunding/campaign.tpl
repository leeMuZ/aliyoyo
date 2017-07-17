<?php echo $header;?>
<?php echo $index_goods?>
<article class="campaign">
    <div class="scroll-inforlink">
        <ul class="inforlink">
            <?php
            foreach($link as $k=>$v):
             ?>
             <li><button class="<?php echo $k=='campaign'?'btn forlinkactive':'btn';?>" onclick="window.location.href='<?php echo $v;?>'"><?php echo $k; ?></button></li>
             <?php
             endforeach;
             ?>
            <div class="scroll-project">
                <div class="project-top  col-md-5">
                    <a href="backproject.html"><button class="btn">Back This Project</button></a>
                </div>
                <div class="project-right col-md-4">
                    <button class="btn huistar no-border"><i class="fa fa-star"></i><span>Remind me</span></button>
                </div>
            </div>
        </ul>
    </div>
    <!-- ======================================table all============================================= -->
    <div class="campaigntableall">
        <!-- ======================================table all one ============================================= -->
        <div class="campaigntable campaigntableall-active">
            <div class="abouttheproduct col-md-8 col-sm-8">
                <div class="productjieshao">
                    <p class="about-p">About the product</p>
                    <?php if(isset($reward[0]['description'])):?>
                    <?php echo htmlspecialchars_decode($reward[0]['description']);?>
                    <?php endif;?>
                    <div>
                        <p class="about-p"> Risks and challenges</p>
                        <div class="risks-p">
                            <?php if(isset($reward[0]['risk_description'])):?>
                            <?php echo htmlspecialchars_decode($reward[0]['risk_description']);?>
                            <?php endif;?>
                        </div>
                    </div>
                </div>
            </div>
            <div class="rewords col-md-4 col-sm-4">
                <div class="teantheme-lunbo">
                    <div class="swiper-container">
                        <div class="swiper-wrapper">
                            <div class="swiper-slide">
                                <div class="circle-person">
                                    <img src="<?php echo $reward[0]['image'];?>" alt="">
                                    <div class="chose">
                                        <p>Project sponsor</p>
                                        <p class="chose-name"><?php echo isset($reward[0])?$reward[0]['firstname'].$reward[0]['lastname']:'';?></p>
                                        <p><?php echo isset($reward[0])?$reward[0]['word']:'';?></p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <p class="about-p">Reward</p>
                <ul class="pledgeall">
                    <?php foreach($reward as $reward):?>
                    <?php if($reward['rewards_id'] != null):?>
                    <?php if((strtotime($reward['limit_time_end']) > time()) && $reward['stock'] > 0 ){ ?>
                    <li>
                        <p class="ple">Pledge $<?php echo $reward['pledge_amount']; ?> or more</p>
                        <p style="font-size:14px;">
											<span class="backspan">
												<i class="fa fa-male"></i>
												 <?php echo $reward['all_man'];?> backers
											</span>
                            <span class="gone">Limited (<?php echo $reward['backers']; ?> left of <?php echo $reward['limit_backer'];?>)</span>
                        </p>
                        <p><span class="gone1"><?php echo $reward['begin_project'];?>&nbsp;&nbsp;&nbsp; to &nbsp;&nbsp;&nbsp;<?php echo $reward['end_project'];?></p>
                        <p class="ps">****<?php echo $reward['name'];?>****</p>
                        <p class="ps">• <?php echo htmlspecialchars_decode($reward['award']);?></p>
                        <p class="ps">
                            <span class="ps-span col-md-6 col-sm-6">Estimated delivery: <br><?php echo $reward['new_last'];?></span>
                            <span class="ps-span col-md-6 col-sm-6">Ships to: <br> <?php echo $reward['shipping_method']==1?'Limit countries or regions':'Anywhere in the world'?></span>
                        </p>
                        <div class="everyoneneirong">
                            <div class="xuxian"></div>
                            <div class="form-group" id="selecttttt">
                                <label for="sel">Shipping destination</label>
                                <select class="form-control" id="select_post<?php echo $reward['rewards_id'];?>">
                                    <?php if($reward['shipping_method']==2){ ?>
                                    <?php
                                          $length = count($reward['my_post']);
                                          for($n=0;$n<$length-1;$n++):
                                    ?>
                                    <option value="<?php echo $reward['my_post'][$n]['shipping_id'];?>"><?php echo $reward['my_post'][$n]['name'].'($'.$reward['my_post'][$n]['Postage'].')';?></option>
                                    <?php endfor; ?>
                                    <?php foreach($reward['my_post']['others_rows'] as $v):?>
                                    <option value="<?php echo $v['other_names'].$v['other_country_id'];?>" ><?php echo $v['other_names'];?><?php echo '($'. $reward['shipping_postage'] .')';?></option>
                                    <?php endforeach;?>
                                    <?php } elseif($reward['shipping_method']==0) { ?>
                                    <?php foreach($reward['my_post'] as $v):?>
                                    <option value="<?php echo $v['other_names'].$v['other_country_id'];?>" ><?php echo $v['other_names'];?><?php echo '($'. $reward['shipping_postage'] .')';?></option>
                                    <?php endforeach;?>
                                    <?php } else { ?>
                                    <?php foreach($reward['my_post'] as $v): ?>
                                    <option value="<?php echo $v['shipping_id'];?>"><?php echo $v['name'].'($'.$v['Postage'].')';?></option>
                                    <?php endforeach;?>
                                    <?php }?>
                                </select>
                                <i class="fa fa-angle-down xialatubiao" ></i>
                            </div>
                            <div class="form-group">
                                <label for="tax">Pledge amount</label>
                                <input type="text" id="price_support_input<?php echo $reward['rewards_id'];?>" class="form-control"  placeholder="$10">
                                <input type="hidden" value="" id="price_support<?php echo $reward['rewards_id'];?>" class="form-control" >
                            </div>
                            <button type="button" id="submit_price<?php echo $reward['rewards_id'];?>" class="btn btn-primary btn-lg btn-block">Continue</button>
                            <script type="application/javascript">
                                $(document).ready(function () {
                                    var postage;
                                    var id = <?php echo $reward['rewards_id'];?>;
                                    var must = <?php echo $reward['pledge_amount']; ?>;
                                    $(document).ready(function () {
                                            var str =  $('#select_post'+id).find("option:selected").text();
                                            postage = str.replace(/[^0-9]+/g, '');
                                        $('#price_support'+id).val(must);
                                        $('#price_support_input'+id).val('$'+must);
                                        $('#price_support_input'+id).blur(function () {
                                            var price = $(this).val();
                                            if(!(!isNaN(price)))
                                            {
                                                price = price.substring(1);
                                                price = parseInt(price)-parseInt(postage);
                                            }
                                            $('#price_support'+id).val(price);
                                            if (price < must)
                                            {
                                                $('#price_support_input'+id).attr('style','border:1px solid red');
                                                $('#submit_price'+id).attr('disabled','disabled');
                                            } else {
                                                $('#price_support_input'+id).attr('style','border:1px solid white');
                                                $('#submit_price'+id).removeAttr('disabled');
                                            }
                                        });

                                        $('#select_post'+id).change(function () {

                                            var str =  $('#select_post'+id).find("option:selected").text();
                                            postage = str.replace(/[^0-9]+/g, '');
                                            $('#price_support_input'+id).val('$'+(parseInt(must)+parseInt(postage)));
                                        });

                                    });
                                    $("#submit_price<?php echo $reward['rewards_id'];?>").click(function () {

                                        var price = $("#price_support<?php echo $reward['rewards_id'];?>").val();
                                        var is_limit = <?php echo $reward['limit_availability'];?>;
                                        //var is_limit_backer_availabilit = <?php echo $reward['limit_backer_availability'];?>
                                        var stock    = <?php echo $reward['stock'];?>;
                                        var rewards_id = <?php echo $reward['rewards_id'];?>;
                                        var shipping_id = $('#select_post'+id).val();
                                        var input_post = $('input[name="input_post"]').val();
                                        $('#input_post').val(shipping_id);
                                        $('#reward_id_input').val(rewards_id);

                                        if(price <  <?php echo $reward['pledge_amount'];?>)
                                        {
                                           // alert('Not reached the amount of money');
                                            return;
                                        }
                                        $('#input_support_price').val(price);

                                        if(input_post== null)
                                        {
                                            //alert('Please select postage');
                                            return;
                                        }
                                        $('#pay_form').submit();

                                    });
                                });
                            </script>
                        </div>
                    </li>
                    <?php }else{ ?>
                    <li>
                        <p class="ple">Pledge $<?php echo $reward['pledge_amount']; ?> or more</p>
                        <p>
											<span class="backspan">
												<i class="fa fa-male"></i>
                                                <?php echo $reward['all_man'];?> backers
											</span>
                            <span class="gone">All gone!</span>
                        </p>
                        <p><span class="gone1" ><?php echo $reward['begin_project'];?>&nbsp;&nbsp;&nbsp; to &nbsp;&nbsp;&nbsp;<?php echo $reward['end_project'];?></p>
                        <p class="ps">****<?php echo $reward['name'];?>****</p>

                        <?php echo htmlspecialchars_decode($reward['award']);?>

                        <p class="ps">
                            <span class="ps-span col-md-6 col-sm-6">Estimated delivery: <br> <?php echo isset($reward['new_last'])?$reward['new_last']:0;?></span>
                            <span class="ps-span col-md-6 col-sm-6">Ships to: <br> <?php echo $reward['shipping_method']==1?'Limit countries or regions':'Anywhere in the world'?></span>
                        </p>
                      <!--  <div class="everyoneneirong">
                            <div class="xuxian"></div>
                            <div class="form-group" id="selecttttt">
                                <label for="sel">Shipping destination</label>
                                <select class="form-control" id="sel">
                                    <option>china</option>
                                    <option>2</option>
                                    <option>3</option>
                                    <option>4</option>
                                    <option>5</option>
                                </select>
                                <i class="fa fa-angle-down xialatubiao" ></i>
                            </div>
                            <div class="form-group">
                                <label for="tax">Pledge amount</label>
                                <input type="text" class="form-control" id="tax" placeholder="$54">
                            </div>
                            <button type="button" class="btn btn-primary btn-lg btn-block">Continue</button>
                        </div>-->
                    </li>
                    <?php } ?>
                    <?php endif; ?>
                    <?php endforeach;?>
                </ul>
            </div>
        </div>
        <form action="<?php echo $payment;?>" method="post" id="pay_form">
            <input type="hidden" name="funding_id" value="<?php echo $funding_id;?>"/>
            <input type="hidden" name="support_price" id="input_support_price" value=""/>
            <input type="hidden" name="reward_id" id="reward_id_input" value=""/>
            <input type="hidden" name="input_post" id="input_post" value=""/>
        </form>

 <!---必带----->
    </div>
</article>
</div>
<!---必带----->
<?php echo $index_js?>
<?php echo $footer?>