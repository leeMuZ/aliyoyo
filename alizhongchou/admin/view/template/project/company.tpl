<?php echo $header;?><?php echo $column_left; ?>
		<script>
		 $(function(){
         $("input").attr("disabled","true");  	 
         $("select").attr("disabled","disabled");
		 $("textarea").attr("disabled","disabled");
		 $('.tclass').removeAttr("disabled");
		 $('#tclass').removeAttr("disabled");
 

    })
	</script>
	<style>
	  .disabled { pointer-events: none; }
	</style>
<link href="view/stylesheet/css/crowdfund.css" type="text/css" rel="stylesheet" />
<link href="view/stylesheet/css/datapage.css" type="text/css" rel="stylesheet" />
<link href="view/javascript/summernote/summernote.css" type="text/css" rel="stylesheet" />
<script src="view/stylesheet/jquery.countdown.js" type="text/javascript"></script>

<div class="shenhe_ing" style="background:#f5f5f5">	
  		<span style="float:right;margin-top:20px"><a href="javascript:history.go(-1);" data-toggle="tooltip" title="" class="btn btn-default" data-original-title="Cancel"><i class="fa fa-reply"></i></a></span>

		<div class="container" style="background:#f5f5f5">
			<div class="validate">
					<div class="validateleft col-md-8 col-sm-8">
						<ul class="validateleftul ">
							<li class=""><a class="validateleftul-li-hover" href="#project">产品信息</a></li>
							<li class=""><a href="#reward">奖金设置</a></li>
							<li class=""><a href="#description">产品详情</a></li>
							<li class=""><a href="#account">公司认证</a></li>
						     
						</ul>
					</div>
					<div class="validateright col-md-4 col-sm-4">
						<div class="validaterightone col-md-6 col-sm-6">
							 <a href="#view" ><p class="btn  btn-lg">预览</p></a>
						</div>
						<div class="validaterightone col-md-6 col-sm-6">
							 <a href="#status" id="review"><p class="btn  btn-lg"  data="<?php echo $project['funding_id']?>" data-status="<?php  echo $project['status'];?>" ><?php if($project['status']==0){ echo "提交";}else{echo "状态";}?></p></a>
						</div>
					</div>
				</div>
				<!-- 正文部分 -->
				
				<div class="validatesubstance tab-content" >
					<div class="validatesubstancecontent active tab-pane" id="project"> 
				<form class="form-horizontal"  action="index.php?route=project/crowdfund/project" method="post" enctype="multipart/form-data" >
						<input type="hidden" name="funding_id" value="<?php echo $project['funding_id']?>"> 
						<div class="validate-table-one col-md-push-1 col-md-10 col-sm-12">
							<!-- <p class="information-p">企业证件信息</p> -->
							    <div class="form-group">
							        <label  class="col-sm-2 control-label"><em>*</em>&nbsp;&nbsp;项目图片：</label>
							    	<div class="col-sm-8 certificate xiangmutupian">
								    	<div class="large_img_div">
											<img src="<?php  echo $project['image_src']?>" alt="" class="uploadimg impotimg " >
											
											<i class='fa fa-close' onclick='removeImg(this)'></i>
											
										</div>
										<span class="sportsevent-span">这是人们第一次看到你项目时的图片，图片支持JPG, PNG, GIF, 和BMP格式。5MB以内。至少为1024x576px，长宽比为5:3。</span>
								    </div>
								    <div class="shade" >
										<div class="">
											<span class="text_span">
											</span>
										</div>
									</div>
							    </div>
							  	<div class="form-group">
							        <label  class="col-sm-2 control-label"><em>*</em>&nbsp;&nbsp;项目名称：</label>
							    	<div class="col-sm-8 certificate ">
							      		<input type="text" class="form-control " required name="project_name" value="<?php  echo $project['name']?>" id="projectmingc" maxlength="60" onblur="if(!(/^[0-9a-zA-Z]*$/g.test(this.value)) ){$('.missing').text('不能輸入中文,且字符長度小於等於60');this.value=value.replace(/[\W]/g,'');$(this).addClass('border-color');this.focus();}else{$('.missing').text('');$(this).removeClass('border-color')}"  >
							      		<span class="missing"></span>
							      		<span class="sportsevent-span">用户搜索的时候可以搜索查找到你的项目标题，所以让他们清楚明白你在做什么，才可以让他们明智的选择你。请填写英文。</span>
							    	</div>
							    </div>
							    <div class="form-group">
							        <label  class="col-sm-2 control-label"><em>*</em>&nbsp;&nbsp;项目简介：</label>
							    	<div class="col-sm-8 certificate ">
							      		<textarea  class="form-control " name="project_introduce"  rows="4"  maxlength="135" onblur="if(!(/^[0-9a-zA-Z]*$/g.test(this.value)) ){$('.missed').text('不能輸入中文,且字符長度小於等於135');this.value=value.replace(/[\W]/g,'');$(this).addClass('border-color');this.focus();}else{$('.missed').text('');$(this).removeClass('border-color')}"><?php  echo $project['introduce']?></textarea>
							      		<span class="missed"></span>
							      		<span class="sportsevent-span">请一句话简短的介绍一下你的产品。您填写的内容将会在首页中显示。</span>
							    	</div>
							    </div>
							    <div class="form-group">
							        <label  class="col-sm-2 control-label"><em>*</em>&nbsp;&nbsp;类别：</label>
							    	<div class="col-sm-8 certificate ">
							    		<div class="select_box form-control valid-item"  >
							                <span class="select_txt"></span>
							                <a class="selet_open">
							                	<i class="fa fa-angle-down"></i>
							                </a>
							                <div class="option">
							                    <ul>
							                    <?php foreach ($categories as $key=>$val){?>
							                          <?php if($key==0){?>
							                              <li class="option_li">
							                          <?php }?>
							                           <?php if(is_int($key/12) && $key!=0){?>
							                               </li><li class="option_li">
							                           <?php }?>
							                           <a value="<?php echo $val['category_id']; ?>" ><?php echo $val['name'];?></a>
							                           
							                    <?php }?>
												</ul>
							                </div>
							            </div>
							      		<input type="hidden" name="project_category" class="form-control">
							    	</div>
							    </div>
							    <div class="form-group">
							        <label  class="col-sm-2 control-label"><em>*</em>&nbsp;&nbsp;众筹周期：</label>
							    	<div class="col-sm-8 certificate zhouqi">
							    		<span class="action-data">开始时间</span>
							      		<input type="text" class="form-control col-sm-6 action-input action-inputfirst-child" value="<?php  echo $project['date_start']?>" name="date_start"  onClick="laydate({choose:DateCallBack})">
							      		<span class="action-data action-inputlast-child">结束时间</span>
							      		<input type="text" class="form-control clo-sm-6 action-input " name="date_ended" value="<?php  echo $project['date_ended']?>" id="date" onClick="laydate({choose:DateCallBack})">
							      		<span class="sportsevent-span active-span">周期越短的项目有较高的成功率。当项目发出后，您将无法调节你的持续时间(建议30天到60 )。</span>
							      	</div>
							    </div>
							    <div class="form-group">
							        <label  class="col-sm-2 control-label"><em>*</em>&nbsp;&nbsp;众筹目标：</label>
							    	<div class="col-sm-8 certificate ">
							      		<input type="text" name="total_goal" value="<?php  echo $project['total_goal']?>" class="form-control " onkeyup="this.value=this.value.replace(/[^\d\.]/g,'')" onafterpaste="this.value=this.value.replace(/[^\d\.]/g,'')">
							      	</div>
							    </div>
							
						</div>	
					</div>
					</form>
					<div class="validatesubstancecontent tab-pane" id="reward">
					<form class="form-horizontal"  action="index.php?route=project/crowdfund/rewards" method="post" enctype="multipart/form-data">
					<input type="hidden" name="funding_id" value="<?php  echo $project['funding_id']?>">
						<div class="validate-table-one col-md-push-1 col-md-10 col-sm-12" id="appfather">
							
								<ol class="getabonus col-md-push-2 col-md-8 col-sm-push-1 col-sm-10 fields rewards m0">
									<?php foreach ($rewards as $key=>$reward){?>
									<li class="getabonusall">
									<input type="hidden" name='reward[<?php echo $key;?>][rewards_id]' value="<?php  echo $reward['rewards_id']?>">
                                        <div class="getabonus-left col-sm-2">
                                        <p><em>*</em>&nbsp;&nbsp;奖励</p>
                                        <p>&nbsp;&nbsp;<?php echo $reward['backers']; ?> 支持者</p>
                                        </div>
                                        <div class="getabonus-right col-sm-10">
                                            <div class="form-group biaogeform">
                                                <label class="col-sm-3 biaogelable">标题</label>
                                                <div class="col-sm-9 biaogediv">
                                                    <input class="form-control biaogeinput" name="reward[<?php echo $key;?>][tile]" value="<?php  echo $reward['name']?>">
                                                </div>
                                            </div>
                                            <div class="form-group biaogeform">
                                                <label class="col-sm-3  biaogelable">赞助额度</label>
                                                <div class="col-sm-9 biaogediv">
                                                    <input  class="form-control biaogeinput" name="reward[<?php echo $key;?>][pledge_amount]" value="<?php  echo $reward['pledge_amount']; ?>" onkeyup="this.value=this.value.replace(/[^\d\.]/g,'')" onafterpaste="this.value=this.value.replace(/[^\d\.]/g,'')"> 
                                                </div>
                                            </div>
                                            <div class="form-group biaogeform">
                                                <label class="col-sm-3  biaogelable biaogelable-three">描述</label>
                                                <div class="col-sm-9 biaogediv reward_description"  >
                                                    <textarea id="ccol_id" rows="4"  class="form-control biaogeinput biaogeinput-three" 
                                                    style="background:#fff;" name="reward[<?php echo $key;?>][description]" ><?php  echo $reward['description']?></textarea>
                                                </div>
                                            </div>
                                            <div class="form-group biaogeform">
                                                <label class="col-sm-3  biaogelable">预计交货时间</label>
                                                <div class="col-sm-9 biaogediv">
                                                    <select class="form-control biaogeinput col-sm-6 select-year" name="reward[<?php echo $key;?>][estimated_delivery_year]" >
                                                    	<option value="">选择年</option>
                                                    	<?php foreach ($estimated_setting['years'] as $year){?>
                                                    	<?php if($year==$reward['estimated_year']){?>
                                                    	 <option value="<?php  echo $year;?>" selected="selected"><?php echo $year;?></option>
                                                    	<?php }else{?>
                                                    	<option value="<?php  echo $year;?>"><?php echo $year;?></option>
                                                    	<?php }?>
                                                    	<?php }?>
                                                    </select>
                                                    <select class="form-control biaogeinput col-sm-6 select-year" name="reward[<?php echo $key;?>][estimated_delivery_month]" >
                                                    	<option value="">选择月</option>
                                                    	<?php foreach ($estimated_setting['months'] as $month){?>
                                                    	<?php if($month==$reward['estimated_month']){?>
                                                    	 <option value="<?php  echo $month;?>" selected="selected"><?php echo $month;?>月</option>
                                                    	<?php }else{?>
                                                    	<option value="<?php  echo $month;?>"><?php echo $month;?>月</option>
                                                    	<?php }?>
                                                    	<?php }?>
                                                    </select>
                                                   
                                                </div>
                                            </div>
                                            <div class="form-group biaogeform">
                                                <label for="inputEmail3" class="col-sm-3  biaogelable heightauto">运输事项</label>
                                                <div class="col-sm-9 biaogediv">
                                                     <select class="form-control biaogeinput selectchange" name="reward[<?php echo $key;?>][shipping_method]">
                                                     	<option value="0" <?php  if($reward['shipping_method']==0){echo 'selected="selected"';}?>>无需物流费用</option>
                                                     	<option value="1" <?php  if($reward['shipping_method']==1){echo 'selected="selected"';}?>>指定物流国家</option>
                                                     	<option value="2" <?php  if($reward['shipping_method']==2){echo 'selected="selected"';}?>>全球物流</option>
                                                     </select>
                                                    <ul class="shipping-rules">
                                                    	<li class='nnn bbb'>
                                                    		<select  class='col-sm-6'>
                                                    			<option >世界其他国家</option>
                                                    		</select>
                                                    		<input type='text' class='col-sm-6 '  name="reward[<?php echo $key;?>][shipping_postage]" value ="<?php  echo $reward['shipping_postage']?>" onkeyup="this.value=this.value.replace(/[^\d\.]/g,'')" onafterpaste="this.value=this.value.replace(/[^\d\.]/g,'')">
                                                    	</li>
                                                    	    <?php foreach ($reward['shippings'] as $shipping){?>
                                                    	        <li class='nnn'>
                                                    	        <select name='reward[<?php echo $key;?>][rewards_shipping_country][<?php  echo $shipping['shipping_id'];?>][country]'  class='col-sm-6'>
                                                    	        <option value="0">选择国家</option>
                                                    	        <?php foreach ($countries as $countrie){?>
                                                    	        <?php if($countrie['country_id']==$shipping['country_id']){?>
                                                    			<option value='<?php  echo $countrie['country_id']?>' selected="selected"><?php  echo $countrie['name']?></option>
                                                    			<?php }else{?>
                                                    			<option value='<?php  echo $countrie['country_id']?>' ><?php  echo $countrie['name']?></option>
                                                    			<?php }?>
                                                    			<?php }?>
                                                    			<input type='text' class='col-sm-6 '  name="reward[<?php echo $key;?>][rewards_shipping_Postage][<?php  echo $shipping['shipping_id'];?>][postage]" value="<?php  echo $shipping['Postage']?>" onkeyup="this.value=this.value.replace(/[^\d\.]/g,'')" onafterpaste="this.value=this.value.replace(/[^\d\.]/g,'')">
                                                    			<i class="fa fa-close shanchu" data='<?php  echo $shipping['shipping_id'];?>'></i>
                                                    	        </select>
                                                    	        </li>
                                                    	    <?php }?>
                                                     	<li class="addguojia" data_sort="<?php echo $key;?>"><span href=""><i class="fa fa-plus"></i>添加新的国家</span></li>

                                                    </ul>
												</div>
                                            </div>
                                            <div class="form-group biaogeform havebottom-line">
                                                <label class="col-sm-3 biaogelable xianeshuoming">限额说明</label>
                                                <div class="col-sm-9 xianzhi">
                                                	<div class="xiane">	
														<input type="checkbox" class="clickbox " name="reward[<?php echo $key;?>][limit_availability]" value="1" <?php if($reward['limit_availability']){echo 'checked="checked"';} ?> >&nbsp;&nbsp;添加限制额度
                                                	</div>
                                                    
                                                    <div class="moremoney">
                                                    	<div class="money-div">
                                                    		<input type="checkbox" class="large-input" name="reward[<?php echo $key;?>][limit_backer_availability]" value="1" <?php  if($reward['limit_backer_availability']){echo 'checked="checked"';}?>>&nbsp;&nbsp;份数限制
                                                    		<input type="text" class="little-input form-control" value="<?php  if($reward['limit_backer_availability']){echo $reward['limit_backer'];}?>" name="reward[<?php echo $key;?>][limit_backer]" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')">
                                                    	</div>
                                                    	<div class="money-div">
                                                    		<input type="checkbox" class="shijianxian-large-input " name="reward[<?php echo $key;?>][limit_time_availability]" value="1"  <?php  if($reward['limit_time_availability']){echo 'checked="checked"';}?>>&nbsp;&nbsp;时间限制
                                                    		<div class="col-sm-4 datarili-div shijianxian">
													      		<input type="text" class="form-control shijianxian-input" placeholder="结束"  onClick="laydate({choose:DateCallBack})" name="reward[<?php echo $key;?>][limit_time_end]" value="<?php  if($reward['limit_time_availability']){echo $reward['limit_time_end'];}?>">
													      	</div>
													      	<div class="col-sm-4 datarili-div shijianxian">
													      		<input type="text"  class="form-control shijianxian-input" placeholder="开始"  onClick="laydate({choose:DateCallBack})" name="reward[<?php echo $key;?>][limit_time_begin]" value="<?php  if($reward['limit_time_availability']){echo $reward['limit_time_begin'];}?>">
													      		
													    	</div>
                                                    	</div>
                                                    </div>
                                                    
                                                </div>
                                            </div>
                                            
                                            
                                        </div>
                                        
                                        <div class="reward_delete col-sm-12">
                                                    <i class="fa fa-close"></i>
                                                                                                                                                        删除
                                        </div>
                                     </li>
                                     <?php }?>
                                     
                                     <li class="getabonusall" id="addprojuct"><div class="addprojuct">
                                                <div class="addprojuct-left col-sm-12">
                                                    <i class="fa fa-plus"></i>
                                                                                                                                                                         添加一个新的项目
                                                </div>
                                            </div></li>
								</ol>
						</div>
								
					</div>
					</form>
					<div class="validatesubstancecontent tab-pane" id="description">
					<form class="form-horizontal"  action="index.php?route=project/crowdfund/description" method="post" enctype="multipart/form-data">
					<input type="hidden" name="funding_id" value="<?php echo $project['funding_id']?>">
						<div class="validate-table-one col-md-push-1 col-md-10 col-sm-12">
							    <div class="form-group">
							        <label  class="col-sm-2 control-label"><em>*</em>&nbsp;&nbsp;产品视频：</label>
							    	<div class="col-sm-8 certificate ">
							      		    <input type="text" class="form-control video_input youtobe_video" name="project_video" value="<?php  echo $project['viedo'];?>">  
							      		    <button class="btn" type="button" onclick="checkVideoIsYoutobe()">添加视频</button>
							      		    <span class="sportsevent-span">请将视频上传止Youtube，然后将Youtube链接复制粘贴到上方的文本框，点击按钮即可添加视频。</span>
							      		   <div class="large_img_div" id="video_view">
											<img src="image/no_image.jpg" alt="" class="uploadimg impotimg">
										   </div>
											<i class='removeBtn fa fa-close' onclick='removeImg(this)'></i>
											<div class="shade" onclick="javascript:closeShade()">
												<div class="">
													<span class="text_span">
													</span>
												</div>
											</div>
							      		
							    	</div>
							    </div>
							  	<div class="form-group">
							        <label  class="col-sm-2 control-label"><em>*</em>&nbsp;&nbsp;产品描述：</label>
							    	<div class="col-sm-8 ">
							      		<textarea id="editor" class="form-control" name="project_description" style="display: none;" >
                                    <?php  echo $projectDescription['description']?>
										</textarea>
							    	</div>
							    </div>
							    
							    
							    <div class="form-group">
							        <label  class="col-sm-2 control-label"><em>*</em>&nbsp;&nbsp;风险和挑战：</label>
							    	<div class="col-sm-8 certificate ">
							    		<span class="fenxian-span">
							    			你的项目在进行过程中将要面对什么风险和挑战，以及你如何客服它们？每个项目都有其独特的风险，让你的支持者知道你准备如何克服这些挑战，阐述有哪些风险可能会导致延误或者改变你的生产计划。
										</span>
										<textarea name="risk_description"  rows="10" class="form-control form-control-fenxian" ><?php  echo $projectDescription['risk_description']?></textarea>
							      	</div>
							    </div>
						</div>	
					</div>
					</form>
					<div class="validatesubstancecontent tab-pane" id="account">
					<form class="form-horizontal"  action="index.php?route=project/crowdfund/companyAccount" method="post" enctype="multipart/form-data">
					<input type="hidden" name="funding_id" value="<?php echo $project['funding_id']?>">
						<div class="validate-table-one col-md-push-1 col-md-10 col-sm-12">
							<p class="information-p">企业证件信息</p>
							    <div class="form-group">
							        <label for="inputEmail1" class="col-sm-2 control-label"><em>*</em>&nbsp;&nbsp;法人代表：</label>
							    	<div class="col-md-4 col-sm-4">
							      		<input type="text" class="form-control" maxlength="10" name="name" value="<?php  echo $companyInfo['name']?>">
									</div>
							  	</div>
							  	<div class="form-group">
							        <label  class="col-sm-2 control-label"><em>*</em>&nbsp;&nbsp;法人身份证：</label>
							    	<div class="col-md-2 col-sm-3 certificate " >
							    		<div class="img_div ">
											<img src="<?php  echo $companyInfo['identity_image_face_src']?>" alt="" class="uploadimg impotimg" >
											<input type="file" name="myFile" id="myFile" multiple="multiple"  class="form-control form-control-contiuimg uploading"   >
											<input name="identity_image_face" type="hidden" class="upload_url" value="<?php  echo $companyInfo['identity_image_face']?>">
											<i class='fa fa-close' onclick='removeImg(this)'></i>
										</div>
							    		<span class="col-md-2">身份证正面</span>
							      	</div>
							    	<div class="col-md-2 col-sm-3 certificate ">
							      		<div class="img_div ">
											<img src="<?php  echo $companyInfo['identity_image_back_src']?>" alt="" class="uploadimg impotimg" >
											<input type="file" name="myFile" id="myFile" multiple="multiple"  class="form-control form-control-contiuimg uploading">
											<input name="identity_image_back" type="hidden" class="upload_url" value="<?php  echo $companyInfo['identity_image_back']?>">
											<i class='fa fa-close' onclick='removeImg(this)'></i>
										</div>
							      		<span class="col-md-2">身份证反面</span>
							      	</div>
							      	<div class="shade">
										<div class="">
											<span class="text_span">
											</span>
										</div>
									</div>
							  	</div>
							  	<div class="form-group">
							        <label  class="col-sm-2 control-label"><em>*</em>&nbsp;&nbsp;法人身份证：</label>
							       
							        <div class="col-sm-10 certificate-none">
							        	<label class="zheng col-sm-2" for="fourPhotos"><input type="radio" name="licenceType" value="0" id="fourPhotos" checked><img src="image/radio-current.png" alt="">非三证合一</label>
							        	<label  class="zheng col-sm-2" for="twoPhotos"> <input type="radio" name="licenceType" value="1" id="twoPhotos" ><img src="image/radio-normal.png" alt="">三证合一</label>
							        	<span class="span-zheng col-sm-8">(如果营业执照、组织机构代码证和税务登记证为一个证件，选择三证合一)</span>
								    </div>
							       <label  class="col-sm-2 control-label   showder"></label>
							        <div class="zhengjianall validate-active">
							        	<div class="col-md-2 col-sm-3 certificate ">
							        		<div class="img_div ">
											<img src="<?php  echo $companyInfo['businessLicence_src']?>" alt="" class="uploadimg impotimg">
											<input type="file"  id="myFile" multiple="multiple"  class="form-control form-control-contiuimg uploading">
											<input name="businessLicence" type="hidden" class="upload_url" value="<?php  echo $companyInfo['businessLicence']?>">
											<i class='fa fa-close' onclick='removeImg(this)'></i>
										</div>
								      		<span class="col-md-2">营业执照</span>
								      	</div>
								    	<div class="col-md-2 col-sm-3 certificate ">
								      		<div class="img_div ">
												<img src="<?php  echo $companyInfo['organizationCode_src']?>" alt="" class="uploadimg impotimg">
												<input type="file"  id="myFile" multiple="multiple"  class="form-control form-control-contiuimg uploading">
												<input name="organizationCode" type="hidden" class="upload_url" value="<?php  echo $companyInfo['organizationCode']?>">
												<i class='fa fa-close' onclick='removeImg(this)'></i>
												
											</div>
									      	<span class="col-md-2">组织机构代码</span>
								      	</div>
								    	<div class="col-md-2 col-sm-3 certificate "> 
								      		<div class="img_div ">
												<img src="<?php  echo $companyInfo['taxRegCertificate_src']?>" alt="" class="uploadimg impotimg">
												<input type="file"  id="myFile" multiple="multiple"  class="form-control form-control-contiuimg uploading">
												<input name="taxRegCertificate" type="hidden" class="upload_url" value="<?php  echo $companyInfo['taxRegCertificate']?>">
												<i class='fa fa-close' onclick='removeImg(this)'></i>
											</div>
								      		<span class="col-md-2">税务登记证</span>
								      	</div>
								    	<div class="col-md-2 col-sm-3 certificate ">
								      		<div class="img_div ">
												<img src="<?php  echo $companyInfo['bankAccPermits_src']?>" alt="" class="uploadimg impotimg">
												<input type="file"  id="myFile" multiple="multiple"  class="form-control form-control-contiuimg uploading">
												<input name="bankAccPermits" type="hidden" class="upload_url" value="<?php  echo $companyInfo['bankAccPermits']?>">
												<i class='fa fa-close' onclick='removeImg(this)'></i>
											</div>
								      		<span class="col-md-2">银行开户许可证照片</span>
								      	</div>
								      	<div class="shade" >
											<div class="">
												<span class="text_span">
												</span>
											</div>
										</div>
							        </div>
							        <div class="zhengjianall">
							        	<div class="col-md-2 col-sm-3 certificate ">
							        		<div class="img_div ">
												<img src="<?php  echo $companyInfo['businessLicence_src']?>" alt="" class="uploadimg impotimg">
												<input type="file"  id="myFile" multiple="multiple"  class="form-control form-control-contiuimg uploading">
												<input name="businessLicence1" type="hidden" class="upload_url" value="<?php  echo $companyInfo['businessLicence']?>">
												<i class='fa fa-close' onclick='removeImg(this)'></i>
											</div>
								      		<span class="col-md-2">营业执照</span>
								      	</div>
								    	<div class="col-md-2 col-sm-3 certificate ">
								      		<div class="img_div ">
												<img src="<?php  echo $companyInfo['organizationCode_src']?>" alt="" class="uploadimg impotimg">
												<input type="file"  id="myFile" multiple="multiple"  class="form-control form-control-contiuimg uploading">
												<input name="organizationCode1" type="hidden" class="upload_url" value="<?php  echo $companyInfo['organizationCode']?>">
												<i class='fa fa-close' onclick='removeImg(this)'></i>
											</div>
								      		<span class="col-md-2">组织机构代码</span>
								      	</div>
								      	<div class="shade">
											<div class="">
												<span class="text_span">
												</span>
											</div>
										</div>
								    </div>
							    </div>
							<p class="information-p">公司基本信息</p>
							    <div class="form-group">
							        <label for="inputEmail1" class="col-sm-2 control-label"><em>*</em>&nbsp;&nbsp;公司名称：</label>
							    	<div class="col-sm-4">
							      		<input type="text" class="form-control projectmingchen" name="company_name"  maxlength="30" value="<?php  echo $companyInfo['company_name']?>">
							    	</div>
							  	</div>
							  	<div class="form-group">
							        <label class="col-sm-2 control-label"><em>*</em>&nbsp;&nbsp;注册时间：</label>
							    	<div class="col-sm-4 datarili-div">
							      		<input type="text" class="form-control" onClick="laydate({choose:DateCallBack})" name="registeredTime" value="<?php  echo $companyInfo['registeredTime']?>">
							    	</div>
							  	</div>
							  	<div class="form-group">
							        <label class="col-sm-2 control-label"><em>*</em>&nbsp;&nbsp;联系电话：</label>
							    	<div class="col-sm-4">
							      		<input type="text" class="form-control" maxlength="20" name="phone" value="<?php  echo $companyInfo['phone']?>">
							    	</div>
							  	</div>
							  	<div class="form-group">
							        <label class="col-sm-2 control-label"><em>*</em>&nbsp;&nbsp;常用邮箱：</label>
							    	<div class="col-sm-4">
							      		<input type="text" class="form-control" name="email" value="<?php  echo $companyInfo['email']?>">
							    	</div>
							  	</div>
							  	<div class="form-group">
							        <label  class="col-sm-2 control-label"><em>*</em>&nbsp;&nbsp;公司详细地址：</label>
							        <input type="hidden" name="address_id" value="<?php  echo $companyInfo['address_id']?>">
							    	<div class="col-sm-10" id="distpicker1"  data-toggle="distpicker">
							      		<select class="form-control"  name="province">
							      		<option value=''>请选择</option>
							      		<?php foreach ($provinces as $province){?>
							      		<?php if($province['code']==$companyInfo['province_id']){?>
							      		<option value="<?php  echo $province['code'];?>" selected="selected"><?php echo $province['name'];?></option>
							      		<?php }else{?>
							      		<option value="<?php  echo $province['code'];?>"><?php echo $province['name'];?></option>
							      		<?php }?>
							      		<?php }?>
							      		</select>
							    		<select class="form-control" name="city">
							    		<option value=''>请选择</option>
							    		<?php foreach ($citys as $city){?>
							      		<?php if($city['code']==$companyInfo['city_id']){?>
							      		<option value="<?php  echo $city['code'];?>" selected="selected"><?php echo $city['name'];?></option>
							      		<?php }else{?>
							      		<option value="<?php  echo $city['code'];?>"><?php echo $city['name'];?></option>
							      		<?php }?>
							      		<?php }?>
							    		</select>
								    	<select class="form-control"  name="region">
								    	<option value=''>请选择</option>
								    	<?php foreach ($areas as $area){?>
							      		<?php if($area['code']==$companyInfo['area_id']){?>
							      		<option value="<?php  echo $area['code'];?>" selected="selected"><?php echo $area['name'];?></option>
							      		<?php }else{?>
							      		<option value="<?php  echo $area['code'];?>"><?php echo $area['name'];?></option>
							      		<?php }?>
							      		<?php }?>
								    	</select>
							    	</div>
							    	
							    	<label  class="col-sm-2 control-label"></label>
							    	<div class="col-small-6 vbidaddress">
							    		<input type="text" class="form-control" placeholder="详细地址"  maxlength="60" name="company_address" value="<?php  echo $companyInfo['address']?>">
							    	</div>
							  	</div>
							  	<div class="form-group">
							        <label class="col-sm-2 control-label"><em>*</em>&nbsp;&nbsp;公司详细介绍：</label>
							    	<div class="col-small-6">
							      		<textarea class="form-control" id="inputlength" maxlength="100" rows="5" name="company_description"><?php  echo $companyInfo['company_description']?></textarea>
									</div>
							    	<span class="col-sm-3 produace">一句话介绍你的公司，50字以内</span>
							  	</div>
							<p class="information-p">收款人信息</p>
							    <div class="form-group">
							        <label  class="col-sm-2 control-label"><em>*</em>&nbsp;&nbsp;收款人姓名：</label>
							    	<div class="col-sm-4">
							      		<input type="text" class="form-control projectmingchen"  maxlength="30" name="payee" value="<?php  echo $companyInfo['payee']?>">
							    	</div>
							  	</div>
							  	<div class="form-group">
							        <label class="col-sm-2 control-label"><em>*</em>&nbsp;&nbsp;收款人电话：</label>
							    	<div class="col-sm-4 ">
							      		<input type="text" class="form-control" name="payee_phone" value="<?php  echo $companyInfo['payee_phone']?>">
							    	</div>
							  	</div>
							  	<div class="form-group">
							        <label class="col-sm-2 control-label"><em>*</em>&nbsp;&nbsp;收款银行：</label>
							    	<div class="col-sm-4">
							    	<input type="text" class="form-control" maxlength="20" name="bank_name" value="<?php  echo $companyInfo['bank_name']?>">
							    </div>
							        
							  	</div>
							  	<div class="form-group">
							  	    <label class="col-sm-2 control-label"><em>*</em>&nbsp;&nbsp;收款银行卡号：</label>
							  	    <div class="col-sm-4">
							  	    <input type="text" class="form-control" maxlength="20" name="bank_card" value="<?php  echo $companyInfo['bank_card']?>">
                                    </div>							  	    
							  	</div>
						</div>
					</div>
					</form>
	<div class="validatesubstancecontent tab-pane" id="view">
	 <div class="validate-table-two col-md-12 col-sm-12 " style="background:#f5f5f5;padding:0;">
		<link rel="stylesheet" href="catalog/view/stylesheet/css/index.css">
        <script type="text/javascript" src="//platform-api.sharethis.com/js/sharethis.js#property=58f9d4de49bbaa00120f493f&product=inline-share-buttons" async="async"></script>
		<header class="fold">
			<p><?php echo $project['name']?></p>
		</header>
		<article class="medail">
			<div class="vdio col-md-8 col-sm-8" id="view_video">
				
			</div>
			<div class="percent col-md-4 col-sm-4">
				<div class="percent-top">
				<!-- 波浪 进度条 -->
					<div class="canvas-div">
						
						<canvas width="250" height="250" id="canvas">对不起，您的浏览器不支持canvas</canvas>
						<p class="ofdollor">of$1000.00</p>
					</div>
					<div class="process" style="display:none">
				        <div class="process-passed" style="display: none; width: 102px;"><span class="process-btn"></span></div>
				        <div class="arrow-box hide" style="display:none">拖我</div>
				    </div>
				    <button class="control" type="button" style="display:none">自动演示</button>
				    <div class="message bounce animated hide" style="display:none">
				        DONE!
				    </div>
					<div class="shade" style="display:none"></div>
				<!-- 波浪 进度条 end-->	
				</div>
				<div class="percent-center">
					<p><span><?php echo $project['backers']?></span>backers</p>
				</div>
				<p class="goalmoney"><span><?php echo $project['current_goal']?></span> goal money</p>
				<!-- 倒计时============================================= -->
				 <div class="percent-bottom col-md-12 col-sm-12">
                <div>
                    <time style="color: #353535;"  datetime="<?php echo $project['date_ended'];?>"></time>
                    <span class="leri">left</span>
                </div><!-- Paris (winter) -->
            </div>
				<div class="back-project">
						<a href="backproject.html"><button class="btn">Back This Project</button></a>
				</div>
			</div>
		</article>
		<article class="presonoal">
			<div class="product col-md-8 col-sm-8">
				<div class="product-all">
					<span class="los-p">
						<i class="fa fa-heart"></i>
						<span>Project we love</span>
					</span>
					<span class="los-p">
						<i class="fa fa-compass"></i>
						<span>Traffic</span>
					</span>
				</div>
			</div>
			<div class="teantheme col-md-4 col-sm-4">
			    <div class="col-md-6 col-sm-6">
			    	<button class="btn huistar"><i class="fa fa-star"></i><span>Remind me</span></button>
			    	<!-- <button class="btn huistarred"><i class="fa fa-star"></i>Saved</button> -->
			    </div>
				<div class="col-md-6 col-sm-6">
					<button class="btn"><i class="fa fa-share"></i> Share</button>
				</div>
			</div>
		</article>
		<article class="campaign">                                                                         
			<div class="scroll-inforlink scroll-inforlink-active">
				<ul class="inforlink">
					<li class=""><button class="btn forlinkactive">Campaign</button></li>
					<li class=""><button class="btn">Updates</button></li>
					<li class=""><button class="btn">Comments</button></li>
					<li class=""><button class="btn">Community</button></li>
					<div class="scroll-project" style="display: none;">
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
							<?php echo $projectDescription['description']?>
						</div>
					</div>
					<div class="rewords col-md-4 col-sm-4">
						<div class="teantheme-lunbo">
							<div class="swiper-container">
						        <div class="swiper-wrapper">
						            <div class="swiper-slide">
						            	<div class="circle-person">
						            		<img src="img/vdio.jpg" alt="">
						            		<div class="chose">
						            			<p>Project sponsor</p>
						            			<p class="chose-name"><?php echo $customer_name?></p>
						            			<p><?php echo $customer_description?></p>
						            		</div>
						            	</div>
						            </div>
						        </div>
						    </div>
						</div>
						<p class="about-p">Reward</p>
						<ul class="pledgeall">
						<?php foreach($rewards as $reward){?>
							<li>
								<p class="ple">Pledge $<?php echo $reward['pledge_amount']?> or more</p>
								<p style="font-size:14px;">
									<span class="backspan">
										<i class="fa fa-male"></i>
										 <?php echo $reward['backers']?> backers
									</span>
									<span class="gone">Limited (<?php echo $reward['stock']?> left of <?php echo $reward['limit_backer']?>)</span>
								</p>
								<p class="ps">****EARLY BACKER REWARD****</p>
								<?php echo $reward['description']?> 
								<p class="ps">
									<span class="ps-span col-md-6 col-sm-6">Estimated delivery: <br> <?php  echo $reward['delivery']?></span>
									<span class="ps-span col-md-6 col-sm-6">Ships to: <br> Anywhere in the world</span>
								</p>
								<div class="everyoneneirong">
									<div class="xuxian"></div>
									<div class="form-group" id="selecttttt">
									    <label for="sel">Shipping destination</label>
										<div class="select_box form-control">
							                <span class="select_txt"></span>
							                <a class="selet_open">
							                	<i class="fa fa-angle-down"></i>
							                </a>
							                <div class="option">
							                    <a>china</a>
							                    <a>2</a>
							                    <a>3</a>
							                </div>
							            </div>
									</div>
									<div class="form-group">
									    <label for="tax">Pledge amount</label>
									    <input type="text" class="form-control" id="tax" placeholder="$54">
									</div>
									<button type="button" class="btn btn-primary btn-lg btn-block">Continue</button>
								</div>
							</li>
							<?php }?>
						</ul>
					</div>
				</div>
			</div>
		</article>
