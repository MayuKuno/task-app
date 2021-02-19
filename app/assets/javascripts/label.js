document.addEventListener('DOMContentLoaded', function () {

const ps = document.querySelectorAll('.labels p');

ps.forEach(p =>{
  const content = p.textContent.trim();
  console.log(content)
  if (content.includes('Blue')){
    p.classList.add('bluecolor');
    p.textContent = " ";
  }else if(content.includes('Red')){
    p.classList.add('redcolor');
    p.textContent = " ";
  
  }else if(content.includes('Yellow')){
    p.classList.add('yellowcolor');
    p.textContent = " ";

  
  }else if(content.includes('Orange')){
    p.classList.add('orangecolor');
    p.textContent = " ";

  
  }else if(content.includes('Green')){
    p.classList.add('greencolor');
    p.textContent = " ";

  
  }
  
})
});