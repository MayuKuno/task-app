document.addEventListener("DOMContentLoaded", function(){
    let modal_open = document.getElementsByClassName("modal-open-btn");
    elements = Array.from(modal_open);
    elements.forEach(x => 
      x.onclick = function (e) {
        const index = elements.findIndex(x => x === e.target);
        $('#overlay').fadeIn();
        document.getElementById('modal-close-btn').onclick = function () {
          $('#overlay').fadeOut();
        };


        document.getElementById("delete-comformation-btn").onclick = function () {
          let delete_collection = document.getElementsByClassName("item-delete-btn") //.click();
          delete_array = Array.from( delete_collection ) ;
          delete_array[index].click();

        };
      }
      );

    
    
  },
  false
  
);