</div>
		</div>			
					<div class="validatesubstancecontent tab-pane" id="status">
					<!--<div class="shenhexiangmu  col-md-push-1 col-md-10 col-sm-12">
					
						
						<div class="pingshen col-md-12 col-sm-12">
						
							<div class="pingshenbuzhou col-md-5 col-sm-5">
								<span class="number-circle pass">1</span>
								<span class="pingshen-zhuangtai">提交项目</span>
								<span class="pingshen-xian"></span>
							</div>
							<div class="pingshenbuzhou col-md-5 col-sm-5">
								<span class="number-circle <?php if($project['status']>=10){echo "pass";}else{echo "wait";}?>">2</span>
								<span class="pingshen-zhuangtai">审核项目</span>
								<span class="pingshen-xian"></span>
							</div>
							<div class="pingshenbuzhou col-md-2 col-sm-2">
								<span class="number-circle <?php if($project['status']==15){echo "pass";}else{echo "wait";}?>" >3</span>
								<span class="pingshen-zhuangtai">发布项目</span>
							</div>
						</div>
						
						<div class="col-sm-12 clearfix sbmit <?php  if($project['status']!=5){echo "hide";}?>">
							<p class="col-sm-12 clearfix decrition">
								<i class="fa fa-smile-o"></i>
								<span>恭喜你项目提交成功！</span>
							</p>
							<p class="col-sm-12 clearfix decrition">
								<span>恭喜你项目提交成功！我们会以最快的速度审核您的项目，并在三至五个工作日内将审核结果发送到您的邮箱。</span>
								<br>
								<span>请您注意查收邮件。您也可以在个人中心里面查看项目进度。</span>
							</p>
							<div class="col-sm-12 clearfix decrition">
								<a href="#"><button class="btn" >确定</button></a>
							</div>
						</div>
						<?php if($project['status']==10){?>
						<div class="col-sm-12 clearfix ">
							<p class="col-sm-12 clearfix decrition">
								<i class="fa fa-smile-o"></i>
								<span>恭喜你项目审核成功！</span>
							</p>
							<div class="col-sm-12 clearfix decrition">
								<ol class="failedyunyin">
									<li></li>
									 <li>您可以在在七天以内自己选择合适的时间将项目发布。</li>
                                     <li>如果您发现项目有问题可以继续编辑，重新提交审核。</li>
                                     <li>发布成功后将不能修改，如果有修改需要请联系我们aliyoyo@aliyoyo.com</li>
                                     <li>发布成功后您可以个人中心里面查看到自己的项目。</li>
								</ol>
							</div>
							<div class="col-sm-12 clearfix decrition">
								<a href="<?php  echo $editUrl;?>"><button class="btn editProject" >返回编辑</button></a>
							</div>
						</div>
						<?php }?>
						<?php if($project['status']==12){?>
						<div class="col-sm-12 clearfix ">
							<p class="col-sm-12 clearfix decrition">
								<i class="fa fa-frown-o"></i>
								<span>抱歉项目审核失败！</span>
							</p>
							<div class="col-sm-12 clearfix decrition">
								<span class="thefail">失败原因：</span>
								<ol class="failedyunyin">
									<li>企业认证，法人身份证，未按规定上传。</li>
									<li>在产品详情，视频上传错误，不是该产品视频。</li>
									<li>太丑太丑太丑</li>
								</ol>
							</div>
							<div class="col-sm-12 clearfix decrition">
								<a href="<?php  echo $editUrl;?>"><button class="btn editProject" >返回编辑</button></a>
							</div>
						</div>
						<?php }?>
						<?php if($project['status']==15){?>
						<div class="col-sm-12 clearfix ">
							<p class="col-sm-12 clearfix decrition">
								<i class="fa fa-smile-o"></i>
								<span>恭喜你项目发布成功！</span>
							</p>
							<p class="col-sm-12 clearfix decrition">
								<span>你可以在首页和个人中心中看到你的项目，感谢你对阿里优优的支持。<br>
								如果产品内容有必须修改的地方，请联系我们aliyoyo@aliyoyo.com</span>
								<br>
								<span>祝您众筹成功！</span>
							</p>
							<div class="col-sm-12 clearfix decrition">
								<a href="#"><button class="btn" href="#">确定</button></a>
							</div>
						</div>
						<?php }?>
					</div>
					</div>-->
					<div class="validate-table-two col-md-12 col-sm-12 " style="background:#f5f5f5;padding:0;">
						<div class="cont_shenhe">
						 <form action="<?php echo $action ?>" method="post" enctype="multipart/form-data" class="shenhe_form">
		                     <input type="hidden" class="tclass" name="funding_id" value="<?php echo $funding_id ?>">
							 <input type="hidden" class="tclass" name="email" value="<?php echo $email ?>">						
							 <?php if(empty($info)){ ?>
							<div class="shenhe_btn">
								<div class="btn" >
									<label class="public" for="bt1">
									<input class="tclass" type="radio" name="status" value="0" id="bt1">Pass
									</label>
								</div>
								<div class="btn">
									<label class="public btn_active" for="bt2" >
									<input type="radio" class="tclass" name="status" value="1" id="bt2" checked="checked">NO pass
									</label>
								</div>
							</div>
							 
								<p>Please fill in the reasons for the refusal</p>
								<textarea class="tclass" name="content" id="" cols="30" rows="10"></textarea>
							<div class="shenhe_btn">
								<div class="btn" >
									<label class="spublic" for="bt3">
									<input class="tclass" type="radio" name="recommend" value="1" id="bt3">Like
									</label>
								</div>
								<div class="btn">
									<label class="spublic btn_active" for="bt4" >
									<input type="radio" class="tclass" name="recommend" value="0" id="bt4" checkbox="checkbox">Ordinary
									</label>
								</div>
							</div>	
								<div class="shenhe_submit">
									<input id="tclass" type="submit" value="Confirm" class="btn">
									<p>	<input class="tclass" type="radio" name="notification" value="1"  > E-mail notification</p>
								   
								</div>							 
							 <?php }else{ foreach($info as $v){ ?>
							<div class="shenhe_btn">
								<div class="btn" >
									<label class="public <?php echo $v['status']==0 ? 'btn_active' : '' ?>" for="bt1">
									<input class="tclass" type="radio" name="status" value="0" id="bt1" <?php echo $v['status']==0 ? 'checked' : '' ?>>Pass
									</label>
								</div>
								<div class="btn">
									<label class="public <?php echo  $v['status']==1 ? 'btn_active' : '' ?>" for="bt2" >
									<input type="radio" class="tclass" name="status" value="1" id="bt2" <?php echo $v['status']==1 ? 'checked' : '' ?>>NO pass
									</label>
								</div>
							</div>
							 
								<p>Please fill in the reasons for the refusal</p>
								<textarea class="tclass" name="content" id="" cols="30" rows="10"><?php echo $v['content'] ?></textarea>
							<div class="shenhe_btn">
								<div class="btn" >
									<label class="spublic <?php echo  $v['recommend']==1 ? 'btn_active' : '' ?>" for="bt3">
									<input class="tclass" type="radio" name="recommend" value="1" id="bt3" <?php echo $v['recommend']==1 ? 'checked' : '' ?>>Like
									</label>
								</div>
								<div class="btn">
									<label class="spublic <?php echo  $v['recommend']==0 ? 'btn_active' : '' ?>" for="bt4" >
									<input type="radio" class="tclass" name="recommend" value="0" id="bt4" <?php echo $v['recommend']==0 ? 'checked' : '' ?>>Ordinary
									</label>
								</div>
							</div>	
								<div class="shenhe_submit">
									<input id="tclass" type="submit" value="Confirm" class="btn">
									<p>	<input class="tclass" type="radio" name="notification" value="1" <?php echo $v['notification']==1 ? 'checked' : '' ?> > E-mail notification</p>
								   
								</div>
					        <?php } } ?> 
							</form>
						</div>
					</div>
				
			</div>
			<div class="modal fade submitmodel" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
						  	<div class="modal-dialog" role="document">
							    <div class="modal-content">
								    <div class="modal-header">
								        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><i class="fa fa-close"  aria-hidden="true"></i></button>
								        <h4 class="modal-title" id="myModalLabel">提交项目</h4>
								    </div>
								    <div class="modal-body">
								        <p style="font-size:16px;">您的项目正在提交，请耐心等待...</p>
								        <div class="progress">
											<div class="progress-bar" style="width:60%; ">
												<!-- <div class="progress-value">60%</div> -->
											</div>
										</div>
								    </div>
							  	</div>
						  	</div>
						</div>
						
			<div class="validate-preserve">
				<!--<div class="container">
					<button class='btn validate-preserve-never' onclick="formReset()">放弃</button>
					<button class="btn validate-preserve-btn form_submit">保存</button>
				</div>-->
			</div>
			
			<div class="modal fade submitmodel fangqi" id="confirm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			  	<div class="modal-dialog" role="document">
				    <div class="modal-content">
					    <div class="modal-header">
					        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><i class="fa fa-close"  aria-hidden="true"></i></button>
					        <h4 class="modal-title" id="myModalLabel">您的修改信息还未保存</h4>
					    </div>
					    <div class="modal-body">
					        <!--<p style="font-size:16px;">请保存修改信息或放弃修改</p>-->
					        
					    </div>
					    <div class="modal-footer">
					    	<!--<button type="button" class="btn btn-primary form_submit">保存</button>
					        <button type="button" class="btn btn-default" data-dismiss="modal" onclick="formReset()">放弃</button>-->					        
					    </div>
				  	</div>
			  	</div>
			</div>
			
			<div class="modal fade submitmodel fangqi" id="stop" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			  	<div class="modal-dialog" role="document">
				    <div class="modal-content">
					    <div class="modal-header">
					        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><i class="fa fa-close"  aria-hidden="true"></i></button>
					        <h4 class="modal-title" id="myModalLabel">提交项目</h4>
					    </div>
					    <div class="modal-body">
					        <p style="font-size:16px;">
					        <i  class="fa fa-exclamation-circle"></i>
							您的项目状态处于审核或已经发布,在此阶段不能对项目进行修改。您可以在状态页面查看审核进度。</p>
					        
					    </div>
					    <div class="modal-footer">
					    </div>
				  	</div>
			  	</div>
			</div>
			
		</div>
	</div>
	</div>

