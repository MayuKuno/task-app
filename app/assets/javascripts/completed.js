document.addEventListener("DOMContentLoaded", function(){

  const completes = document.querySelectorAll('.complete');

  completes.forEach(complete => {
    const check = complete.nextElementSibling.children[0];
    if (complete.textContent == "Completed"){
      check.style.color ='#ff6e6c';

    }

  })



});