window.addEventListener('load', function() { //①

  const spans = document.querySelectorAll('.labels span');

  spans.forEach(span =>{
    const content = span.textContent.trim();
    if (content.includes('Blue')){
      span.classList.add('bluecolor');
      span.textContent = " ";
    }else if(content.includes('Red')){
      span.classList.add('redcolor');
      span.textContent = " ";
    
    }else if(content.includes('Yellow')){
      span.classList.add('yellowcolor');
      span.textContent = " ";

    
    }else if(content.includes('Orange')){
      span.classList.add('orangecolor');
      span.textContent = " ";

    
    }else if(content.includes('Green')){
      span.classList.add('greencolor');
      span.textContent = " ";

    
    }
    
  })
});