(function(Spine, $){
  $.support.touch = ('ontouchstart' in window);
  Spine.Controller.fn.tap = $.support.touch ? "tap" : "click";
})(Spine, Spine.$)