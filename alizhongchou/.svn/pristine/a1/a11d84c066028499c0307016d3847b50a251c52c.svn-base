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
<script src="catalog/view/javascript/jquery/jquery-2.1.1.min.js" type="text/javascript"></script>
<link href="catalog/view/javascript/bootstrap/css/bootstrap.css" rel="stylesheet" media="screen" />
<script src="catalog/view/javascript/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<link href="catalog/view/javascript/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
<link href="catalog/view/stylesheet/index.css" rel="stylesheet">
<link rel="stylesheet" href="catalog/view/stylesheet/css/swiper-3.3.1.min.css">


<?php foreach ($styles as $style) { ?>
<link href="<?php echo $style['href']; ?>" type="text/css" rel="<?php echo $style['rel']; ?>" media="<?php echo $style['media']; ?>" />
<?php } ?>
<script src="catalog/view/javascript/common.js" type="text/javascript"></script>
<?php foreach ($links as $link) { ?>
<link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
<?php } ?>
<?php foreach ($scripts as $script) { ?>
<script src="<?php echo $script; ?>" type="text/javascript"></script>
<?php } ?>
</head>

<body>
	<div class="standard-body">
		<div class="full-width">
			<div class="partten">
				<div class="container">
					<img src="catalog/view/img/ALIYOYO2.png" alt="" class="parttenimg">
					<ul class="parttenulone" >
						<li class="mouseoverli">
							<a href="" class="parttenulone-a">
								<span>Explore</span>
								<i class="fa fa-angle-down"></i>
							</a>
							<div class="yincangfenlei" style="display:none;">
								<ul>
									<?php
									$length = count($category);
									$n = $length/12;
                                     for ($i=1;$i<$n;$i++):
                                     ?>
                                     <li>
									<?php
                                         for($x=(($i-1)*12);$x<($i*12);$x++):
                                    ?>

										<a href="<?php echo $category[$x]['category_link'];?>"><?php echo $category[$x]['name'];?></a>

									<?php
									 endfor;
									 ?>

									 </li>

									<?php
									     endfor;
                                    ?>
								</ul>
							</div>
						</li>
						<li>
							<a href="<?php  echo $createProject;?>" class="parttenulone-a">
								<span>Create</span>
							</a>
						</li>
						<li>
							<a href="<?php  echo $aboutUs;?>" class="parttenulone-a">
								<span>About us</span>
							</a>
						</li>
						<li>
							<a href="//www.aliyoyo.com" class="parttenulone-a">
								<span>Shop</span>
							</a>
						</li>
					</ul>
					
					<ul class="parttenultwo">
						<li class="input-li">
							<input type="text" class="inputsearch-input">
								<i class="fa fa-search parttenultwo-span"></i>
						</li>
						<?php if ($is_login) { ?>
						<li class="zhuangtai">
							<span><?php echo $cutomer_name;?><i class="fa fa-angle-down"></i></span>
							<div class="yincangzhuangtai">
								<ul>
								<?php foreach ($projects as $project){?>
									<li>
										<a href="<?php echo $project['url'];?>">
										<img src='<?php  echo $project['image'];?>' alt="" class="img">
										<?php echo $project['name'];?>
										</a>
									</li>
									<?php }?>
									<li>
										<i class="img fa fa-user"></i>
										<a href="<?php echo $homePage ?>">My Homepage</a>
									</li>
									<li>
										<i class="img fa fa-gear"></i>
										<a href="<?php echo $edit ?>">Account Setting</a>
									</li>
									<li>
										<i class="img fa fa-step-backward"></i>
										<a href="<?php  echo $logout?>">Log Out</a>
									</li>
								</ul>
							</div>
						</li>
						<?php }else{?>
						<li>
							<a href="<?php echo $login;?>">
								<button class="btn">Sign in</button>
							</a>
						</li>
						<li>
							<a href="<?php echo $register;?>">
								<button class="btn">Sign up</button>
							</a>
						</li>
						<?php }?>
					</ul>
				</div>
				<div class="anotherinput col-sm-12">
					<div class="anotherinput-div col-sm-10">
						<input type="text">
					</div>
					<div class="anotherinput-go col-sm-2">
						<button class="btn">Go</button>
					</div>

				</div>
</div>
<script >
if($(window).width()<1100){
	$(".inputsearch-input").hide();
	var number=1
	$(document).on("click",".parttenultwo-span",function(){
		if(number){
			$('.anotherinput').show();
			$('.anotherinput input').focus();
			number=0;
		}else{
			$('.anotherinput').hide();
			number=1;
		}
		// return;
	});
}
</script>
