document.addEventListener('DOMContentLoaded', function () {

const tds = document.querySelectorAll('.tasks .labels');

tds.forEach(td =>{
  const content = td.textContent.trim();
  if (content.includes('Blue')){
    td.classList.add('bluecolor');
  }else if(content.includes('Red')){
    td.classList.add('redcolor');
  
  }else if(content.includes('Yellow')){
    td.classList.add('yellowcolor');

  
  }else if(content.includes('Orange')){
    td.classList.add('orangecolor');

  
  }else if(content.includes('Green')){
    td.classList.add('greencolor');

  
  }
  
})
});