<script src=<?php echo HTTP_Aliyoyo."catalog/view/stylesheet/js/jquery.countdown.js"?>></script>
<!-- <script src="js/script.js"></script> -->
<script src=<?php echo HTTP_Aliyoyo."catalog/view/stylesheet/js/bootstrap.min.js"?>></script>
<script src=<?php echo HTTP_Aliyoyo."catalog/view/stylesheet/js/swiper-3.3.1.min.js"?>></script>
<script src=<?php echo HTTP_Aliyoyo."catalog/view/stylesheet/js/bbb.min.js"?>></script>
<script src=<?php echo HTTP_Aliyoyo."catalog/view/stylesheet/js/bbb.js" ?> id="bbbScript" data="<?php echo $max;?>"></script>
	<script>
    
	/*$(document).on('click','.form_submit',function(){
		if($("#review").children('p').attr('data-status')==0){
				$('.validatesubstancecontent.active form').submit();
			}else{
				$('#stop').modal();
				}
		})*/
	// ================================公司认证 页面 *1* =======================================
	// ======================================公司简介限制字符长度================================
	$("#inputlength").keyup(function(event) {
		var curLength=$("#inputlength").val().length; 
		if(curLength>100){ 
			$(".produace").text('请控制在50字之内哦')
			$(".produace").css('color', 'red');
		} 
		
	});
	// ======================================公司简介限制字符长度 end================================
	
