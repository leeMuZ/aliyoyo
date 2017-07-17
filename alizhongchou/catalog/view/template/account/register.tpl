<!DOCTYPE html>
<!--[if IE]><![endif]-->
<!--[if IE 8 ]><html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" class="ie8"><![endif]-->
<!--[if IE 9 ]><html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" class="ie9"><![endif]-->
<!--[if (gt IE 9)|!(IE)]><!-->
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>">
<!--<![endif]-->
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title><?php echo $title; ?></title>
<base href="<?php echo $base; ?>" />
<?php if ($description) { ?>
<meta name="description" content="<?php echo $description; ?>" />
<?php } ?>
<?php if ($keywords) { ?>
<meta name="keywords" content= "<?php echo $keywords; ?>" />
<?php } ?>
<link rel="stylesheet" type="text/css" href="catalog/view/javascript/bootstrap/css/bootstrap.min.css">
<link  href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
<script src="catalog/view/javascript/jquery-2.1.1.min.js"></script>
<script src="catalog/view/javascript/bootstrap/js/bootstrap.min.js"></script>
<script src="catalog/view/javascript/particleground.js"></script>
<style>
body{
	font-size:14px;
	background:#f0f0f0;
	font-family:"Montserrat",Helvetica,sans-serif;
	color:#101010;
}
*{
	outline:none;
}
ul,div,p,li,span{
	margin:0;
	padding:0;
}
ul,ol{
	list-style:none;
}
.l{
	float:left;
}
.r{
	float:right;
}
.btn{
	outline:none;
}
.dlym{
	height:700px;
}
.dlym .loginto{
	background:#fff;
	border-radius: 5px;
	-webkit-border-radius:5px;
	-moz-border-radius:5px;
	padding-bottom:35px;
	padding-top:40px;
	margin-top:100px;
	
}
.dlym .loginto .signin{
	padding:0 15px 0 15px;
}


.dlym .loginto .signin .logo img{
	width:100%;
	height:100%;
}
.dlym .loginto .signin ul{
	height: 18px;
    margin-top: 8px;
}
.dlym .loginto .signin ul li{
	width:40%;
	color:#aaa;
	font-size:16px;
	height:18px;
	line-height: 18px;
	text-align:right;
	font-weight:bold;

}
.dlym .loginto .signin ul li a{
	padding:0!important;
	border:none;
	color:#aaa;
	height:18px;
	outline: none;
}
.dlym .loginto .signin ul li a:hover{
	background:#fff;
}
.dlym .loginto .signin ul .first-li{
	 width: 54%;
    margin-right: 5%;
    border-right: 1px solid #ddd;
    text-align: left;
}
.active a{
	color:#26c6da!important;
	outline:none;
}
#formbd {
	padding:15px;
}
#formbd .input-emal{
	margin-bottom:15px;
	height:34px;
	border:1px solid #03a9f4;
	border-radius: 5px;
	-webkit-border-radius:5px;
	-moz-border-radius:5px;
	margin-left:15px;
	margin-right:15px;
}

