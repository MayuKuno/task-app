$(function() {
  var search_list = $(".tasks tbody");
  function appendTask(task) {
    if(task.labels){
      var label  = `
                    <td>
                      ${task.labels.map(label => 
                      `
                      ${label.color}
                      `
                      ).join(' ')}
                    </td>
                    `
    }else{
      var label  = `
                    <td>
                    
                    </td>
                    `
    }
    var html = `
                <tr>
                  ${label}
                  <td>${task.taskname}</td>
                  <td>${task.status}</td>
                  <td>${task.deadline}</td>
                  <td>${task.created_at}</td>
                  <td>
                    <a href="/tasks/${task.id}/edit" data-method="get", class="btn">Edit</a>
                    <a href="/tasks/${task.id}" data-method="get", class="btn">Detail</a>
                    <a href="/tasks/${task.id}" data-method="delete", class="btn accent">Delete</a>
                  </td>
              </tr>

                `

    search_list.append(html);
   
  }

  function appendErrMsgToHTML(msg) {
    var html = `<tr>
                  <td class="noresult" colspan="6">
                    ${ msg }
                  </td>
                </tr>`
    search_list.append(html);
  }



  $(".search-input").on("keyup", function(){
    var input = $(".search-input").val();

    $.ajax({
      type: 'GET',
      url: "/tasks/searches",
      data: {keyword: input},
      dataType: 'json'
    })

    .done(function(tasks){
      search_list.empty();
      if(tasks.length !== 0){ //検索結果があったら
        tasks.forEach(function(task){

          if(task.user_sign_in.id == task.user_id && task.group_id == null){
            appendTask(task);
          }

        });
      }else{//検索結果がなかったら
        appendErrMsgToHTML("一致するタスクがありません");
      }
    })
    .fail(function(){
      alert('error');
    })
  });
});