<!DOCTYPE html>
<!--[if IE]><![endif]-->
<!--[if IE 8 ]><html dir="ltr" lang="en" class="ie8"><![endif]-->
<!--[if IE 9 ]><html dir="ltr" lang="en" class="ie9"><![endif]-->
<!--[if (gt IE 9)|!(IE)]><!-->
<html dir="ltr" class="ltr" lang="en">
<!--<![endif]-->
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Your Store</title>
        
       <meta name="description" content="My Store" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <link href="catalog/view/stylesheet/css/css/stylesheet.css" rel="stylesheet" />
        <link href="catalog/view/stylesheet/css/css/paneltool.css" rel="stylesheet" />
        <link rel="stylesheet" href="catalog/view/stylesheet/css/css/font-awesome/css/font-awesome.min.css">
        <link href="catalog/view/stylesheet/css/css/colorpicker.css" rel="stylesheet" />
        <link href="catalog/view/stylesheet/css/css/material-design-iconic-font.min.css" rel="stylesheet" />
        <link href="catalog/view/stylesheet/css/css/magnific-popup.css" rel="stylesheet" />
        <link href="catalog/view/stylesheet/css/css/owl.carousel.css" rel="stylesheet" />
        <link href="catalog/view/stylesheet/css/css/homebuilder.css" rel="stylesheet" />
        <link href="catalog/view/stylesheet/css/css/typo.css" rel="stylesheet" />
        <link href="catalog/view/stylesheet/css/css/pavtestimonial.css" rel="stylesheet" />
        <link href="catalog/view/stylesheet/css/css/pavnewsletter.css" rel="stylesheet" />
        <link href='catalog/view/stylesheet/css/css/a90862042f59429db330f84279c50a43.css' rel='stylesheet' type='text/css'>
        <link href='catalog/view/stylesheet/css/css/672c3ea916fe42cc81b3693ca58cc27a.css' rel='stylesheet' type='text/css'>
        <link rel="stylesheet" href="iconfonts/iconfont.css">
        <link rel="stylesheet" href="catalog/view/stylesheet/css/css/add.css">
        <link rel="stylesheet" href="catalog/view/stylesheet/css/css/storehome.css">
        <script type="text/javascript" src="catalog/view/javascript/js/js/jquery-2.1.1.min.js"></script>
        <script type="text/javascript" src="catalog/view/javascript/js/js/jquery.magnific-popup.min.js"></script>
        <script type="text/javascript" src="catalog/view/javascript/js/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="catalog/view/javascript/js/js/common.js"></script>
        <script type="text/javascript" src="catalog/view/javascript/js/js/common_1.js"></script>
        <script type="text/javascript" src="catalog/view/javascript/js/js/owl.carousel.min.js"></script>
        <script type="text/javascript" src="catalog/view/javascript/js/js/countdown.js"></script>
        <script type="text/javascript" src="catalog/view/javascript/js/js/colorpicker.js"></script>
        <script type="text/javascript" src="catalog/view/javascript/js/js/jquery.Spinner.js"></script>
</head>

