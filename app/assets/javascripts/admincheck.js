document.addEventListener("DOMContentLoaded", function(){
  var admins = document.querySelectorAll(".admin");
  admins.forEach(admin => {
    admin.style.opacity = 1;
    if(admin.textContent == "あり"){
      admin.textContent = " "
      admin.innerHTML = "&#x2611;";
    }else if(admin.textContent == "なし"){
      admin.textContent = " "
      admin.innerHTML = "&#x2610;";
    }
  })

});

  