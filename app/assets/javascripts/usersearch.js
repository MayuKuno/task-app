$(function(){

    function addParticipants(user) { //検索結果を表示する(該当あり)
      let html = `
        <div class="user">
          <p>${user.username}</p>
          <div class="btns btns--add" data-user-id="${user.id}" data-user-username="${user.username}">Add</div>
        </div>
        `;
      $("#result").append(html);
    }
  
    function addNoparticipants() { //検索結果を表示する(該当なし)
      let html = `
        <div class="user">
          <p>User Not Found</p>
        </div>
      `;
      $("#result").append(html);
    }

    function addDeleteUser(username,id) { //検索結果から追加する（表示）
      let html = `
      <div class="user" id="${id}">
        <p>${username}</p>
        <div class="user-search-remove btns btns--remove js-remove-btn" data-user-id="${id}" data-user-username="${username}">Delete</div>

      </div>
      `;
      $(".js-add-participant").append(html);
    }

    function addMember(userId) { //検索結果から追加する（データ）
      let html = `
      <input value="${userId}" name="group[user_ids][]" type="hidden" id="group_user_ids_${userId}" />
      `;
      $(`#${userId}`).append(html);
    }

    $("#searchinput").on("keyup", function() {
      let input = $("#searchinput").val();
      $.ajax({
        type: "GET",
        url: "/users",
        data: { keyword: input },
        dataType: "json"
      })
      .done(function(users) {
        $("#result").empty();
        if (users.length !== 0) {
          users.forEach(function(user) {
            let idNum = document.getElementById(user.id);
            console.log(idNum)
            if (user.id && !idNum) {
              addParticipants(user);
            }else{
              addNoparticipants();
            }
          });
        }else if(input.length == 0){
          return false;
        } else {
          addNoparticipants();
        }
      })
      .fail(function() {
        alert("通信エラーです。ユーザーが表示できません。");
      });
    });


    $(document).on("click", ".btns--add", function() { //追加ボタン押した時
      const username = $(this).attr("data-user-username");
      const userId = $(this).attr("data-user-id");
      $(this).parent().remove();
      addDeleteUser(username, userId);
      addMember(userId);
    });


    $(document).on("click", ".btns--remove", function() { //削除ボタン押した時
      $(this).parent().remove();
    });


  });


  

