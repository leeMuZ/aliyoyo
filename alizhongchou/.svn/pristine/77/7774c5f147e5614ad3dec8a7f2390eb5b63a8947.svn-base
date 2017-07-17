<?php
   if(isset($success)){ ?>
   <div class="alert alert-success success"><button type="button" class="close" data-dismiss="alert">&times;</button><?php echo $success?></div>
   
   <script>
     $(':input','#pwdform')
             .not(':button, :submit, :reset, :hidden')
             .val('')
             .removeAttr('checked')
             .removeAttr('selected');
   </script>
   <?php }?>
   <form action="<?php echo $action; ?>" method="post" name="resetpwd" onsubmit="return editPwd()" id="pwdform" class="clearfix newpersonal-forem form-horizontal">	  <div class="form-group">
		<label for="inputEmail3" class="col-sm-3 control-label label-before">Current Password:</label>
		<div class="col-sm-9">
		  <input type="password" name="current" class="form-control" id="inputEmail3" value="<?php echo isset($current) ? $current : ' ' ; ?>" placeholder="Current Password">
		   <?php if (!empty($error_current)) { ?>
			   <div class="text-danger"><?php echo $error_current; ?></div>
		   <?php } ?>                
		</div>
	  </div>
	  <div class="form-group">
		<label for="inputEmail3" class="col-sm-3 control-label label-before">New Password: </label>
		<div class="col-sm-9">
		  <input type="password" name="password" value="<?php echo isset($password) ? $password : '' ; ?>" class="form-control" id="inputEmail3" placeholder="New Password">
		  <?php if (!empty($error_password)) { ?>
			<div class="text-danger"><?php echo $error_password; ?></div>
		  <?php } ?>                          
		</div>
	  </div>
	  <div class="form-group">
		<label for="inputEmail3" class="col-sm-3 control-label label-before">Password Confirm:</label>
		<div class="col-sm-9">
		  <input type="password" name="confirm" value="<?php echo isset($confirm) ? $confirm : ''; ?>" class="form-control" id="inputEmail3" placeholder="Password Confirm">
		 <?php if (!empty($error_confirm)) { ?>
		   <div class="text-danger"><?php echo $error_confirm; ?></div>
		  <?php } ?>         
		</div>
	  </div>
	  <div class="form-group">
		<div class=" col-sm-12">
		  <button type="submit" class="btn submit-address">SAVE</button>
		</div>
	  </div>
	</form>
