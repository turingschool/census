$('.admin-edit-user-roles').ready(function() {
  $('#searchBox').on('keypress', function(keypress) {
    if (keypress.keyCode == 13) {
      var searchParams = $(this).val();
      clearUnchecked();
      fetchUsers(searchParams);
    }
  })
  $('#submitButton').click(function(e) {
    e.preventDefault();
    searchParams = $('#searchBox').val();
    clearUnchecked();
    fetchUsers(searchParams);
  });
  $('#save-button').on('click', function(event) {
    var action = $('#add-delete-role').val();
    if (action == 'Add') {
      addUserRoles();
    } else if (action == "Delete"){
      removeUserRoles();
    }
  })
  $('#checkAll').on('click', function(event) {
    if ($('#checkAll').is(":checked")) {
      $(".singleBox").prop("checked", true);
    } else {
      $(".singleBox").prop("checked", false);
    }
  })
  $('.no-records-found').remove();
})

function updateTable(data) {
  $('#user-role-search tbody').remove();
  $('input[type="checkbox"]').prop("checked", false);
  appendUsers(data);
  $(".admin-edit-user-roles").notify(
  data.length == 1 ? data.length + " user updated!" : data.length + " users updated!", "success");
  { position:"top center"
};
}

function fetchUsers(searchParams) {
  $.ajax({
    method: 'GET',
    url: '/api/v1/admin/users/search_all',
    data: {q: searchParams}
  })
  .done(appendUsers)
  .fail(onFail);
}

function requestAddUserRoles(userIds, roleIds) {
  $.ajax({
    method: 'PATCH',
    url: '/api/v1/admin/users/add_roles',
    data: {users: userIds, roles: roleIds}
  })
  .done(function(data){
    updateTable(data)
  })
  .fail(onFail);
}

function requestRemoveUserRoles(userIds, roleIds) {
  $.ajax({
    method: 'PATCH',
    url: '/api/v1/admin/users/remove_roles',
    data: {users: userIds, roles: roleIds}
  })
  .done(function(data){
    updateTable(data)
  })
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
        '<td class="selected-user"><input type="checkbox" class="singleBox"</td>'+
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

function addUserRoles() {
  var checkedUsers = $('#user-role-search .selected-user input[type=checkbox]:checked')
  var userIds = []
  $.each(checkedUsers, function(index, input){
    userIds.push($(input).parents('tr').data("user-id"))
  })
  var checkedRoles = $('#role-check-boxes input[type=checkbox]:checked')
  var roleIds = []
  $.each(checkedRoles, function(index, input){
    roleIds.push($(input).data("role-id"))
  })
  requestAddUserRoles(userIds, roleIds);
}

function removeUserRoles() {
  var checkedUsers = $('#user-role-search .selected-user input[type=checkbox]:checked')
  var userIds = []
  $.each(checkedUsers, function(index, input){
    userIds.push($(input).parents('tr').data("user-id"))
  })
  var checkedRoles = $('#role-check-boxes input[type=checkbox]:checked')
  var roleIds = []
  $.each(checkedRoles, function(index, input){
    roleIds.push($(input).data("role-id"))
  })
  requestRemoveUserRoles(userIds, roleIds);
}
