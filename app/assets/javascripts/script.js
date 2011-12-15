var top_bar_fixed = true;		// {true|false}
var top_bar_animated = true;	// {true|false}
var nook_toolbar = false;		// {true|false}

(function($){})(window.jQuery);
$(document).ready( function() {

	sidebar_();			//hides footer if nav overlaps called on load, resize
	content_valign();	// vertical align articles if shorter than page
	
/*------------------------------------------------------------
	Google Map displayed on Contact page only
	- to get longitude/latitude visit: http://itouchmap.com/latlong.html
	- get your Google Maps API key here: http://code.google.com/intl/en-US/apis/maps/signup.html
------------------------------------------------------------*/
	if ($("#gmap").length >= 1) {
		$("#gmap").gMap({
			controls: false,
			latitude: 40.703005,
			longitude: -73.986745,
			zoom: 15,
			markers: [{
				latitude: 40.703005,
				longitude: -73.986745
			}]
		});
	}
/*------------------------------------------------------------
	On Image load fade in
------------------------------------------------------------*/
	if ($("figure").length >= 1) {
		$("figure").find("*").css({
			opacity: 0
		}).end().each(function (a) {
			var $b = $(this);
			$b.imagesLoaded(function () {
				$b.find("*").not(".preview-large-hover").fadeIn(300, function () {
					$b.css({
						"background-image": "none"
					});
					$(this).css({
						opacity: 1
					});
				});
			});
		});
	}

/*------------------------------------------------------------
	Large Image Preview
------------------------------------------------------------*/
	$("#img-preview-controls").addClass("hide");
	$(".preview-large-hover a").live('click', function (a) {
		a.preventDefault();
		var $b = $(this),
			c = trim($b.attr("href")),
			d = trim($b.parents(".post").find(".post-title").text()),
			e = trim($b.parents(".post").find(".post-title a").attr("href"));
		if (!$("html").hasClass("oldie")) {
			$("#main").fadeOut(500, function () {
				$("#img-view-post").attr("href", e);
				$("#img-title").attr("href", e).text(d);
				$("#img-preview-controls").css({
					opacity: 1
				}).removeClass("hide").animate({
					opacity: 1
				});
				$("body").ezBgResize({
					img: c,
					opacity: 1,
					center: true
				});
			});
		} else {
			window.location = e
		}
	});
	$("#img-close, #jq_ez_bg, #jq_ez_bg img").click(function (a) {
		a.preventDefault();
		$("#jq_ez_bg").fadeOut(function () {
			$(this).remove();
			$("body").css({
				overflow: "visible"
			});
			$("#img-preview-controls").animate({
				opacity: 0
			}, function () {
				$(this).addClass("hide")
			});
			$("#main").fadeIn(500, function () {
				$g.masonry("reload")
			});
		});
	});
/*------------------------------------------------------------
	Image Hover (large preview indicator)
------------------------------------------------------------*/
	$(".preview-large-hover").css({
		display: "block",
		opacity: 0
	});
	$(".list figure, .grid figure").has(".preview-large-hover").hoverIntent(function () {
		$(this).find(".preview-large-hover").animate({
			opacity: 1
		}, 200);
	}, function () {
		$(this).find(".preview-large-hover").animate({
			opacity: 0
		}, 300);
	});
/*------------------------------------------------------------
	Back To Top
------------------------------------------------------------*/
	$('.back-to-top a').click(function (e) {
		e.preventDefault();
		$('html, body').stop().animate({
			scrollTop: 0
		}, Math.floor($(window).scrollTop() / 2));
		return false;
	});
/*------------------------------------------------------------
	Nivo Slider Plugin
------------------------------------------------------------*/
	$('.nivoSlider').nivoSlider({
		'captionOpacity': 1,
		'controlNav': 0,
		'animSpeed': 400,
		'pauseTime': 4000
	});
/*------------------------------------------------------------
	Cycle Plugin
------------------------------------------------------------*/
	var $c = $(".cycle");
	$c.after('<div class="cycle-nav"></div>');
	$c.imagesLoaded(function () {
		var a = $c.length;
		for (var b = 0; b < a; b++) {
			var ci = $c.eq(b);
			ci.css({
				height: ci.find("img").first().height() + "px",
				width: ci.find("img").first().width() + "px"
			});
			ci.parent(".post").find(".cycle-nav").html('<div id="cycle-nav-' + b + '"></div>');
			ci.cycle({
				fx: "fade",
				speed: "fast",
				pause: 1,
				speed: 1200,
				pauseOnPagerHover: 1,
				timeout: rand_cycle(a),
				fastOnEvent: 300,
				pauseOnPagerHover: 1,
				pager: "#cycle-nav-" + b
			});
		}
	});
/*------------------------------------------------------------
	Masonry / Grid
------------------------------------------------------------*/
	var $g = $(".grid");
	$g.imagesLoaded(function () {
		$g.masonry({
			singleMode: false,
			gutter: 20,
			itemSelector: ".post",
			isAnimated: !Modernizr.csstransitions
		});
	});
/*------------------------------------------------------------
	Navigation
------------------------------------------------------------*/
	var nav_sp = 300;
	$("#nav-primary li:has(ul)").prepend("<span></span>").find("ul").css({
		display: "block"
	}).hide(0);
	$("#nav-primary li:has(ul) > a, #nav-primary li:has(ul) > span").click(function (a) {
		var b = $(this).parent("li");
		if (!b.hasClass("active")) {
			a.preventDefault();
			$(".active").find("ul").first().slideUp(nav_sp, function () {
				$(this).parent("li").removeClass("active")
			});
			b.removeClass("current").addClass("active").find("ul").first().slideDown(nav_sp, function () {
				$temp = sidebar_()
			});
		} else if (b.hasClass("active") && a.target.nodeName == "SPAN") {
			$(".active").find("ul").first().slideUp(nav_sp, function () {
				$(this).parent("li").removeClass("active");
				$temp = sidebar_()
			});
		}
	});
/*------------------------------------------------------------
	Social Icons
------------------------------------------------------------*/
	$("#social a").hoverIntent(function () {
		$(this).animate({
			opacity: 1
		});
	}, function () {
		$(this).animate({
			opacity: .5
		});
	});
/*------------------------------------------------------------
	Resize iframes
------------------------------------------------------------ */
	$(".list iframe, .grid iframe").each(function () {
		var a = $(this).height();
		var b = $(this).width();
		$(this).css({
			width: "100%"
		});
		var c = ratio_height(a, b, $(this).width());
		$(this).css({
			height: c + "px"
		}).parent("figure").css({
			height: c + "px"
		});
	});
/*------------------------------------------------------------
	Search and HTML5 input / placeholder / value
------------------------------------------------------------*/
	$("input[type=text], input[type=email], input[type=email], input[type=number], input[type=search]").data("value", $(this).val());
	$("form").each(function () {
		$(this).append('<input type="reset" class="hide" />')
	});
	$("input[type=reset]").trigger("click").remove();
	$("input").focus(function () {
		var $x = $(this);
		if ($x.val() == $x.data("value")) {
			$x.val("")
		}
		if ($x.is('#query')) {
			$x.parents('#search').addClass('search-focus');
		}
	}).blur(function () {
		var $x = $(this);
		if ($x.val() == "") {
			$x.val($x.data("value"))
		}
		if ($x.is('#query')) {
			$x.parents('#search').removeClass('search-focus');
		}
	});
}); // <-- ends document.ready
$(window).load(function() {
	nook_();
	sidebar_();
});
$(window).resize(function() {
	sidebar_();
	content_valign();
});
/*------------------------------------------------------------
	On Scroll Stuff (top-bar, to-top, etc...)
------------------------------------------------------------*/
$(window).scroll(function() {
	var $h = $('#main').find('header:first'),
	    $t = $('.back-to-top'),
	    $c = $('#content-area');
	if ($(window).scrollTop() > $h.height()) {
	    $t.fadeIn(300);
	    if (top_bar_fixed) {
	        $c.css({
	            marginTop: $h.height() + "px"
	        });
	        if ($h.css('position').toString() != "fixed") {
	            if (top_bar_animated) {
	                $h.css({
	                    position: "fixed",
	                    top: "-" + $h.height() + "px",
	                    right: 0,
	                    zIndex: 9999
	                }).animate({
	                    top: 0
	                }, 700);
	            } else {
	                $h.css({
	                    position: "fixed",
	                    top: 0,
	                    right: 0,
	                    zIndex: 9999
	                });
	            }
	        }
	    }
	} else {
	    $t.fadeOut(300);
	    if (top_bar_fixed) {
	        $h.css({
	            position: "relative",
	            marginTop: "0"
	        });
	        $c.css({
	            marginTop: "10px"
	        });
	    }
	}
});