#formbd .input-emal .nomargin{
	border-radius: 5px;
	-webkit-border-radius:5px;
	-moz-border-radius:5px;
	border:none;
	width:100%;
	height:100%; 
	
}
#formbd .forget{
	margin-top: 10px;
    margin-bottom: 15px;
    padding: 0 15px 0 15px;
}
#formbd .forget a{
	display:inline-block;
	height:20px;
	color:#03a9f4;
}
#formbd .log{
	height:34px;
	margin-top: 10px;
	padding:0 15px 0 15px;
}
#formbd .log .btn{
	height:34px;
	font-weight: bold;
}
#formbd .remenbered{
	margin-top:20px;
	height:20px;
	padding:0 15px 0 15px;

}
#formbd .remenbered span{
	color:#777777;
	margin-left:5px;
}
#formbd .xhx {
	margin-top:10px;
	margin-bottom:20px;
	height:20px;
	text-align:center;
	padding:0 15px 0 15px;
}
#formbd .xhx .xhx1{
	margin-top:11px;zj
	height:1px;
	background:#bbbbbb;
}
#formbd .log .face{
	background:#3b5998;
	font-weight:bold;
	color:#fff;
	padding:0 15px 0 15px;
}
#formbd .log .face i{
	font-size:16px;
	width:30px;
	color:#fff;
}
#formbd .wellcome{
	margin-top:20px;
	padding:0 15px 0 15px;
}
#formbd .wellcome .wedl{
	text-align:center;
	color: #777777;
}
#formbd .wellcome .wedl span{
	color:#26c6da;
}
#formbd .sidego{
	margin-top:20px;
	background:#f7f7f7;
	height:80px;
	-webkit-border-bottom-left-radius: 5px;
	-webkit-border-bottom-right-radius: 5px;
	-moz-border-bottom-left-radius: 5px;
	-moz-border-bottom-right-radius: 5px;
	border-bottom-left-radius: 5px;
	border-bottom-right-radius: 5px;
}
#formbd .sidego .new{
	height:80px;
	line-height:80px;
	text-align:center;
	
}
#formbd .sidego .new a{
	text-decoration:none;
	color:#03a9f4;
	font-weight:bold;
}
#myTablog{
	border:0;
}
</style>
</head>
<body style="background: url('images/backgg.jpg') no-repeat;width:100%;height:100%;">
<div id="particle-js" style="position: absolute;width: 100%;height:100%"></div>
	<div class="container dlym" >
		<div class="row">
			<div class="loginto col-md-offset-4 col-md-4">
				<div class="signin 	row">
					<div class="logo col-md-5">
						<img src="images/logo.png" alt="">
					</div>
					<ul class="col-md-offset-1 col-md-6 nav nav-tabs" id="myTablog">
						<li class="first-li l " name="1"><a href="#up">SIGN UP</a></li>
						<li class="r lichecked active" name="2"><a href="#in" >SIGN IN</a></li>
					</ul>
				</div>
				<div class="tab-content">
					<div class="row signinup tab-pane  active" id="in">
						<form action="" id="formbd" method="POST" accept-charset="UTF-8" role="form">
							<div class="input-emal">
								<input type="text" class="form-control nomargin" placeholder="Email">
							</div>
							<div class="input-emal">
								<input type="password" class="form-control nomargin" placeholder="Password">
							</div>
							<div class="forget">
								<a href="" data-toggle="modal" data-target="#passwordReset">Forgot your password?</a>
							</div>
							<div class="log">
								<button class="btn btn-info col-md-12">SIGN ME IN!</button>
							</div>
							<div class="remenbered">
								<input type="checkbox" class="l">
								<span class="l">Remember me</span>
							</div>
							<div class="xhx">
								<div class="xhx1 col-md-5"></div>
								<span class="col-md-2">or</span>
								<div class="xhx1 col-md-5"></div>
							</div>
							<div class="log">
								<button class="btn  col-md-12 face"><i class="fa fa-facebook"></i>Log in with Facebook</button>
							</div>
							<div class="wellcome">
								<p class="wedl">We'll never post anything on Facebook</p>
								<p class="wedl">without your permission.</p>
							</div>
						</form>
					</div>
					<div class="row signinup  tab-pane" id="up">
						<form action="" id="formbd" method="POST" accept-charset="UTF-8" role="form">
							<div class="input-emal form-group">
								<input type="text" class="form-control nomargin" placeholder="Name">
							</div>
							<div class="input-emal form-group">
								<input type="emal" class="form-control nomargin" placeholder="Email">
							</div>
							<div class="input-emal form-group">
								<input type="password" class="form-control nomargin" placeholder="Password">
							</div>
							<div class="input-emal form-group">
								<input type="password" class="form-control nomargin" placeholder="Re-Enter password">
							</div>
							<div class="log">
								<button class="btn btn-info col-md-12">SIGN UP!</button>
							</div>
							<div class="wellcome">
								<p class="wedl">By signing up, you agree to our <span>terms of use privacy policy</span> and <span>cookies policy</span></p>
							</div>
							<div class="xhx">
								<div class="xhx1 col-md-5"></div>
								<span class="col-md-2">or</span>
								<div class="xhx1 col-md-5"></div>
							</div>
							<div class="log">
								<button class="btn  col-md-12 face"><i class="fa fa-facebook"></i>Log in with Facebook</button>
							</div>
							<div class="wellcome">
								<p class="wedl">We'll never post anything on Facebook</p>
								<p class="wedl">without your permission.</p>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
