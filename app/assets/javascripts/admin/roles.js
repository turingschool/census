function onFail(err) {
  console.error(err)
}

function onRoleUpdate(data) {
  var roleID = data['id'];
  var updatedRoleName = data['name'];
  var updatedRoleMemberCount = data['member_count']
  var roleRow = document.getElementById('role-' + roleID);
  roleRow.children[0].innerHTML = '<p class="role-name">' + updatedRoleName + '</p>';
  roleRow.children[1].innerHTML = updatedRoleMemberCount;
}

function editRole() {
  var role = this.innerText;
  var roleID = this.parentElement.parentElement.id.split('-')[1];
  var roleCell = this.parentElement;
  roleCell.innerHTML = '<input class="role-update" value="' + role + '">';
  roleCell.children[0].focus();
  $('input.role-update').on('blur keypress', function(keypress){
    if (keypress.keyCode == 13 || keypress.keyCode == null) {
      var updatedRoleName = document.getElementsByClassName('role-update')[0].value;
      $.ajax({
        method: 'PATCH',
        url: '/api/v1/roles/' + roleID,
        data: {role: {'name': updatedRoleName}}
      })
      .done(onRoleUpdate)
      .fail(onFail)
    }
  })
}

function deleteRole() {
  var roleID = this.parentElement.parentElement.id.split('-')[1];
  $.ajax({
    method: 'DELETE',
    url: '/api/v1/roles/' + roleID,
  })
  .done(onRoleDelete)
  .fail(onFail);
}

$('.manage-roles-views').ready(function(){
  $('.role-table').on('click', '.role-name', editRole)
  $('.role-delete-button').on('click', deleteRole)
})

function onRoleDelete(data){
  var roleRow = document.getElementById('role-' + data['id']);
  roleRow.outerHTML = ""
}
