$(function () {
    $('#acontant_ul a:first').tab('show')
  
	$('#acontant_ul a').click(function (e) {
  		e.preventDefault()
  		$(this).tab('show');
		if($(this).hasClass("acontantactive") ){
			switch ($(this).attr('href')){
				case "#acontant-tabthree":
					addrAjax( 'account/address','#acontant_ul a','#acontant-tabthree');
					break;
				case "#acontant-tabfour":
					addrAjax( 'account/order','#acontant_ul a','#acontant-tabfour');
					break;
				case "#acontant-tabfive":
					addrAjax( 'account/reward','#acontant_ul a','#acontant-tabfive');
					break;
				case "#acontant-tabsix":
					addrAjax( 'account/return','#acontant_ul a','#acontant-tabsix');
					break;
			}
		}
		$(this).addClass('acontantactive').parent().siblings().children().removeClass('acontantactive');
});
	var hash = window.location.hash;
	if(hash){
		switch(hash){
			case "#password":
				$('#acontant-tabtwo').load('account/password');
				$("[href='#acontant-tabtwo'] ").click();
				break;
			case "#Buyers":
				$('#Buyers').load('account/password');
				$("[href='#Buyers'] ").click();
				break;
			case "#shipping":
				$('#shipping').load('account/adress');
				$("[href='#shipping'] ").click();
				break;
			case "#address":
				$('#acontant-tabthree').load('account/address');
				$("[href='#acontant-tabthree'] ").click();
				break;
			case "#order":
				$('#acontant-tabfour').load('account/order');
				$("[href='#acontant-tabfour'] ").click();
				break;
			case "#reward":
				$('#acontant-tabfive').load('account/reward');
				$("[href='#acontant-tabfive'] ").click();
				break;
			case "#return":
				$('#acontant-tabsix').load('account/return');
				$("[href='#acontant-tabsix'] ").click();
				break;
			default :
				break;
		}
	}
	$('#acontant-tabtwo').load('account/password');
	$('#Buyers').load('account/password');
	$('#shipping').load('account/adress');
	$('#acontant-tabthree').load('account/address');
	$('#acontant-tabfour').load('account/order');
	$('#acontant-tabfive').load('account/reward');
	$('#acontant-tabsix').load('account/return');

})
function addrAjax(url,btn,content){
	$.ajax({
		url: url,
		beforeSend: function() {
			$(btn).attr({disabled:'disabled'})
		},
		complete: function() {
			$(btn).removeAttr('disabled')
		},
		success: function(data) {
			if(data==1){
				location.href='/account/login'
			}else{
				$(content).empty();
				$(content).append(data);
			}
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	})
}