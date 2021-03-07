$(function() {
  var search_list = $(".tasks tbody");
  function appendTask(task) {
    if(task.status){
      var status  = `<td>${task.status}</td>`
    }else{
      var status  = `<td></td>`
    }
    if(task.priority){
      var priority  = `<td>${task.priority}</td>`
    }else{
      var priority  = `<td></td>`
    }
    if(task.deadline){
      var deadline  = `<td>${task.deadline}</td>`
    }else{
      var deadline  = `<td></td>`
    }
    if(task.labels){
      var label  = `
                    <td class="labels">
                      ${task.labels.map(label => 
                      `
                      <span>${label.color}</span>
                      `
                      ).join(' ')}
                    </td>
                    `
    }else{
      var label  = `
                    <td class="labels">
                    
                    </td>
                    `
    }
    // if(group.users.include?(task.user)){
    //   var creator  = `<td>${task.user.username}</td>`
    // }else{
    //   var creator  = `<td></td>`
    // }

    var html = `
                <tr class="item" data-model_name="task.class.name.underscore"  data-update_url="task_sort_path(task)"} >
                  ${label}
                  <td>${task.taskname}</td>
                  ${status}
                  ${priority}
                  ${deadline}
                  <td>
                    <a href="/tasks/${task.id}/edit" data-method="get", class="btn">Edit</a>
                    <a href="/tasks/${task.id}" data-method="get", class="btn">Detail</a>
                    <a href="/tasks/${task.id}" data-method="delete", class="btn accent">Delete</a>
                  </td>
                  <td>${task.username}</td>
              </tr>

                `

    search_list.append(html);
   
  }
  // function formatDate(dt) {
  //   var dt = new Date();
  //   var y = dt.getFullYear();
  //   var m = ('00' + (dt.getMonth()+1)).slice(-2);
  //   var d = ('00' + dt.getDate()).slice(-2);
  //   dt = (y + '-' + m + '-' + d);
  //   return dt;
  // }


  function appendErrMsgToHTML(msg) {
    var html = `<tr>
                  <td class="noresult" colspan="7">
                    ${ msg }
                  </td>
                </tr>`
    search_list.append(html);
  }



  $(".search-inputs").on("keyup", function(){
    var input = $(".search-inputs").val();
    var param2 = gon.group;

    var url = "/groups/" + param2.id + "/search"

    $.ajax({
      type: 'GET',
      url: url,
      data: {keyword: input},
      dataType: 'json'
    })


    .done(function(tasks){
      search_list.empty();
      if(tasks.length !== 0){ //検索結果があったら
        tasks.forEach(function(task){
          
          appendTask(task);

        });
        //labels
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

        //date


      }else{//検索結果がなかったら
        appendErrMsgToHTML("一致するタスクがありません");
      }
    })
    .fail(function(){
      alert('error');
    })


  });
});

