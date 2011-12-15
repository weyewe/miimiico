/******************************************************
    * jQuery plug-in
    * Easy Background Image Resizer
    * Developed by J.P. Given (http://johnpatrickgiven.com)
    * Useage: anyone so long as credit is left alone
******************************************************/

(function(a){function c(){
	var $a = a("#jq_ez_bg"),
		$a_img = $a.children('img'),
		ww = a(window).width(),
		wh = a(window).height();
	$a.css({
		'position':"fixed",
		'top':"0px",
		'left':"0px",
		'z-index':"-1",
		'overflow':"hidden",
		'width':ww+"px",
		'height':wh+"px",
		'opacity':b.opacity});
	$a_img.css("position","relative");
	var c = $a_img.width();
	var d = $a_img.height();
	if(ww>wh){
		if(c>d){
			var e=c/d;
			$a_img.css("width",ww+"px");
			$a_img.css("height",Math.round(ww*(1/e)));
			var f=Math.round(ww*(1/e));
			if(f<wh){
				var e=d/c;
				$a_img.css("height",wh);
				$a_img.css("width",Math.round(wh*(1/e)))
			}
		}else{
			var e=d/c;
			$a_img.css("height",wh);
			$a_img.css("width",Math.round(wh*(1/e)))
		}
	}else{
		var e=d/c;$a_img.css("height",wh);
		$a_img.css("width",Math.round(wh*(1/e)))
	}
	if(typeof b.center=="undefined"||b.center){
		if($a_img.width()>ww){
			var g=($a_img.width()-ww)/2;
			$a_img.css({top:0,left:-g})
		}
		if($a_img.height()>wh){
			var h=($a_img.height()-wh)/2;
			$a_img.css({left:0,top:-h})}
		}
		a("#jq_ez_bg img").fadeIn(400);
		a("body").css({overflow:"auto"})
	}
	var b={};
	a.fn.ezBgResize=function(d){
		b=d;
		if(!a.isArray(b.img)){
			var e=b.img;b.img=[e]
		}
		a("<img/>").attr("src",b.img).load(function(){
			b.width=this.width;
			b.height=this.height;
			a("body").append('<div id="jq_ez_bg"></div>');
			a("#jq_ez_bg").html('<img src="'+b.img[0]+'" width="'+b.width+'" height="'+b.height+'" border="0">');
			a("#jq_ez_bg img").css("display","none");
			a("body").css({overflow:"hidden"});
			c();
		})
	};
	
	a(window).bind("resize",function(){c()})})(jQuery)
		