$(function(){
  $('.table-sortable').sortable({
    axis: 'y',
    items: '.item',

    // Ajaxで並び順のデータをコントローラーに送信
    update(e, ui) {
      let item = ui.item;
      let item_data = item.data();
      let params = { _method: 'put' };
      params[item_data.model_name] = { row_order_position: item.index() };
      $.ajax({
        type: 'POST',
        url: item_data.update_url,
        dataType: 'json',
        data: params,
      });
    },


    // エフェクトを付与
    stop(e, ui) {
      return ui.item.children('td').effect('highlight', { color: "#e2daeb" }, 500);
    },
  });
});