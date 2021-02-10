$(function(){
  $('.movetext').each(function(){
    //一文字ずつ<span>で括る
    $(this).children().addBack().contents().each(function() {
        if (this.nodeType == 3) {
        $(this).replaceWith($(this).text().replace(/(\S)/g, '<span id="animatedtext">$1</span>'));
        }
    });
    
    //inviewを使って画面に表れたら起動させる
    $(this).on('inview',function(e,onInview){
        //一文字ずつ順番に不透明させる
        if(onInview){
          
          $(this).css({'opacity':1});
          for (var i = 0; i <= $(this).children('span').length; i++) {
          $(this).children('span').eq(i).delay(10*i).animate({'opacity':1},1000);
          };

        }else{
          $('#animatedtext').css({'opacity':0});
          for (var i = 0; i <= $(this).children('span').length; i++) {
            $(this).children('span').eq(i).animate({'opacity':0});
          };

        }

    });
  });
})