<div class="modal fade" id="passwordReset" tabindex="15" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span></button>
                    <h5 style="padding-bottom: 20px;" id="myModalLabel">Enter your email address you used to
                        sign up and we'll send you a link to reset your password</h5>
                <h5 style="color: #5bc0de;" id="myModalmsg"></h5>
                    <input type="email" class="form-control" id="email" placeholder="Email" name="email">
                    <div style="padding-top: 10px;">
                        <button type="button" class="btn btn-info" id="submit-forget-password">Continue
                        </button>
                    </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
<script>
$(function () { 
        $('#myTablog a:last').tab('show');//初始化显示哪个tab 
      	$('#myTablog a').click(function (e) { 
          e.preventDefault();//阻止a链接的跳转行为 
          $(this).tab('show');//显示当前选中的链接及关联的content 
          $(this).addClass('active').siblings().removeClass('active');
        });
      });
 function ($) {
         $(document).ready(function () {
             var action = false;
             $('#submit-forget-password').on('click', function () {
                 $('#reset-form').submit();
            });
            $('#reset-form').on('submit', function () {
                 if (action === false) {
                     var $form = $('#reset-form');
					 var $btn = $('#submit-forget-password');
                     $.ajax({
                         url: $form.prop('action'),
                         data: $form.serializeArray(),
                         dataType: 'json',
                         method: 'post',
                         beforeSend: function () {
                             action = true;
                              $btn.attr('disabled', 'disabled');
                         },
                         success: function (resp) {
                             if (resp.status == 'success') {
                                 $btn.attr('disabled', 'disabled');
                                 $("#myModalmsg").html(resp.msg+"<br/><br/>");
                                 setTimeout(function(){  //使用  setTimeout（）方法设定定时2000毫秒
                                     window.location.reload();//页面刷新
                                 },3000);

                             } else {
                                 $("#myModalmsg").html(resp.msg+"<br/><br/>");
                             }
                         },
                         complete: function (data) {
                             $btn.removeAttr('disabled');
                             action = false;
                         }
                     })
                 }
                 return false;
             });
         });
     }(jQuery);
	 
	 particlesJS("particle-js", {
			"particles": {
				"number": {
					"value":43, "density": {
						"enable": true, "value_area": 500
					}
				}
				, "color": {
					"value": "#fff"
				}
				, "shape": {
					"type":"circle", "stroke": {
						"width": 0, "color": "#070707"
					}
					, "polygon": {
						"nb_sides": 4
					}
					, "image": {
						"src": "img/github.svg", "width": 100, "height": 100
					}
				}
				, "opacity": {
					"value":0.5, "random":false, "anim": {
						"enable": false, "speed": 1, "opacity_min": 0.1, "sync": false
					}
				}
				, "size": {
					"value":2, "random":false, "anim": {
						"enable": false, "speed": 40, "size_min": 0.1, "sync": false
					}
				}
				, "line_linked": {
					"enable": true, "distance": 126.26362266116361, "color": "#fff", "opacity": 0.4, "width": 1
				}
				, "move": {
					"enable":true, "speed":3, "direction":"none", "random":true, "straight":false, "out_mode":"out", "bounce":false, "attract": {
						"enable": true, "rotateX": 600, "rotateY": 1200
					}
				}
			}
			, "interactivity": {
				"detect_on":"canvas", "events": {
					"onhover": {
						"enable": true, "mode": "grab"
					}
					, "onclick": {
						"enable": true, "mode": "push"
					}
					, "resize":true
				}
				, "modes": {
					"grab": {
						"distance":133.99274002972194, "line_linked": {
							"opacity": 0.5261837109713353
						}
					}
					, "bubble": {
						"distance": 400, "size": 40, "duration": 2, "opacity": 8, "speed": 3
					}
					, "repulse": {
						"distance": 200, "duration": 0.4
					}
					, "push": {
						"particles_nb": 4
					}
					, "remove": {
						"particles_nb": 2
					}
				}
			}
			, "retina_detect":true
		}
);
</script>