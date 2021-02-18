$(window).on('load', function(){
  $(".csv").change(function(){
    $(".select").text("selected!")
    $('.fa-file-upload').css('color', '#ff6e6c');
    
  });
});