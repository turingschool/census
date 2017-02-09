$('.admin-edit-user-roles').ready(function() {
  $('#searchBox').on('blur keypress', function(keypress) {
    if (keypress.keyCode == 13 || keypress.keyCode == null) {
      var searchParams = $(this).val();
      fetchUsers(searchParams);
    }
  })
})

function fetchUsers(searchParams) {
  $.ajax({
    method: 'GET',
    url: '/api/v1/users/search_all',
    data: {q: searchParams}
  })
  .done(appendUsers)
  .fail(onFail);
}

function appendUsers(data) {
  var userTable = $('#user-role-search');
  data.forEach(function(user){
    if (userNotInTable(user["id"])) {
      var roles = ""
      user["roles"].forEach(function(role){
        roles+=(role["name"]+", ")
      })
      var cleanRoles = roles.slice(0,-2);
      userTable.append('<tr data-user-id='+user["id"]+'><td>'+user["first_name"]+'</td><td>'+user["last_name"]+'</td><td>'+user["cohort"]["name"]+'</td><td>'+cleanRoles+'</td></tr>')
    }
  })
}

function onFail(err) {
  console.error(err);
}

function userNotInTable(id) {
  var rows = $('#user-role-search').children().children()
  var present = true
  $.each(rows, function(index, row){
    if (row.getAttribute("data-user-id") == id) {
      present = false
    }
  })
  return present
}
