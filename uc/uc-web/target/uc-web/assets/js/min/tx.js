$(function(){
	$.getScript("http://wpa.b.qq.com/cgi/wpa.php",function(){
		$("body").append('<div id="BizQQWPA"><a href="javascript:;"></a></div>');
		BizQQWPA.addCustom({aty: '2', a: '2', nameAccount: 800054392, selector: 'BizQQWPA'});
	});
})