// ================================产品信息类别 select *2* ========================================
	 
	 $(function(){
		 var category_name = '<?php  foreach ($categories as $categorie){
		     if($categorie['category_id']==$project['category_id']){
		         echo  $categorie['name'];
		     }
		 }?>'
       $('.select_txt').text(category_name);
       $('.validate-preserve').hide();
       $("input[name='project_category']").val(<?php  echo $project['category_id'];?>);
         
     })
	/*$(document).ready(function(){
        $(".select_box").click(function(event){   
            event.stopPropagation();
            $(this).find(".option").toggle();
            $(this).parent().siblings().find(".option").hide();
        });
        $(document).click(function(event){
            var eo=$(event.target);
            if($(".select_box").is(":visible") && eo.attr("class")!="option" && !eo.parent(".option").length)
            $('.option').hide();                                      
    });
    /*赋值给文本框*/
    /*$(".option_li a").click(function(){
    	var value=$(this).text();
        $(this).parent().parent().parent().siblings(".select_txt").text(value);
        $("input[name='project_category']").val($(this).attr("value"))
     })
})*/
// ================================产品信息类别 select *2*  end========================================
    $('.validateleftul a').click(function(e) {
    	     e.preventDefault();
             if($(".validate-preserve").is(":hidden")){
            	 
            $(this).addClass('validateleftul-li-hover');
			$(this).parent().siblings('li').children("a").removeClass('validateleftul-li-hover')
            $(this).tab('show');
                 }else{
                   $('#confirm').modal();

                 }

			});
	 	     

	 
	    $(function() {
			if(location.hash=='#project'){
			tableShow('.validateleftul a[href="#project"]');
			}
			
	        if(location.hash=='#reward'){
			tableShow('.validateleftul a[href="#reward"]');
			
			}
	        if(location.hash=='#description'){
				tableShow('.validateleftul a[href="#description"]');
				
				}
	        if(location.hash=='#account'){
	        	tableShow('.validateleftul a[href="#account"]');
				
				}
	        if(location.hash=='#status'){
	        	tableShow('.validateright a[href="#status"]',location.hash);
				
				}
	        if(location.hash=='#view'){
	        	tableShow('.validateright a[href="#view"]',location.hash);
				
				}

	         })
	  function tableShow(obj,hash){
		  	  if(hash=="#status"){
			  	$('.validateleftul a').removeClass('validateleftul-li-hover');
			  	  }else{
				  		$(obj).addClass('validateleftul-li-hover');
						$(obj).parent().siblings('li').children("a").removeClass('validateleftul-li-hover')
				  	  }
	    	
			$(obj).tab('show');
		  	  }
	// ==================================================
	$("body").on("change" ,".form-control", function () {
		//$('.validate-preserve').show();
	});
	// div 模仿的select
	var title = $("b.facility"); 
	var title = $('.select_txt');//the element I want to monitor 
	title.bind('DOMNodeInserted', function(e) { 
		$('.validate-preserve').show();
	}); 
	// date callback
	
	function DateCallBack(){
		$('.validate-preserve').show();
		}

	
	function formReset(){
		$('.form-horizontal')[0].reset();
		$('.validate-preserve').hide();
	}
	// ==============================================================
	$(function(){
		var licenceType =  <?php  echo $companyInfo['licence_type'];?>;
		if(licenceType){
			$('#twoPhotos').click();
			}else{
				$('#fourPhotos').click();
				}
		

		})
	$(".zheng").click(function(event) {
		$(this).children('img').attr("src","image/radio-current.png");
		$(this).siblings().children().attr("src","image/radio-normal.png");	
		$(".zhengjianall").eq($(this).index()).addClass('validate-active').siblings().removeClass('validate-active');
	});
