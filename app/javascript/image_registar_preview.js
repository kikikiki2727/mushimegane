document.addEventListener("turbolinks:load", function() {
  $(function(){
    $("#registar_image").change(function(){
      var file = $(this).prop('files')[0];
      var reader = new FileReader

      reader.onload = (function(){
        $("#registar_image_preview").css("display", "");
        $("#registar_image_preview").css({"width":"350px", "height":"250px"});
        $("#registar_image_preview").attr("src", reader.result);
      });
      reader.readAsDataURL(file);
    })
  })
})
