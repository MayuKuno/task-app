$(window).on('load', function(){

    function readURL(input) {

        if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
          console.log('ss')

          $('#img_prev').attr('src', e.target.result);
        }
        reader.readAsDataURL(input.files[0]);
        }
    }
    $(".file").change(function(){

      readURL(this);
    });
  });

  