// ==========================奖金设置 页面 *3* ========================================
	var reward_row = <?php echo $reward_row; ?>;
    $(document).delegate('.addprojuct-left', 'click', function(event){
        var aa='<li class="getabonusall"><div class="getabonus-left col-sm-2"><p><em>*</em>&nbsp;&nbsp;奖励<p>&nbsp;&nbsp;0 支持者</p></div><div class="getabonus-right col-sm-10"><div class="form-group biaogeform"><label class="col-sm-3 biaogelable">标题</label><div class="col-sm-9 biaogediv"><input class="form-control biaogeinput" name="reward['+reward_row+'][tile]"></div></div><div class="form-group biaogeform"><label class="col-sm-3  biaogelable">赞助额度</label><div class="col-sm-9 biaogediv"><input  class="form-control biaogeinput" name="reward['+reward_row+'][pledge_amount]" onkeyup="this.value=this.value.replace(/[^\\d\\.]/g,\'\')" onafterpaste="this.value=this.value.replace(/[^\\d\\.]/g,\'\')"></div></div><div class="form-group biaogeform"><label class="col-sm-3  biaogelable biaogelable-three">描述</label><div class="col-sm-9 biaogediv reward_descrition" ><textarea name="reward['+reward_row+'][description]"  rows="4" class="form-control biaogeinput biaogeinput-three" style="background:#fff;" name="reward['+reward_row+'][description]"></textarea></div></div><div class="form-group biaogeform"><label class="col-sm-3  biaogelable">预计交货时间</label><div class="col-sm-9 biaogediv"><select class="form-control biaogeinput col-sm-6 select-year" name="reward['+reward_row+'][estimated_delivery_year]"><option value="">选择年</option><option value="2017">2017</option><option value="2018">2018</option><option value="2019">2019</option><option value="2020">2020</option><option value="2021">2021</option><option value="2022">2022</option></select><select class="form-control biaogeinput col-sm-6 select-year" name="reward['+reward_row+'][estimated_delivery_month]"><option value="">选择月</option><option value="1">1月</option><option value="2">2月</option><option value="3">3月</option><option value="4">4月</option><option value="5">5月</option><option value="6">6月</option><option value="7">7月</option><option value="8">8月</option><option value="9">9月</option><option value="10">10月</option><option value="11">11月</option><option value="12">12月</option></select></div></div><div class="form-group biaogeform"><label for="inputEmail3" class="col-sm-3  biaogelable heightauto">运输事项</label><div class="col-sm-9 biaogediv"><select class="form-control biaogeinput selectchange" name="reward['+reward_row+'][shipping_method]"><option value="">物流选择</option><option value="0">无需物流费用</option><option value="1">指定物流国家</option><option value="2">全球物流</option></select><ul class="shipping-rules"><li class="nnn bbb"><select   class="col-sm-6"><option >世界其他国家</option></select><input type="text" class="col-sm-6"  name="reward['+reward_row+'][shipping_postage]"  onkeyup="this.value=this.value.replace(/[^\\d\\.]/g,\'\')" onafterpaste="this.value=this.value.replace(/[^\\d\\.]/g,\'\')"></li><li class="addguojia" data_sort="'+reward_row+'"><span href=""><i class="fa fa-plus"></i>添加新的国家</span></li></ul></div></div><div class="form-group biaogeform havebottom-line"><label class="col-sm-3 biaogelable xianeshuoming">限额说明</label><div class="col-sm-9 xianzhi"><div class="xiane"><input type="checkbox" class="clickbox" name="reward['+reward_row+'][limit_availability]" value="1">&nbsp;&nbsp;添加限制额度</div><div class="moremoney"><div class="money-div"><input type="checkbox" class="large-input"  name="reward['+reward_row+'][limit_backer_availability]" value="1">&nbsp;&nbsp;份数限制<input type="text" class="little-input" value="" name="reward['+reward_row+'][limit_backer]" onkeyup="this.value=this.value.replace(/\\D/g,\'\')" onafterpaste="this.value=this.value.replace(/\\D/g,\'\')"></div><div class="money-div"><input type="checkbox" class="shijianxian-large-input " name="reward['+reward_row+'][limit_time_availability]" value="1">&nbsp;&nbsp;时间限制<div class="col-sm-4 datarili-div shijianxian"><input type="text" class="form-control shijianxian-input" placeholder="结束"  onClick="laydate({choose:DateCallBack})" name="reward['+reward_row+'][limit_time_begin]"></div><div class="col-sm-4 datarili-div shijianxian"><input type="text" class="form-control shijianxian-input" placeholder="开始"  onClick="laydate({choose:DateCallBack})" name="reward['+reward_row+'][limit_time_begin]"></div></div></div></div></div></div><div class="reward_delete col-sm-12"><i class="fa fa-close"></i>删除</DIV></li>';
       	$("#addprojuct").before(aa);
        		//bindListener();
        		reward_row++;
	 });

	 $(document).delegate('.reward_delete','click',function(event){
		 if($("#review").children('p').attr('data-status')==0){
			 var reward_id = $(this).siblings('input').val();
			 var obj = $(this);
			 $.ajax({
		 	        url : 'index.php?route=project/crowdfund/delete_rewards',
		 	        type : 'POST',
		 	        data : 'reward_id='+reward_id,
			 	    dataType: 'json',
		 	        success:function(data){
		 	        	obj.parent().remove();
			 	        }
			  })
			}else{
				$('#stop').modal();
				}
		
		 })
