document.addEventListener("turbolinks:load", function() {
  $(function() {
    $('.blur_button').click(function(){
      let blur_button_id = $(this).val();
      $(`.blur_${blur_button_id}`).removeClass('blur_active');
      $(`.blur_button_${blur_button_id}`).addClass('hide_button');
      $(`.hide_blur_button_${blur_button_id}`).removeClass('hide_button');
    })
  });

  $(function() {
    $('.hide_blur_button').click(function(){
      let hide_blur_button_id = $(this).val();
      $(`.blur_${hide_blur_button_id}`).addClass('blur_active');
      $(`.hide_blur_button_${hide_blur_button_id}`).addClass('hide_button');
      $(`.blur_button_${hide_blur_button_id}`).removeClass('hide_button');
    })
  })
})
