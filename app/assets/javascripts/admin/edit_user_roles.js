$('.admin-edit-user-roles').ready(function() {
  $('#searchBox').on('keypress', function(keypress) {
    if (keypress.keyCode == 13) {
      var searchParams = $(this).val();
      clearUnchecked();
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
      var cohort = "";
      if (user["cohort"] != null) {
        cohort = user["cohort"]["name"]
      }
      userTable.append('<tr data-user-id='+user["id"]+'>'+
        '<td class="selected-user"><input type="checkbox"</td>'+
        '<td>'+user["first_name"]+'</td>'+
        '<td>'+user["last_name"]+'</td>'+
        '<td>'+cohort+'</td>'+
        '<td>'+cleanRoles+'</td>'+
      '</tr>')
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

function clearUnchecked() {
  var unchecked = $('#user-role-search .selected-user input[type=checkbox]:not(:checked)')
  $.each(unchecked, function(index, input){
    $(input).parents('tr').remove();
  })
}