// =============================tianjia guojia=============================================================
    $(function(){
    	$('.selectchange').each(function(){
   	 if($(this).val()==2){
	    	$(this).parent().find('.shipping-rules').show();
	    	$(this).parent().find('.bbb').show();
	    }
	    else if($(this).val()==1){
	    	$(this).parent().find('.shipping-rules').show();
	    	$(this).parent().find('.bbb').hide();
	     	
	    }
	    else{
	    	$(this).parent().siblings('ul').addClass('shipping-rules');
	    	$(this).parent().find('.bbb').hide();
	    	$(this).parent().find('.shipping-rules').hide();
	    }
    	})
     })
	$(document).delegate('.selectchange', 'change', function(e) {
	    if($(this).val()==2){
	    	$(this).parent().find('.shipping-rules').show();
	    	$(this).parent().find('.bbb').show();
	    }
	    else if($(this).val()==1){
	    	$(this).parent().find('.shipping-rules').show();
	    	$(this).parent().find('.bbb').hide();
	     	
	    }
	    else{
	    	$(this).parent().siblings('ul').addClass('shipping-rules');
	    	$(this).parent().find('.bbb').hide();
	    	$(this).parent().find('.shipping-rules').hide();
	    }
	}); 
	 var tamp = "class='col-sm-6'><option value='0'>选择国家</option><?php  foreach ($countries as $countrie){
	         echo  "<option value='".$countrie['country_id']."'>".$countrie['name']."</option>";
	 }?>"
     $(document).delegate('.addguojia', 'click', function(e) {
		var timestamp = new Date().getTime();
		var data_sort = $(this).attr('data_sort');
		atamp = "<li class='nnn'><select name='reward["+data_sort+"][rewards_shipping_country]["+timestamp+"][country]'"+tamp+" <input type='text' class='col-sm-6' name='reward["+data_sort+"][rewards_shipping_Postage]["+timestamp+"][postage]' ><i class='fa fa-close shanchu' data=''></i></li>"
		$(this).before(atamp);
		
	});

     $(document).delegate('.shanchu','click',function(event){
 		if($("#review").children('p').attr('data-status')==0){
			 var shipping_id = $(this).attr('data');
 			 var obj = $(this);
 			 $.ajax({
 		 	        url : 'index.php?route=project/crowdfund/delete_shipping',
 		 	        type : 'POST',
 		 	        data : 'shipping_id='+shipping_id,
 			 	    dataType: 'json',
 		 	        success:function(data){
 		 	        	obj.parent(".nnn").remove();
 			 	        }
 			  })
		}else{
			$('#stop').modal();
			}
		
		  
		 })
