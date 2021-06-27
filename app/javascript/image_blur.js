document.addEventListener("turbolinks:load", function() {
  $(function() {
    $('.blur_button').click(function(){
      $('.blur').removeClass('blur_active');
      $('.blur_button').addClass('hide_button');
      $('.hide_blur_button').removeClass('hide_button');
    })
  });

  $(function() {
    $('.hide_blur_button').click(function(){
      $('.blur').addClass('blur_active');
      $('.hide_blur_button').addClass('hide_button');
      $('.blur_button').removeClass('hide_button');
    })
  })
})
