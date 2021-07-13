document.addEventListener("turbolinks:load", function() {
  $(function(){
    $("#input_image").change(function(){
      var file = $(this).prop('files')[0];
      var reader = new FileReader

      reader.onload = (function(){
        $("#image_preview").css("display", "");
        $("#image_preview").css({"width":"300px", "height":"300px"});
        $("#image_preview").attr("src", reader.result);
      });
      reader.readAsDataURL(file);
    })
  })
})
