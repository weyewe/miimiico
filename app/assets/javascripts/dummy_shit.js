$("img.image_feedback").each( function(a){
  var $b = $(this);
  $b.imagesLoaded(function(){
    $b.fadeIn(300, function () {
			$b.css({
				"background-image": "none"
			});
			$(this).css({
				opacity: 1
			});
		});
  });
});