// =============================tianjia guojia end===========================================
	 $(function(){
		 $(".clickbox").each(function(){
			 if($(this).is(":checked")){ 
		        	$(this).parents('.xianzhi').find('.moremoney').show();
		       	}
			  });
		 $(".large-input").each(function(){
			 if($(this).is(":checked")){ 
				 $(this).siblings('.little-input').show();
		       	 $(this).siblings('.little-input').attr("disabled",false);
		       	}
			  });
		 $(".shijianxian-large-input").each(function(){
			 if($(this).is(":checked")){ 
				 $(this).siblings('.shijianxian').show();
		         $(this).siblings('.shijianxian').find('.shijianxian-input').attr("disabled",false);
		       	}
			  });
		 
		 })
	 $(document).delegate('.clickbox', 'change', function(e) {
        if($(this).is(":checked")){ 
        	$(this).parents('.xianzhi').find('.moremoney').show();
       	} else { 
       		$(this).parents('.xianzhi').find('.moremoney').hide();
       	}                        
	});
	 $(document).delegate('.large-input', 'change', function(e) {
        if($(this).is(":checked")){ 
       		$(this).siblings('.little-input').show();
       		$(this).siblings('.little-input').attr("disabled",false);
		} else { 
       		$(this).siblings('.little-input').hide();
       		$(this).siblings('.little-input').attr("disabled",true);
       	 }                        
	});
	 $(document).delegate('.shijianxian-large-input', 'change', function(e) {
        if($(this).is(":checked")){ 
       		$(this).siblings('.shijianxian').show();
       		$(this).siblings('.shijianxian').find('.shijianxian-input').attr("disabled",false);
		} else { 
       		$(this).siblings('.shijianxian').hide();
       		$(this).siblings('.shijianxian').find('.shijianxian-input').attr("disabled",true);
       	 }                        
	});
// =========================================奖金页面 *3*  end======================================

// ====================================产品详情 *4*  页面===========================================
	  $('.biaogeinput-three').attr("disabled","disabled"),
	 $('.biaogeinput-three').summernote({
		
		 toolbar: false,
		 minHeight: 200, 
		 maxHeight: 200, 
		 overflow:overflow = 'hidden', 
		 focus: true,
		 callbacks: {
			 onChange: function(contents, $editable) {
			      $('.validate-preserve').show();
			    },
			    }
		 })
		
    
	$('#editor').summernote({
		// disableDragAndDrop:true
		height: 200,
		focus:false,
		toolbar: [
		          ['style', ['style']],
		          ['para', ['paragraph']],
		          ['table', ['table']],
		          ['insert', ['link', 'picture', 'video']],
		          ['view', ['fullscreen']]
		        ],


	}); 
	
	$('.note-editable').addClass('disabled');
		
