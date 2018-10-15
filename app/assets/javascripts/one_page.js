var ready = function(){
  addScrollBehaviour();
  addHideToggleAfterClickBehaviour();
}

$(document).ready(ready);
$(document).on('page:load', ready);

var addScrollBehaviour = function(){
  $(".scroll-links a").click(function(event){
    if(!screenXS()){
      event.preventDefault();
      $('html,body').scrollTo(this.hash, this.hash, {offset: -50});
    }
  });
}

var addHideToggleAfterClickBehaviour = function(){
  $('.navbar-one-page a, .navbar-one-page .brand').on('click', function(){
    if(screenXS()){
      $(".navbar-toggle").click();
    }
  });  
}

var screenXS = function(){
  return bootstrapEnv() == 'xs'
}

var bootstrapEnv = function() {
    var envs = ['xs', 'sm', 'md', 'lg'];

    $el = $('<div>');
    $el.appendTo($('body'));

    for (var i = envs.length - 1; i >= 0; i--) {
        var env = envs[i];

        $el.addClass('hidden-'+env);
        if ($el.is(':hidden')) {
            $el.remove();
            return env
        }
    };
}
