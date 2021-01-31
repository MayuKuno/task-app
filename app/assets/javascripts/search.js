$(function() {
  var search_list = $(".tasks");
  function appendRow(){
    var html = `
    <thead>
      <tr>
        <th>Label</th>
        <th id="taskname">Name of Task</th>
        <th>Status</th>
        <th>Deadline</th>
        <th>Created_at</th>
        <th>Manage</th>
      </tr>
    </thead>
    `
    search_list.append(html);

  }
  function appendTask(task) {
    var html = `
            <tbody>
                <tr>
                <td>
                  ${task.labels.map(label => 
                    `
                    ${label.color}
                  `
                  ).join(' ')}
                </td>
                <td>${task.taskname}</td>
                <td>${task.status}</td>
                <td>${task.deadline}</td>
                <td>${task.created_at}</td>
                <td>
                  <a href="/tasks/${task.id}/edit" data-method="get">Edit</a>
                  <a href="/tasks/${task.id}" data-method="delete">Delete</a>
                  <a href="/tasks/${task.id}" data-method="get">Detail</a>
                </td>
              </tr>
              </tbody>
                `

    search_list.append(html);
   
  }

  function appendErrMsgToHTML(msg) {
    var html = `<div class='name'>${ msg }</div>`
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

      if(tasks.length !== 0){
        appendRow();
        tasks.forEach(function(task){
          if(task.user_sign_in.id == task.user_id){
            appendTask(task);
          }else{
            appendErrMsgToHTML("一致するタスクがありません");

          }
        });
      }else{
        appendRow();
        appendErrMsgToHTML("一致するタスクがありません");
      }
    })
    .fail(function(){
      alert('error');
    })
  });
});