// ====================================产品详情 *4*  页面 end======================================

$(function(){
	var videoUrl=$(".youtobe_video").val();
	var ytRegExp = /^(?:https?:\/\/)?(?:www\.)?(?:youtu\.be\/|youtube\.com\/(?:embed\/|v\/|watch\?v=|watch\?.+&v=))((\w|-){11})(?:\S+)?$/;
    var ytMatch = videoUrl.match(ytRegExp);
    if (ytMatch && ytMatch[1].length === 11) {
      var youtubeId = ytMatch[1];
      var videoHtml  = '<iframe width="100%" height="390" src="https://www.youtube.com/embed/'+youtubeId+'" frameborder="0" allowfullscreen></iframe>';
      $('#video_view').html(videoHtml);
      $('#view_video').html(videoHtml);
      
    }
})

$(function() {
		var objUrl;
		var img_html;
		$(".uploading").each(function(index, el) {
			$(this).change(function() {
			/*
			鉴定每个图片大小总和
		 	* */
				var data = new FormData();
				var files = $(this).prop('files');
				var object = $(this);
				for (var i = 0; i < files.length; i++) {
					var file = files[i];

					if (!file.type.match('image.*')) {
						continue;
					}
					data.append('image[]', file);
				}
				if($(this).parent().attr('class')=='large_img_div'){
					data.append('large', 1);
					}
			 	
				var file_size = this.files[0].size;
				if(file_size > 5242880) {
                    alert('上传的图片大小不能超过5M')
					return false;
				}
				 $.ajax({
			            url: 'index.php?route=project/crowdfund/upload',
			            type: 'post',
			            dataType: 'json',
			            data: data,
			            cache: false,
			            contentType: false,  
			            processData: false,
			      		success: function(json) {
				      		object.siblings('i').addClass('removeBtn');
				      		object.siblings('.removeBtn').hide();
				      		object.siblings('.upload_url').val(json.images[0].url);
				      		object.siblings('.uploadimg').attr('src',json.images[0].image_url);
					        }
				 });
				
					
					
					
					
				$(this).parent().parent(".certificate").hover(function() {
					$(this).children().children('.removeBtn').show();
				}, function() {
					$(this).children().children('.removeBtn').hide();
				});
				$(this).siblings('.removeBtn').click(function(event) {
					$(this).siblings('.uploadimg').attr('src', 'image/picture.jpg');
					$(this).removeClass('removeBtn');
				});
				
				return true;
			});
		});
		/*
		 * */
		function getObjectURL(file) {
			var url = null;
			if(window.createObjectURL != undefined) { 
				url = window.createObjectURL(file);
			} else if(window.URL != undefined) { // mozilla(firefox)
				url = window.URL.createObjectURL(file);
			} else if(window.webkitURL != undefined) { // webkit or chrome
				url = window.webkitURL.createObjectURL(file);
			}
			//console.log(url);
			return url;
		}
});
/*
 * */
function removeImg(r){
	$(r).siblings('.uploadimg').attr('src', 'image/picture.jpg');
}

/*
描述：关闭弹出层
 * */
function closeShade(){
	var width=$(".certificate").width();
	$(".shade").fadeOut(500);
	$(".uploadimg").css('border-color', '#ccc');
	$(".shade").css('right', 400+'px');
}


//==============================================================================================================
$(function() {
		var objUrl;
		var img_html;
		$(".little-inputs").each(function(index, el) {
			$(this).change(function() {
			/*
			鉴定每个图片大小总和
		 	* */
				var file_size = this.files[0].size;
				if(file_size > 1048576) {
					$(this).parent().parent().siblings(".shade").fadeIn(500);
					$(this).parent().parent().siblings(".shade").children().children(".text_span").html("<i class='fa fa-exclamation-circle'></i>"+"上传的图片大小不能超过100k");
					$(this).siblings('.uploadimg').css('border-color', 'red');
					return false;
				}
					$(this).siblings('i').addClass('removeBtn');
					$(this).siblings('.removeBtn').hide();
					var filepath = $("input[name='myFile']").val();
			   		 objUrl = getObjectURL(this.files[0]);
					$(this).siblings(".uploadimg").attr("src",objUrl);
				$(this).parent().parent(".certificate").hover(function() {
					$(this).children().children('.removeBtn').show();
				}, function() {
					$(this).children().children('.removeBtn').hide();
				});
				$(this).siblings('.removeBtn').click(function(event) {
					$(this).siblings('.uploadimg').attr('src', 'image/picture.jpg');
					$(this).removeClass('removeBtn');
				});
				
				return true;
			});
		});
		/*
		 * */
		function getObjectURL(file) {
			var url = null;
			if(window.createObjectURL != undefined) { 
				url = window.createObjectURL(file);
			} else if(window.URL != undefined) { // mozilla(firefox)
				url = window.URL.createObjectURL(file);
			} else if(window.webkitURL != undefined) { // webkit or chrome
				url = window.webkitURL.createObjectURL(file);
			}
			//console.log(url);
			return url;
		}
	});
	/*
	 * */
	function removeImg(r){
		$(r).siblings('.uploadimg').attr('src', 'image/picture.jpg');
	}
	
	/*
	描述：关闭弹出层
	 * */
	function closeShadelittle(){
		var width=$(".certificate").width();
		$(".shade").fadeOut(500);
		$(".uploadimg").css('border-color', '#ccc');
		$(".shade").css('right', 40+'px');
	}
	
     $(document).on("change" ,"select[name='province']",function(){
         var code = $(this).val();
    	 $.ajax({
  			url: 'index.php?route=location/location',
  			type: 'post',
  			data: 'code=' + code,
  			dataType: 'json',
  			success: function(json) {	
 				$("select[name='city']").children("option").remove();
  				$("select[name='region']").children("option").remove();
  				$("select[name='city']").append("<option value=''>请选择</option>");
  				$("select[name='region']").append("<option value=''>请选择</option>");
 				 $.each(json, function(index,values){ 
  				$.each(values,function(key,value){ 
    		          $("select[name='city']").append("<option value='"+value.code+"'>"+value.name+"</option>");
    		        });
  				});
      			}
         });
     });
     $(document).on("change" ,"select[name='city']",function(){
         var code = $(this).val();
    	 $.ajax({
  			url: 'index.php?route=location/location',
  			type: 'post',
  			data: 'code=' + code,
  			dataType: 'json',
  			success: function(json) {	
 				 $("select[name='region']").children("option").remove();
  				 $("select[name='region']").append("<option value=''>请选择</option>");
 				 $.each(json, function(index,values){ 
  				$.each(values,function(key,value){ 
    		          $("select[name='region']").append("<option value='"+value.code+"'>"+value.name+"</option>");
    		        });
  				});
      			}
         });
     });
     $(document).on("click",".validaterightone a[href='#view']",function(e){
    	 e.preventDefault();
    	 if($(".validate-preserve").is(":hidden")){
    		  $('.validateleftul a').removeClass('validateleftul-li-hover');
	          $('.validateleftul li').removeClass('active');
	          $(this).tab('show');
        	 }else{
        		 $('#confirm').modal();
            	 }

         })
        $(document).on("click","#review",function(e){
        	e.preventDefault();
	          if($(".validate-preserve").is(":hidden")){
		          $('.validateleftul a').removeClass('validateleftul-li-hover');
		          $('.validateleftul li').removeClass('active');
	        	  var num = 0;
	        	  var status = $(this).children('p').attr('data-status');
	              var funding_id = $(this).children('p').attr('data');

	                  if(num==4&&status==0){
	                  	$.ajax({
	                			url: 'index.php?route=project/crowdfund/review',
	                			type: 'post',
	                			data: 'funding_id=' + funding_id,
	                			dataType: 'json',
	                			beforeSend: function() {
	                				$('#myModal').modal();
	                    			},
	                    		complete:function(){
	                    			$('#myModal').modal('hide');
	                        		},	
	                			success: function(json) {
	                				$("#review").tab('show');
	                				$(".sbmit").removeClass('hide');
	                				$('#review').children('p').attr('data-status','5');
	                				$('#review').children('p').text('状态');
	                    			}
	                  	  })
	                      }else{
	                    	  $("#review").tab('show');
		                      }
	         	 
	              }else{
	                $('#confirm').modal();

	              }
        
            })
      window.jQuery(function ($) {
        $('time').countDown({
            with_separators: false
        });

    }); 
	$(".public").click(function(){
		$(this).addClass("btn_active");
		$(this).parent().siblings().children().removeClass("btn_active");
	})
	
	$(".spublic").click(function(){
		$(this).addClass("btn_active");
		$(this).parent().siblings().children().removeClass("btn_active");
	})
	
	
	
	
	
	
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
	
	<script src="catalog/view/stylesheet/js/bbb.min.js"></script>
<script src="catalog/view/stylesheet/js/bbb.js" id="bbbScript" data="<?php echo $project['percent'];?>"></script>	

<?php echo $footer;?>