<?php echo $header;?>
<link href="catalog/view/stylesheet/css/payment.css" rel="stylesheet" type="text/css"/>
<div class="warning_w" id="no_this" style="display: none">
    <div class="container">
        Warning:Please enter the correct coupon ID !
        <p> <i class="fa fa-close warn_close" id="this_no"></i></p>
    </div>
</div>
<div class="warning_s" id="ok_this" style="display: none">
    <div class="container">
        Success: Your coupon discount has been applied!
        <p> <i class="fa fa-close warn_close" id="this_ok"></i></p>
    </div>
</div>
<div class="standard-body">
    <div class="full-width">
        <div class="container">
            <div class="col-md-12 center-column payment-page" id="content">
                <form  method="post" enctype="multipart/form-data" id="editCartForm">
                    <div class="table-responsive cart-info cart-overlay col-xs-12">
                        <div class="showloader overlay"></div>
                        <table class="table table-bordered" style="border:0">
                            <thead>
                            <tr>
                                <td class="text-center">Image</td>
                                <td class="text-center hidden-xs">PROJECT NAME</td>
                                <td class="text-center hidden-xs">Model</td>
                                <td class="text-right hidden-xs">Price</td>
                                <td class="text-center">POSTAGE</td>
                                <td class="text-right">Total</td>
                            </tr>
                            </thead>
                            <tbody class="tbody">
                            <tr>
                                <td class="text-center">
                                    <a href="<?php echo $funding_id_links;?>"><img src="<?php echo $pay_message['image'];?>" alt="" title="" class="img-thumbnail"></a>
                                </td>
                                <td class="text-center hidden-xs" style="width: 25%;">
                                    <a href="<?php echo $funding_id_links;?>"><?php echo $pay_message['name'];?></a>
                                </td>
                                <td class="text-center hidden-xs"><?php echo isset($pay_message['rewade_name'])?$pay_message['rewade_name']:"No Modal";?></td>
                                <td class="text-right hidden-xs" id="product_price_1287">$<?php echo $support_price;?></td>
                                <td class="text-right hidden-xs">$<?php echo $input_post;?></td>
                                <td class="text-right">
                                    <strong id="product_total_1287">$<?php echo $total;?></strong>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </form>
                <h2 class="col-sm-12">What would you like to do next?</h2>
                <p class="col-sm-12" style="padding-bottom: 10px">
                    If you have a coupon, please fill in the coupon code.
                </p>
                <div class="panel-group" id="accordion">
                    <div id="collapse-coupon" class="panel-collapse collapse in" style="height: auto;">
                        <div class="panel-body" style="padding-top:0px;">
                            <label class="control-label" for="input-coupon" style="padding-top: 10px;padding-left: 0px;padding-right:20px;font-size: 16px;">Enter your coupon here:</label>
                            <div class="input-group col-sm-8">
                                <!--<input type="text" name="coupon" value="" id="input-coupon" class="form-control col-sm-8">-->
                                <select id="input-coupon" class="form-control" name="coupon">
                                    <option selected="selectd">No discount rolls</option>
                                    <?php
                                     if($my_coupon):
                                    foreach($my_coupon as $k=>$v):
                                    ?>
                                    <option value="<?php echo $v['coupon_code'];?>"><?php echo  "buy $".$v['minbalance']." get $".$v['balance']." yuan off"; ?></option>
                                    <?php
                                    endforeach;
                                    endif;
                                     ?>
                                </select>
                                <!--<span class="input-group-btn col-sm-4">
										<input type="button" value="Apply Coupon" id="button-coupon" data-loading-text="Loading..." class="btn btn-primary" style="margin-top: 5px;">
									</span>-->
                            </div>
                        </div>
                    </div>
                    <?php if(isset($belong_country_id)):?>
                    <div class="panel-collapse collapse in" id="collapse-payment-address" style="height: auto;">
                        <div class="panel-body">
                            <form class="form-horizontal">
                                <p style="margin:0;"><span style="color:#eb0909;">*</span>&nbsp;&nbsp;Please fill in your address</p>
                                <!--tian xieguo dizhide yangshi -->
                                <div class="hidegroup">
                                    <div class="radio" style="padding-top:10px;padding-bottom:10px;">
                                        <label>
                                            <input type="radio" name="payment_address" value="existing" checked="checked">
                                            I want to use an existing address
                                        </label>
                                    </div>
                                    <div id="payment-existing">
                                        <div class="select_box form-control" id="input-payment-country">
                                            <span class="select_txt">Please select</span>
                                            <input type="hidden" class="select_input" id="old_address" value=""/>
                                            <a class="selet_open">
                                                <i class="fa fa-angle-down"></i>
                                            </a>
                                            <div class="option">
                                                <a>Please Select</a>
                                                <?php foreach($addresses as $address):?>
                                                <a data-text="<?php echo $address['address_id'];?>"><?php echo $address['firstname'].' '.$address['lastname'].' '.$address['address_1'].' '.$address['city'].' '.$address['zone_name'].' '.$address['country']; ?></a>
                                                <?php endforeach;?>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="radio" style="padding-top:10px;">
                                        <label>
                                            <input type="radio" name="payment_address" value="new" data-toggle="modal" id="myModaltwo">
                                            I want to use a new address
                                        </label>
                                    </div>
                                </div>
                                <!-- Modal -->
                                <div class="modal fade" id="myModalone" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                                    <div class="modal-dialog" role="document">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                                <h4 class="modal-title" id="myModalLabel">Add a new address</h4>
                                            </div>
                                            <div class="modal-body" id="model_parent_click">
                                                <div id="payment-new" style="display:block;">
                                                    <div class="form-group required">
                                                        <label class="col-sm-3 control-label xing" for="input-payment-firstname">First Name</label>
                                                        <div class="col-sm-9">
                                                            <input type="text" id="firstname" name="firstname" value="" placeholder="First Name"  class="form-control">
                                                        </div>
                                                    </div>
                                                    <div class="form-group required">
                                                        <label class="col-sm-3 control-label xing" for="input-payment-lastname">Last Name</label>
                                                        <div class="col-sm-9">
                                                            <input type="text" id="lastname" name="lastname" value="" placeholder="Last Name"  class="form-control">
                                                        </div>
                                                    </div>
                                                    <div class="form-group required">
                                                        <label class="col-sm-3 control-label xing" for="input-payment-telephone">Telephone</label>
                                                        <div class="col-sm-9">
                                                            <input type="text" id="telephone" name="telephone" value="" placeholder="Telephone"  class="form-control">
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-sm-3 control-label" for="input-payment-company">Company</label>
                                                        <div class="col-sm-9">
                                                            <input type="text" id="company" name="company" value="" placeholder="Company"  class="form-control">
                                                        </div>
                                                    </div>
                                                    <div class="form-group required">
                                                        <label class="col-sm-3 control-label xing" for="input-payment-address-1">Street</label>
                                                        <div class="col-sm-9">
                                                            <input type="text" id="address_1" name="address_1" value="" placeholder="Street 1" class="form-control">
                                                        </div>
                                                    </div>
                                                    <div class="form-group required">
                                                        <label class="col-sm-3 control-label" for="input-payment-address-1"></label>
                                                        <div class="col-sm-9">
                                                            <input type="text" id="custom_field" name="custom_field" value="" placeholder="Street 2"  class="form-control">
                                                        </div>
                                                    </div>
                                                    <div class="form-group required">
                                                        <label class="col-sm-3 control-label xing" for="input-payment-city">City</label>
                                                        <div class="col-sm-9">
                                                            <input type="text" id="city" name="city" value="" placeholder="City"  class="form-control">
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-sm-3 control-label xing" for="input-payment-postcode">Post Code</label>
                                                        <div class="col-sm-9">
                                                            <input type="text" id="post_code" name="postcode" value="" placeholder="Post Code"  class="form-control">
                                                        </div>
                                                    </div>
                                                    <div class="form-group required">
                                                        <label class="col-sm-3 control-label xing" for="input-payment-country">Country</label>
                                                        <div class="col-sm-9 seading" >
                                                            <div class="select_box form-control" id="input-payment-country">
                                                                <span id="country_name" class="select_txt"></span>
                                                                <input type="hidden" id="country_id" name="country_id" class="select_input" value="<?php echo isset($belong_country_id)?$belong_country_id:0;?>"/>
                                                                <a class="selet_open">
                                                                    <i class="fa fa-angle-down"></i>
                                                                </a>
                                                                <div id="countries" class="option">

                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-group required">
                                                        <label class="col-sm-3 control-label xing" for="input-payment-country">Zone</label>
                                                        <div class="col-sm-9 seading" >
                                                            <div class="select_box form-control" id="input-payment-country">
                                                                <span id="zone_name" class="select_txt"></span>
                                                                <input type="hidden" id="zone_id" name="zone_id" class="select_input" value="0"/>
                                                                <a class="selet_open">
                                                                    <i class="fa fa-angle-down"></i>
                                                                </a>
                                                                <div id="zones" class="option">

                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                            </div>
                                            <div class="modal-footer">
                                                <!-- <button type="button" class="btn btn-default" data-dismiss="modal">Close</button> -->
                                                <button type="button" id="save_address" class="btn btn-primary">SAVE</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>
                            <span id="new_address"></span>
                            <input type="hidden" name="the_new_address" value=""/>
                        </div>
                    </div>
                    <?php endif;?>
                    <script type="application/javascript">
                        var countries = <?php echo $countries;?>;
                        $(document).ready(function () {
                            //alert(countries[0].name);
                            var country = '<a>Please Select</a>';
                            var zones = '<a>Please Select</a>';
                            <?php
                            if (isset($belong_country_id))
                            {
                             ?>
                                var country = '<a>Please Select</a>';
                                var zones = '<a>Please Select</a>';
                            var change_country = <?php echo $belong_country_id;?>-1;

                            //for(var n=0;n<countries.length;n++)
                            //{

                                 //country += '<a name="countries" data-text="'+countries[n].country_id+'" onclick="javascript:void(0)">'+countries[n].name +'</a>';
                                 country = '<a name="countries" data-text="'+change_country+'" onclick="javascript:void(0)">'+countries[change_country].name+'</a>';
                                for(var i=0;i<countries[change_country].zone.length;i++)
                                {
                                    //zones += '<a name="zones" data-text="'+countries[n].zone[i].zone_id+'"  onclick="change_value('+countries[n].zone[i].zone_id+')">'+countries[n].zone[i].name+'</a>';
                                    zones += '<a name="zones" data-text="'+countries[change_country].zone[i].zone_id+'"  >'+countries[change_country].zone[i].name+'</a>';
                                }
                                $('#country_id').val(<?php echo $belong_country_id;?>);
                                $('#country_name').html(country);
                                $('#countries').html(country);
                                $('#zones').html(zones);
                                var result = $('#zones').children('a').get(0);
                                var zone   = $($('#zones').children('a').get(0));
                                $('#zone_name').html(result);
                            //}
                            <?php }else { ?>
                                var country = '';
                                $("#country_name").text("Please Select");
                                $("#zone_name").text("Please Select");
                                for(var n=0;n<countries.length;n++)
                                {

                                    country += '<a name="countries" data-text="'+countries[n].country_id+'" onclick="javascript:void(0)">'+countries[n].name +'</a>';
                                }

                                $('#countries').html(country);

                                $('a[name="countries"]').click(function () {
                                    var n = $(this).attr('data-text');//zone
                                    var zones = '';
                                    for(var i=0;i<countries[n].zone.length;i++)
                                    {
                                        zones += '<a name="zones" data-text="'+countries[n].zone[i].zone_id+'" >'+countries[n].zone[i].name+'</a>';
                                    }
                                    $('#zones').html(zones);
                                    $('a[name="zones"]').click(function () {
                                        var value=$(this).text();
                                        var id   =$(this).attr('data-text');
                                        // alert(value);
                                        $(this).parent().siblings(".select_txt").text(value);
                                        $(this).parent().siblings(".select_input").val(id);
                                    })
                                });

                            <?php
                            }
                             ?>


                            /*$('a[name="countries"]').click(function () {
                                var id = $(this).attr('data-text');//zone

                                $('#zones').html(zones);
                            });*/

                            $("#myModaltwo").click(function(){
                                $('#myModalone').modal('show');
                            })
                            /*赋值给文本框*/
                            $(".option a").click(function(){
                                var value=$(this).text();
                                var id   =$(this).attr('data-text');
                                // alert(value);
                                $(this).parent().siblings(".select_txt").text(value);
                                $(this).parent().siblings(".select_input").val(id);
                                // $("#select_value").val(value);
                            });

                            $('#save_address').click(function () {
                                var firstname = $('#firstname').val();
                                var lastname  = $('#lastname').val();
                                var telephone = $('#telephone').val();
                                var company   = $('#company').val();
                                var street    = $('#address_1').val();
                                var city      = $('#city').val();
                                var postcode  = $('#post_code').val();
                                var country_id = $('#country_id').val();
                                var zone_id   = $('#zone_id').val();
                                var custom_field = $('#custom_field').val();

                                var zone_name   = $('#zone_name').text();
                                var country_name= $('#country_name').text();

                                var reg = /^[0-9]+([.]{1}[0-9]+){0,1}$/;
                                var re  = new RegExp(reg);
                                if (firstname=='')
                                {
                                    alert('Please fill in the full data');
                                    $('#firstname').focus();
                                    return;
                                }else if(lastname==''){
                                    alert('Please fill in the full data');
                                    $('#lastname').focus();
                                    return;
                                }else if(telephone=='') {
                                    alert('Please fill in the full data');
                                    $('#telephone').focus();
                                    return;
                                }else if(!re.test(telephone))
                                {
                                    alert("Please enter the correct of telephone");
                                    $('#telephone').focus();
                                    return;
                                }else if(zone_id==0){
                                    var length = document.getElementsByName('zones').length;
                                    if(length != 0)
                                    {
                                        alert("Please fill in the full data");
                                        return;
                                    }
                                }else if(!re.test(postcode)){
                                    alert("Please enter the correct of postcode");
                                    $('#postcode').focus();
                                    return;
                                }

                                //alert(custome_field);
                                $.post('<?php echo $address_post;?>', {'firstname':firstname, 'lastname':lastname, 'telephone':telephone, 'company':company, 'address_1':street, 'custom_field':custom_field, 'city':city, 'postcode':postcode, 'country_id':country_id, 'zone_id':zone_id}, function (data) {
                                    if(data!=0) {
                                        $('#myModalone').modal('hide');
                                        //$('.modal-backdrop').remove();
                                        $('#address_id').val(data);
                                        var new_address = $('#new_address').html();
                                        if(new_address == '')
                                        {
                                         $('#new_address').html('<input name="my_new_addrsess" type="radio" value="' + data + '" checked="checked"/>' + firstname + ' ' + lastname + ' telephone:' + telephone + ' country:' + country_name + ' zone:' + zone_name + ' address:' + street + ' custom field:' + custom_field + ' postcode:' + postcode);
                                        } else {
                                         $('#new_address').html(new_address + '<br/><input name="my_new_addrsess" type="radio" value="' + data + '" checked="checked"/>' + firstname + ' ' + lastname + ' telephone:' + telephone + ' country:' + country_name + ' zone:' + zone_name + ' address:' + street + ' custom field:' + custom_field + ' postcode:' + postcode)
                                        }
                                    }
                                });
                            });
                        });
                    </script>
                    <div class="panel-collapse " id="collapse-payment-method">
                        <div class="panel-body tenmargin">
                            <p><span style="color:#eb0909;">*</span>&nbsp;&nbsp;Please choose a payment method</p>
                            <div class="radio">
                                <label>
                                    <input type="radio" name="payment_method" value="1" checked="checked">
                                    PayPal

                                </label>
                            </div>
                            <div class="radio">
                                <label>
                                    <input type="radio" name="payment_method" value="3">
                                    Credit Card Payment <br>
                                    <img src="image/visa_mast.jpg" alt="Credit Card" data-pin-nopin="true">
                                </label>
                            </div>

                        </div>
                    </div>
                </div>
                <div class="cart-total">
                    <table style="float: right">
                        <tbody>
                        <tr>
                            <td class="text-right Sub-Total">Sub-Total:</td>
                            <td class="text-right Sub-Total" id='subTotal'>$<?php echo $total;?></td>
                        </tr>
                        <tr>
                            <td class="text-right Total">Total:</td>
                            <td class="text-right Total" id="you_total_price">$<?php echo $total;?></td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <!-- <div class="pull-left btn">
                        <a href="">Continue Shopping</a>
                    </div> -->
                    <div class="right" style="float: right;">
                        <a class="button proceed" id="button_submit" >Proceed to Checkout</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<form action="<?php echo $deal_link?>" method="post" id="my_order_form">
    <input type="hidden" id="address_id" name="address_id" class="address_input" value=""/>
    <input type="hidden" name="payment" id="payment_method" value=""/>
    <input type="hidden" id="coupon" name="coupon_input" value=""/>
