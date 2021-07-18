document.addEventListener("turbolinks:load", function() {
  var _window = $(window),
      _header = $('.header_body'),
      heroBottom = 220;
  
  _window.on('scroll',function(){
      if(_window.scrollTop() > heroBottom){
          _header.addClass('header_transform');   
      }
      else{
          _header.removeClass('header_transform');   
      }
  });
  
  _window.trigger('scroll');
})