/* Helper functions ///////////////////////////////////////////////////////////////////////////*/
var content_valign=function(){var a=$("#content-area").not('.grid'),b=$(window).height()-$("#main > header").first().height();if(a.height()<b){var c=Math.floor((b-a.height())/2);if(c>=80){a.css({"margin-top":$("#main > header").first().height()+10+"px"})}else{a.css({"margin-top":c+"px"})}}return false}
/* hides fixed footer so as not to overlap navigation */
var sidebar_=function(){$("#main").css({"margin-left":$("#header").first().width()+"px"});$("body").find("header").first().css({height:$(window).height()+"px"});var a=$("#footer").position().top;var b=$("#nav-primary").height()+$("#nav-primary").position().top;if(a<=b){$("#footer").addClass("hide")}else{$("#footer").removeClass("hide")}return false}
/* returns new height given the old height, old width and new width */
var ratio_height=function(o_h,o_w,n_w){return Math.floor((o_h/o_w)*n_w)}
/* returns random milliseconds unless only one `.cycle` on page */
var rand_cycle=function(a){var b=5e3,c=12e3;if(a>1){var d=Math.floor(Math.random()*c);return d>b?d:b}else{return b}}
/* javascript alternative to php's trim function */
var trim=function(a){return a.replace(/^\s+|\s+$/g,"")}
/* javascript alternative to php's str_replace(search, replace, subject, count)*/
var str_replace=function(a,b,c,d){var e=0,f=0,g="",h="",i=0,j=0,k=[].concat(a),l=[].concat(b),m=c,n=Object.prototype.toString.call(l)==="[object Array]",o=Object.prototype.toString.call(m)==="[object Array]";m=[].concat(m);if(d){this.window[d]=0}for(e=0,i=m.length;e<i;e++){if(m[e]===""){continue}for(f=0,j=k.length;f<j;f++){g=m[e]+"";h=n?l[f]!==undefined?l[f]:"":l[0];m[e]=g.split(k[f]).join(h);if(d&&m[e]!==g){this.window[d]+=(g.length-m[e].length)/k[f].length}}}return o?m:m[0]}
/* nook color chooser */
nook_=function(){if(nook_toolbar){$.ajax({url:"../_nook/nook.html?v=2",dataType:"html",success:function(a){$("body").append(a);var b="pattern";if($.cookie(b)){$("body").addClass($.cookie(b)).data(b,$.cookie(b))}else{$("body").addClass(b+"-none").data(b,b+"-none")}var c=300,d=$("#nook"),e=parseInt(d.css("border-left-width"))+parseInt(d.css("border-right-width")),f=d.width()+e,g=$("#hex"),h=$("#pattern");d.animate({"margin-right":"-"+f+"px"});$("#nook-toggle").toggle(function(){$(this).addClass("n-o");d.animate({"margin-right":"-"+e+"px"},c)},function(){$(this).removeClass("n-o");d.animate({"margin-right":"-"+f+"px"},c)});g.find("a").hoverIntent(function(){$(this).animate({"margin-top":"-5px",height:"40px"},100).addClass("nook-hover")},function(){$(this).animate({"margin-top":"0",height:"30px"},100).removeClass("nook-hover")});h.find("a").hoverIntent(function(){$(this).animate({marginTop:"-5px",marginLeft:"-5px",height:"30px",width:"30px"},100).addClass("nook-hover")},function(){$(this).animate({marginTop:"0",marginLeft:"0",height:"20px",width:"20px"},100).removeClass("nook-hover")}).click(function(a){a.preventDefault();var c=$(this).attr("id").toString();console.log(c);if($("body").data(b).toString()!=c){$.cookie(b,c);$("body").removeClass($("body").data(b)).addClass(c).data(b,c)}})}})}return false}