<body class="common-home layout-fullwidth batch-goods" >
  <div class="row-offcanvas row-offcanvas-left">
    <div id="page">
      <div class="maincols"> 
        <div class="main-columns container-full">
          <div class="row">
            <div id="sidebar-main" class="col-md-12">
              <div id="content" class="space-padding-0">
                <div id="pav-homebuilder1711483234" class="homebuilder clearfix home2">
                  <div class="pav-container slideshow ">
                    <div class="pav-inner container">
                      <div class="row row-level-1 ">
                        <div class="row-inner clearfix">
                          <div id="header" >
                            <div class="vcard-canopy">
                               <img src="images/u254.jpg" id="uploadbackgroud">
                              <div class="mengban col-lg-12 col-md-12 col-xs-12 col-sm-12 "></div>
                            </div>
                            <div class="dingwei col-md-12 col-xs-12 col-sm-12 col-lg-12">
                              <form action="" id="userHomeForm">
                                <span class="plus r">
                                  <i class="fa fa-plus-circle plus_check">
                                    <input type="file" accept="image/png,image/gif,image/jpeg," title="" name="file" class="fileto" id="userHomeImgUploaded">
                                  </i>
                                  <div class="popr" style="display:none">
                                    <p class="load-p">
                                      <span style="line-height:35px;color:#fff">Upload Cover Image</span>
                                    </p>
                                  </div>
                                </span>
                              </form>
                            </div>
                            <div class="vcard col-md-12  col-xs-12">
                              <div class="header-img col-md-12 col-xs-12">
								<form  method="post" enctype="multipart/form-data" class="col-lg-12" id='new-match' style="padding:0px">	
									<div class="shangchuan" >
										<img src="<?php echo $photo ?>" alt="" class="member_img">						
										<div class="upload" >
												<input  type="file" class="input-files" id="reviewImageUpload"  accept="image/gif, image/jpeg, image/png, image/jpg" title="Upload Profile Photo" style="width:100%;height:100%" />
											<i class="fa fa-cloud-upload" ></i>
										</div>						  

										<div class="wait-mengban"></div>
									</div>
								</form>
                              </div>
                              <div class="card-word col-md-12 col-xs-12">
                                <?php echo $customer_info['nickname'] ?>
                              </div>
                              <div class="card-yoyo col-md-12 col-xs-12">
                                Designed by <a href=" ">Paseidon</a>
                              </div>
                              <div class="card-there col-md-offset-3 col-md-6 ">
                                <span>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean euismod bibendum laoreet. Proin gravida dolor sit amet lacus accumsan et viverra justo commodo.</span>
                              </div>
                              <div class="edit clearfix">
                                <a href="http://www.aliyoyo.com/account/edit">
                                  <div class="account">
                                    Edit Account 
                                  </div>
                                </a>
                              </div>
                            </div>
                          </div>

                          <div class="store-content">
                            <ul class="clearfix navbar-nav" role="tablist" id="storehome-ul">
                             <?php foreach($category as $v){ ?>
							  <li  class="active">
                                <a href="<?php echo $curl."&category_id=".$v[1]."&sort_by=".$sort_by."&show=".$show ?>" >
                                  <span class="little-disc"></span><?php echo $v[0] ?> (<span><?php echo $v[2] ?></span>)      
                                </a>
                              </li>
                             <?php } ?>
							</ul>
                            <div class="tab-content clearfix ">
                              <div class="choosesort clearfix">
                                <div class="sort-by aa">
                                  <span>Sort By:</span>
                                  <div class="select_box">
                                    <span class="select_txt"></span>
                                    <a class="selet_open">
                                      <i class="fa fa-angle-down"></i>
                                    </a>
                                    <div class="option">
									  <a href="<?php echo $curl."&category_id=".$category_id."&sort_by=&show=".$show ?>">--</a>
                                      <a href="<?php echo $curl."&category_id=".$category_id."&sort_by=desc&show=".$show ?>">price 倒叙</a>
                                      <a>2</a>
                                      <a>3</a>
                                    </div>
                                  </div>
                                </div>
                                <div class="sort-show aa">
                                  <span>Show:</span>
                                  <div class="select_box">
                                    <span class="select_txt"></span>
                                    <a class="selet_open">
                                      <i class="fa fa-angle-down"></i>
                                    </a>
                                    <div class="option">
                                      <a href="<?php echo $curl."&category_id=".$category_id."&sort_by=".$sort_by."&show=1" ?>">12</a>
                                      <a href="<?php echo $curl."&category_id=".$category_id."&sort_by=".$sort_by."&show=2" ?>">24</a>
                                      <a href="<?php echo $curl."&category_id=".$category_id."&sort_by=".$sort_by."&show=3" ?>">36</a>
                                    </div>
                                  </div>
                                </div>
                              </div>
                              <!-- select 框 -->
                              <script>
                                  $(document).ready(function(){
                                      $(".select_box").click(function(event){   
                                          event.stopPropagation();
                                           $(this).find(".option").toggle();
                                          // $(this).addClass('select_box-active')
                                          // (this).parent().siblings().find(".select_box").removeClass('select_box-active')
                                          $(this).parent().siblings().find(".option").hide();
                                          $(this).addClass('select_box-active');
                                          (this).parent('.aa').siblings('.aa').children(".select_box").removeClass('select_box-active');
                                      });
                                      $(document).click(function(event){
                                          var eo=$(event.target);
                                          if($(".select_box").is(":visible") && eo.attr("class")!="option" && !eo.parent(".option").length)
                                          $('.option').hide();                                      
                                      });
                                      /*赋值给文本框*/
                                      $(".option a").click(function(){
                                          var value=$(this).text();
                                          $(this).parent().siblings(".select_txt").text(value);
                                          $("#select_value").val(value)
                                       })
                                  })

                              </script>
                              <div role="tabpanel" class="tab-pane fade in active" id="Display">
                                <div>
                                  <div class="mabylove clearfix">
								    <?php foreach($result as $v){ ?>
                                     <div class="product-block clearfix">
                                      <div class="" style="height:250px;">
                                        <div class="product-img img">
                                          <a class="img" title="Flora Blouse in Rose" href="www.baidu.com">
                                            <img src="http://127.0.0.1/image/cache/catalog/customer_avatar//14993984603262-100x100.jpg" alt="" class="img-responsive">
                                          </a>       
                                        </div>        
                                        <div class="bottom">
                                          <div class="action">  
                                            <div class="cart">            
                                              <button data-loading-text="Loading..." class="btn btn-sm btn-outline-light " type="button" data-placement="top" title="Add to Cart" onclick="cart.add('50');">
                                                <i class="zmdi zmdi-mall"></i>
                                              </button>
                                            </div>
                                            <div class="wishlist">
                                              <button class="btn btn-sm btn-outline-light " type="button" data-toggle="tooltip" data-placement="top" title="" onclick="wishlist.add('50');" data-original-title="Add to Wish List"><i class="zmdi zmdi-favorite-outline zmdi-hc-fw"></i></button> 
                                            </div> 
                                          </div>
                                        </div>  
                                      </div>
                                      <div class="" style="height:110px;padding-top: 35px;background:#f9f9f9">        
                                        <div class="name-price">
                                          <h6 class="name">
                                            <a href=""><?php echo $v['name'] ?></a>
                                          </h6> 
                                          <div class="price">
                                            <span class="price-new">$<?php echo $v['price'] ?></span>
                                          </div>
                                        </div>                
                                      </div>  
                                    </div>
								   <?php } ?>
                                  </div>								   
								    <div class="pagination-results col-lg-12 no-margin">
										<div class="col-sm-6 col-xs-12 text-left" style="text-align:center">
                                           <?php echo $pagination; ?>
                                        </div>
									</div>                                  
								</div>
                              </div>

                            </div>
  <script>
    $('#Crowdfunding-all a:first').tab('show') 
    $('#Crowdfunding-all a').click(function (e) {
        e.preventDefault()

        $(this).tab('show')
      })
    // =================================================
    $('#profile-table a:first').tab('show') 
    $('#profile-table a').click(function (e) {
        e.preventDefault()

        $(this).tab('show')
      })

	  //头像上传
	  $(".photo").on('click',function(){
		$("input[type='file']").click();
	 })  
	  	//uoload img
	$('.input-files').change(function (e) {
		if (getObjectURL(this.files[0])) {
			if(typeof(data) == 'undefine'){
				var data = new FormData($("#new-match")[0]);
			}
			var data = new FormData($("#new-match")[0]);
			var files = $("#reviewImageUpload").prop('files');
			for(var i = 0 ;i<files.length;i++){
				var file = files[i];
				if (!file.type.match('image.*')) {
					continue;
				}
				data.append('image[]', file);
			}
			$.ajax({
				url: "index.php?route=account/edit",
				type: 'post',
				data: data,
				dataType:'json',
				cache: false,
				contentType: false,
				processData: false,
				beforeSend: function() {
				
				},
				success: function(data) {
				 $('.photo').button('reset');
					if(data.code == 1){
						$('#file_error').hide();
						$('.member_img').attr('src', data.data);
					}else if(data.code == 0){
                        alert(data.data);
					}else if(data.code == 2){
						location.href=data.data;
					}

				},
				complete :function(){ $('.photo').removeAttr('disabled')}
			});
		}
		function getObjectURL(file) {
			var url = null;
			if (window.createObjectURL != undefined) { // basic
				url = window.createObjectURL(file);
			} else if (window.URL != undefined) { // mozilla(firefox)
				url = window.URL.createObjectURL(file);
			} else if (window.webkitURL != undefined) { // webkit or chrome
				url = window.webkitURL.createObjectURL(file);
			}
			return url;
		}

	})
	  
    </script>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</body>
</html>
