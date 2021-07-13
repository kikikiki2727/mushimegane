document.addEventListener("turbolinks:load", function() {
  $(function(){
    $("#input_image").change(function(e){
      var file = e.target.files[0];
      var reader = new FileReader
      console.log(file)

      reader.onload = (function(){
        return function(e){
          $("#image_preview").css("display", "");
          $("#image_preview").css({"width":"300px", "height":"300px"});
          $("#image_preview").attr("src", e.target.result);
        };
      })(file);
      reader.readAsDataURL(file);
    })
  })
})