</form>
    <script>
    $(document).on('click','.warn_close',function(event) {
        $(this).parent().parent().parent().hide();
    });

           /* $(document).on('click','#button-coupon',function(event) {
                var coupon = $('#input-coupon').val();
                var total = <?php echo $total;?>;
                	$.ajax({
              			url: 'index.php?route=total/coupon/coupon',
              			type: 'post',
              			data: 'coupon=' + coupon,
              			dataType: 'json',
              			success: function(json) {	
                  			if(json.error){
                      			$('.partten').after('<div class="warning_w"><div class="container">Warning: '+json.error+'<p> <i class="fa fa-close warn_close"></i></p></div></div>');
                      			$('.coupon').remove();
                      			$('#subTotal').text('$'+(parseFloat(total)));
                      			}else{
                          		 $('.warning_w').remove();
                          		 $('.coupon').remove();
                      		     $('.partten').after('<div class="warning_s"><div class="container">Success: Your coupon discount has been applied! <p> <i class="fa fa-close warn_close"></i></p></div></div>');
                        		 close_notice();
                        		 $('#subTotal').text('$'+(parseFloat(total-json.coupon.balance)));
                        		 $('.cart-total tbody').append('<tr class="coupon"><td class="text-right Total ">Coupon:</td><td class="text-right Total">$'+parseFloat(json.coupon.balance)+'</td></tr>');
                      			}
                  			
                  			}
          			})

            });*/

            $(document).on('change','#input-coupon',function (event) {
                var coupon = $(this).val();
                var total = <?php echo $total;?>;
                $.ajax({
                    url: 'index.php?route=total/coupon/coupon',
                    type: 'post',
                    data: 'coupon=' + coupon,
                    dataType: 'json',
                    success: function(json) {
                            $('#subTotal').text('$'+(parseFloat(total-json.coupon.balance)));
                            $('.cart-total tbody').append('<tr class="coupon"><td class="text-right Total ">Coupon:</td><td class="text-right Total">$'+parseFloat(json.coupon.balance)+'</td></tr>');
                    }
                })
            });
            function close_notice(){
             	 $('.warning_s').show ().delay (3000).fadeOut ();
                }

            function remove() {
                $('#subTotal').html('$'+(<?php echo $total;?>));
                $('#you_total_price').html('$'+(<?php echo $total;?>));
                
            } 

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
            $("#button_submit").click(function () {
                var coupon  = $('select[name="coupon"]').val();
                var check   = $('input[name="coupon_input"]').val();

                if(check !=='error')
                {
                    $('input[name="coupon_input"]').val(coupon);
                }else {
                    $('input[name="coupon_input"]').val(" ");
                }

                var address = $("input[name='payment_address']:checked").val();
                 if(address == 'existing')
                  {
                         var id = $('#old_address').val();
                         $('.address_input').val(id);
                  }
                 var address_1 = $('#address_id').val();

                <?php if(isset($belong_country_id)):?>
                  if (address_1 == '')
                  {
                   alert('Please select or write your address');
                   return;
                  }
                <?php endif ?>
                 var payment = $("input[name='payment_method']:checked").val();
                 $('#payment_method').val(payment);
                $('#my_order_form').submit();
            });
            $("#button_paypal").click(function () {
                var coupon  = $('select[name="coupon"]').val();
                var check   = $('input[name="coupon_input"]').val();

                if(check !=='error')
                {
                    $('input[name="coupon_input"]').val(coupon);
                }else {
                    $('input[name="coupon_input"]').val(" ");
                }

                var address = $("input[name='payment_address']:checked").val();
                if(address == 'existing')
                {
                    var id = $('#old_address').val();
                    $('.address_input').val(id);
                }
                var address_1 = $('#address_id').val();

                if (address_1 == '')
                {
                    alert('Please select or write your address');
                    return;
                }
                /*  else
                 {

                 var id = $('input[name="my_new_addrsess"]:checked').val();
                 $('.address_input').val(id);
                 }*/

                var payment = $("input[name='payment_method']:checked").val();
                $('#payment_method').val(payment);
                $('#my_order_form').submit();
            });
    </script>

<?php echo $footer;?>