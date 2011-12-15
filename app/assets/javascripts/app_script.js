$(document).ready(function(){
 /*
 
 Type 1 
 .entity-wrapper
 .entity-show
 .entity-hide
 .entity
 
 var $clicked_node = $(clicked_node);
 var $wrapper = $clicked_node.parents(".cv-section");
 
 
 Type 2 
 .entity-display
 .entity-edit
 .entity-wrapper
 .show-entity-edit
 .hide-entity-edit
 
 
 */
  
  
  $(".entity-show").click(function(){
    var $entity = getEntity( $(this) ); 
    $entity.fadeIn();
    return false;
  });
  
  $(".entity-hide").click(function(){
    var $entity = getEntity( $(this) );  
    $entity.fadeOut();
    return false;
  });
  
  $(".show-entity-edit, .hide-entity-edit").click(function(){
    toggleEntityEditAndDisplay(  $(this) );
    return false;
  });
  
  
  /* ShowLoading */
  $("form.ajaxform").live('submit',function(){
     var $this = $(this);
     var destination = $(this).attr('action');
     var $form_container = $this.parent();
     $this.showLoading();
   	$.ajax({
   		url: destination,
   		type: "POST",
   		data: $(this).serialize(),
   		dataType: 'script',
   		success: function(response){
   		  $this.clearForm();
        $this.hideLoading();
        PilipotoJcropApi.release();
   		}
   	});
   	return false;
   });

   $("form.exeShowLoading").live('submit',function(){
     $(this).showLoading();
   });
   
   
 
});

function getEntity( entity_trigger ){
  var $entity_wrapper = entity_trigger.parents(".entity-wrapper");
  var $entity = $(".entity", $entity_wrapper);
  return $entity;
}

function toggleEntityEditAndDisplay( entity_trigger) {
  var $entity_wrapper = entity_trigger.parents(".entity-wrapper");
  var $entity_edit = $(".entity-edit", $entity_wrapper);
  var $entity_display = $(".entity-display", $entity_wrapper);
  console.log("Before conditionals");
  
  if( entity_trigger.hasClass("show-entity-edit")){
    console.log("it is the show ");
    $entity_edit.show();
    console.log("after showing entity_edit");
    $entity_display.hide();
    console.log("after hiding entity_display");
  }else {
    console.log("it is the hide ");
    $entity_edit.hide();
    $entity_display.show();
  }
  
  console.log("Done");
}

$.fn.clearForm = function() {
  return this.each(function() {
    var type = this.type, tag = this.tagName.toLowerCase();
    if (tag == 'form')
      return $(':input',this).clearForm();
    if (type == 'text' || type == 'password' || tag == 'textarea')
      this.value = '';
    else if (type == 'checkbox' || type == 'radio')
      this.checked = false;
    else if (tag == 'select')
      this.selectedIndex = -1;
  });
};
