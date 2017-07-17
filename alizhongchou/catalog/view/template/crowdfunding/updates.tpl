<?php echo $header;?>
<?php echo $index_goods?>
<article class="campaign">
    <div class="scroll-inforlink">
        <ul class="inforlink">
            <?php
            foreach($link as $k=>$v):
            ?>
            <li><button class="<?php echo $k=='updates'?'btn forlinkactive':'btn';?>" onclick="window.location.href='<?php echo $v;?>'"><?php echo $k; ?></button></li>
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

            <div class="campaigntable-active" id="show_message_div">
                <!-- left -->
                <div class="timeaxis col-md-12 col-sm-12">
                    <div class="kongbai"></div>
                    <div class="timeline">
                        <?php foreach($update as $k=>$v):?>
                        <div class="timeline__item timeline__item--<?php echo $k%2==0?'left':'right';?>">
                            <div class="grid-post link">
                                <p class="grid-post__date">
                                    <!-- <time>February 12</time> -->
                                    <span><?php echo $v['date_added'];?></span>
                                </p>
                                <h2 class="grid-post__title">
                                   <?php echo $v['title'];?>
                                </h2>
                                <p class="gard-post_p">
                                    Dear Backers:
                                    <br><br>
                                    <?php echo htmlspecialchars_decode($v['content']).'.......';?>
                                    <a href="javascript:void(0);" data-text="readme-<?php echo $k+1;?>" class="turn-off">Read more</a>
                                </p>
                                <div class="grid-post__metadata">
													<span>
														<em><?php echo $v['comment_num'];?></em>
														comments
													</span>
                                    &nbsp;&nbsp;&nbsp;
                                   <!-- <span>
														<em><?php echo $v['like_num'];?></em>
														likes
													</span>-->
                                </div>
                            </div>
                        </div>
                        <?php endforeach;?>

                    </div>
                    <div class="timeline__divider timeline__divider--launched timeline__divider--launched--food">
                        <div class="timeline__divider_content">
                            <div class="f5 bold mb2">
                                <span>February 12</span>
                            </div>
                            <div class="f2">
                                Project launched
                            </div>
                        </div>
                    </div>
                </div>
                <!-- end -->
                <!-- right -->

                <!-- end -->
            </div>
        <?php foreach($update as $k=>$v): ?>
            <div class="readme col-md-12 col-sm-12"  id="readme-<?php echo $k+1;?>">
                <div class="Commentarea col-md-12 col-sm-12">
                    <div class="readmeall col-md-8 col-sm-12">
                        <div class="updataid">
                            <p class="col-md-10 col-sm-10 idj">Update #<?php echo $k+1;?></p>
                            <p class="col-md-2 col-sm-2 "><?php echo $v['date_added'];?></p>
                        </div>
                        <h2><?php echo $v['title'];?></h2>
                        <div class="grid-post__metadata">
										<span>
											<em><?php echo $v['comment_num'];?></em>
											comments
										</span>
                            &nbsp;&nbsp;&nbsp;
                            <span>
											<em><?php echo $v['like_num'];?></em>
											likes
										</span>
                        </div>
                        <p class="gard-post_p">
                            <div class="duanluoone">
                            <?php echo htmlspecialchars_decode($v['content']);?>
                    </div>
                    <div class="duanluoone">


                        <div onclick="history.go(0);"  style="background-color: lightgrey;width: 135px;cursor:pointer;">
                            Return to Update
                        </div>
                        <div class="Commentarea col-md-12 col-sm-12">
                            <p class="coments">Comments</p>
                            <div class="onlybacks">
                                Only backers can post comments. If you have a question,
                                <span class="asking"  data-toggle="modal" data-target="#exampleModaltwo<?php echo $k+1;?>">&nbsp;ask the project creator.</span>
                            </div>
                            <!-- model -->
                            <div class="modal fade asking-model" id="exampleModaltwo<?php echo $k+1;?>" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
                                <div class="modal-dialog" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                            <h4 class="modal-title" id="exampleModalLabel">Ask the project creator</h4>
                                        </div>
                                        <div class="modal-body">
                                            <p>If you have any questions please send an email to </p>
                                            <p class="modelp-bold"><?php echo $owner['email']; ?></p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- model end -->
                            <div class="commentssection">
                                <?php if(!empty($v['now_comment'])){ ?>
                                <ul class="">
                                    <?php foreach($v['now_comment'] as $kk=>$vv):?>
                                    <li>
                                        <div class="lileft">
                                            <img src="<?php echo $vv['di']?>" alt="">
                                        </div>
                                        <div class="liright">
                                            <p class="commonname">
                                                <span class="spanblack"><?php echo $vv['firstname'].' '.$vv['lastname'];?></span>
                                                <span class="spanriqi">
                                                    <?php
                                                     $time =  date("Y-m-d H:i:s", time());
                                                     $now_time = strtotime($time);
                                                     $start_time = strtotime($vv['date_added']);
                                                     $change = $now_time-$start_time;

                                                     switch($change){
                                                          case $change < 60:
                                                          $str = $change." seconds ago";
                                                          break;
                                                          case $change < 3600;
                                                          $str = floor($change/60)." minutes ago";
                                                          break;
                                                          case $change < 86400;
                                                          $str = floor($change/3600)." hours ago";
                                                          break;
                                                          case $change < 2592000;
                                                          $str = floor($change/86400)." days ago";
                                                          break;
                                                          default:
                                                          $str = "long time ago";
                                                     }
                                                        echo $str;
                                                     ?></span>
                                            </p>
                                            <p class="commoncontent"><?php echo $vv['content'];?></p>

                                            <?php if(isset($customer_id) && $customer_id == $owner['customer_id']):?>
                                            <input type="hidden" name="reply<?php echo $kk;?>" value="<?php echo $vv['wait_id'];?>"/>
                                            <input type="hidden" name="comment<?php echo $kk; ?>" value="<?php echo $vv['comment_id']?>"/>
                                            <i class="fa fa-reply reply " id="icon<?php echo $kk;?>" style="display: block;"></i>
                                            <?php endif;?>
                                            <div class="replyed ">
                                             <?php
                                             if(isset($reply)):
                                                foreach($reply as $k3=>$v3):
                                                if($v3['target_comment_id']==$vv['comment_id']):
                                                ?>
                                                <script>
                                                    $(document).ready(function () {
                                                            $('#icon<?php echo $kk; ?>').css('display','none');
                                                        }
                                                    );
                                                </script>
                                                <div class="lileft newlileft">
                                                    <img src="<?php echo $v3['image'];?>" alt="">
                                                </div>
                                                <div class="liright newliright">
                                                    <p class="commonname newcommonname ">
                                                        <span class="spanblack"><?php echo $v3['firstname']." ".$v3['lastname'];?></span>
                                                        <span class="spanriqi"><?php echo $v3['date_added'];?></span>
                                                    </p>
                                                    <p class="commoncontent newcommoncontent "><?php echo htmlspecialchars_decode($v3['content']);?></p>
                                                </div>
                                             <?php
                                                endif;
                                                endforeach;
                                                endif;
                                                ?>
                                            </div>
                                            <div class="replynonespeak col-sm-12">
                                                <textarea name="" id="reply_content<?php echo $kk;?>" rows="5"></textarea>
                                                <div class="replybtn clearfix">
                                                    <button class="btn replyclick" onclick="reply(<?php echo $kk;?>)">Reply</button>
                                                </div>
                                            </div>
                                        </div>
                                    </li>
                                    <?php  endforeach;?>
                                </ul>
                                <?php }?>
                                <!-- yincang bufen -->

                                <div class="pinglun-div col-md-offset-1 col-md-10 col-sm-offset-1 col-sm-10">
                                    <?php if(isset($customer_id) && $customer_id != $owner['customer_id']):?>
                                    <div class="col-md-12 col-sm-12">
                                        <textarea  id="text_comment<?php echo $v['update_id']?>" cols="30" rows="10"></textarea>
                                    </div>

                                    <div class="col-md-12 col-sm-12 pinglun-divbutton">
                                        <input type="hidden" name="customer_id" value="<?php echo isset($customer_id)?$customer_id:''; ?>"/>
                                        <button class="btn" id="post_comment<?php echo $v['update_id'];?>">Sumblit</button>
                                    </div>
                                    <?php endif;?>
                                    <script>
                                        $("#post_comment<?php echo $v['update_id'];?>").click(function () {

                                            var comment     = $('#text_comment'+<?php echo $v['update_id']?>).val();
                                            var customer_id = $("input[name='customer_id']").val();
                                            if(customer_id=="")
                                            {
                                                alert("please login");
                                                window.location.href = "<?php echo $login;?>";
                                                return;
                                            }
                                            $.post('<?php echo $ajax;?>', {'funding_id':<?php echo $v['funding_id'];?>,'update_id':<?php echo $v['update_id']; ?>,'customer_id':customer_id,'content':comment}, function (data) {
                                                                            if(data==1) {
                                                                                alert('Successful publication!');
                                                                                history.go(0);
                                                                            }else {
                                                                                alert('failed');
                                                                            }

                                            });
                                            }
                                        );
                                    </script>

                                    <script>
                                        // 回复框内容js

                                        $(".reply").click(function(event) {
                                            var dd=$(this).siblings('.replynonespeak');
                                            if(!dd.hasClass('grid-post')){
                                                dd.addClass('grid-post');
                                            }else{
                                                dd.removeClass('grid-post');
                                            }
                                        });
                                        /*$(".replyclick").click(function(event) {
                                         $(this).parent().parent().removeClass('grid-post');
                                         $(this).parent().parent().siblings('.replyed').show();

                                         });*/


                                    </script>
                                    <script>
                                        function reply(n) {
                                            var comment_id = $('input[name="comment'+n+'"]').val();
                                            var customer_id = $("input[name='customer_id']").val();
                                            var content     = $('#reply_content'+n).val();
                                           // alert(customer_id);
                                            $.post('<?php echo $ajax;?>',{'customer_id':customer_id, 'comment_id':comment_id, 'funding_id':<?php echo $v['funding_id'];?>, 'update_id':<?php echo $v['update_id']; ?>, 'content':content},function (data) {
                                                if (data==1) {
                                                    history.go(0);
                                                }
                                            });
                                        }
                                    </script>
                                </div>
                                <!-- yincang bufen end-->
                            </div>
                        </div>
                    </div>
                    </p>
                </div>
            </div>
    </div>
        <?php endforeach;?>
    </div>

 <!---必带----->
        </div>
</article>
</div>
<!---必带----->
<?php echo $index_js?>
<?php echo $footer?>