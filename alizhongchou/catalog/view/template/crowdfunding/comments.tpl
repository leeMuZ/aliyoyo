<?php echo $header;?>
<?php echo $index_goods?>
<article class="campaign">
    <div class="scroll-inforlink">
        <ul class="inforlink">
            <?php
            foreach($link as $k=>$v):
            ?>
            <li><button class="<?php echo $k=='comments'?'btn forlinkactive':'btn';?>" onclick="window.location.href='<?php echo $v;?>'"><?php echo $k; ?></button></li>
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
    <div class="campaigntableall">
        <!-- ======================================table all one ============================================= -->
    </div>
        <div class="campaigntable campaigntableall-active col-md-12 col-sm-12" id="campaigntable-three">
            <div class="Commentarea col-md-12 col-sm-12">
                <div class="onlybacks col-md-offset-2 col-md-8 col-sm-12">
                    Only backers can post comments. If you have a question,
                    <span class="asking"  data-toggle="modal" data-target="#exampleModal">&nbsp;ask the project creator.</span>
                </div>
                <!-- asking neirong -->
                <!-- Modal -->
                <div class="modal fade asking-model" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
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
                <!-- asking neirong end-->
                <div class="commentssection col-md-12 col-sm-12">
                    <ul class="col-sm-8">
                        <?php if(!empty($index_comments)):?>
                        <?php foreach($index_comments as $k=>$v):?>
                        <li>
                            <div class="lileft">
                                <img src="<?php echo $v['image'];?>" alt="">
                            </div>
                            <div class="liright">
                                <p class="commonname">
                                    <span class="spanblack"><?php echo $v['firstname']." ".$v['lastname'];?></span>
                                    <span class="spanriqi"><?php echo $v['date_added'];?></span>
                                </p>
                                <p class="commoncontent"><?php echo $v['content'];?></p>
                                <?php if(isset($customer_id) && $customer_id==$owner['customer_id']):?>
                                <input type="hidden" name="reply<?php echo $k;?>" value="<?php echo $v['wait_id'];?>"/>
                                <input type="hidden" name="comment<?php echo $k; ?>" value="<?php echo $v['comment_id']?>"/>
                                <i class="fa fa-reply reply " id="icon<?php echo $k;?>" style="display: block;"></i>
                                <?php endif;?>
                                <div class="replyed ">
                                    <?php
                                     foreach($reply as $kk=>$vv):
                                    if($vv['target_comment_id']==$v['comment_id']):
                                    ?>
                                    <script>
                                        $(document).ready(function () {
                                                $('#icon<?php echo $k; ?>').css('display','none');
                                            }
                                        );
                                    </script>
                                    <div class="lileft newlileft">
                                        <img src="<?php echo $vv['image'];?>" alt="">
                                    </div>
                                    <div class="liright newliright">
                                        <p class="commonname newcommonname ">
                                            <span class="spanblack"><?php echo $vv['firstname']." ".$vv['lastname'];?></span>
                                            <span class="spanriqi"><?php echo $vv['date_added'];?></span>
                                        </p>
                                        <p class="commoncontent newcommoncontent "><?php echo $vv['content'];?></p>
                                    </div>
                                    <?php
                                    endif;
                                    endforeach;
                                   ?>
                                </div>
                                <div class="replynonespeak col-sm-12">
                                    <textarea name="" id="reply_content<?php echo $k;?>" rows="5"></textarea>
                                    <div class="replybtn clearfix">
                                        <button class="btn replyclick" onclick="reply(<?php echo $k;?>)">Reply</button>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <?php endforeach;?>
                        <?php endif;?>
                    </ul>
                    <div class="pinglun-div col-md-offset-1 col-md-10 col-sm-offset-1 col-sm-10">
                        <div class="col-md-12 col-sm-12">
                            <textarea name="content" id="comment_content" cols="30" rows="10"></textarea>
                        </div>
                        <div class="col-md-12 col-sm-12 pinglun-divbutton">
                            <input type="hidden" name="my_customer_id" value="<?php echo isset($customer_id)?$customer_id:''; ?>"/><!--之后写入当前用户ID-->
                            <input type="hidden" name="this_funding_id" value="<?php echo $id;?>"/>
                            <button id="my_submit" type="submit" class="btn">Sumblit</button>
                        </div>
                    </div>
                        <script type="application/javascript">
                            $('#my_submit').click(function () {
                                var customer = $('input[name="my_customer_id"]').val();
                                if(customer == "")
                                    {
                                        alert("please login");
                                        window.location.href = "<?php echo $login;?>";
                                        return;
                                    }
                                var funding  = $('input[name="this_funding_id"]').val();
                                var content  = $('#comment_content').val();
                                $.post('<?php echo $comment_post;?>', {'customer':customer, 'funding':funding, 'content':content}, function (data) {
                                       if (data==1) {
                                           history.go(0);
                                       }else {
                                           alert('You also did not support the project!');
                                       }
                                })
                            });
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
                           var customer_id = <?php echo $customer_id;?>;
                           var content     = $('#reply_content'+n).val();
                            var funding  = $('input[name="this_funding_id"]').val();
                           $.post('<?php echo $comment_post;?>',{'customer':customer_id, 'comment_id':comment_id, 'funding':funding, 'content':content},function (data) {
                               if (data==1) {
                                   history.go(0);
                               }
                           })
                        }
                    </script>
                </div>
            </div>
        </div>
        <!---必带----->
    </div>
</article>
</div>
<!---必带----->
<?php echo $index_js?>
<?php echo $footer?>