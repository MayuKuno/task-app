$(function() {
	var formInputs = $('input, textarea');

	// if ($('.form-style').val()){
	// 	$('.form-style').parent().children('p.formLabel').addClass('formTop');
	// }
	if ($('.form-style').val() != ""){
		$('.form-style').parent().children('p.formLabel').addClass('formTop');
	}


	formInputs.focus(function() {
			$(this).parent().children('p.formLabel').addClass('formTop');
  });
  
	formInputs.focusout(function() {
		if ($.trim($(this).val()).length == 0){
		$(this).parent().children('p.formLabel').removeClass('formTop');
		}
	});

	$('p.formLabel').click(function(){
		 $(this).parent().children('.form-style').focus();
	});



	//formのlabel color
	const labels = document.querySelectorAll('.select label');
  labels.forEach(label =>{

    const content = label.textContent;
    if (content.includes('Blue')){
			const div = document.createElement('div');
			label.textContent = " ";
			div.classList.add('bluecolor');
			label.appendChild(div);

    }else if(content.includes('Red')){
			const div = document.createElement('div');
			label.textContent = " ";
			div.classList.add('redcolor');
			label.appendChild(div);
    }else if(content.includes('Yellow')){
			const div = document.createElement('div');
			label.textContent = " ";
			div.classList.add('yellowcolor');
			label.appendChild(div);
    
    }else if(content.includes('Orange')){
			const div = document.createElement('div');
			label.textContent = " ";
			div.classList.add('orangecolor');
			label.appendChild(div);
    
    }else if(content.includes('Green')){
			const div = document.createElement('div');
			label.textContent = " ";
			div.classList.add('greencolor');
			label.appendChild(div);
    }
    
  })

});