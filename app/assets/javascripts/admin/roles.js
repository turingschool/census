function onFail(err) {
  console.error(err)
}

function onRoleUpdate(data) {
  let roleID = data['id'];
  let updatedRoleName = data['name'];
  let updatedRoleMemberCount = data['member_count']
  let roleRow = document.getElementById(`role-${roleID}`);
  roleRow.children[0].innerHTML = `<p class="role-name">${updatedRoleName}</p>`;
  roleRow.children[1].innerHTML = `${updatedRoleMemberCount}`;
}

function editRole() {
  let role = this.innerText;
  let roleID = this.parentElement.parentElement.id.split('-')[1];
  let roleCell = this.parentElement;
  roleCell.innerHTML = `<input class="role-update" value="${role}">`;
  $('input.role-update').on('keypress', function(keypress){
    if (keypress.keyCode == 13) {
      let updatedRoleName = document.getElementsByClassName('role-update')[0].value;
      $.ajax({
        method: 'PATCH',
        url: `/api/v1/roles/${roleID}`,
        data: {role: {'name': updatedRoleName}}
      })
      .done(onRoleUpdate)
      .fail(onFail)
    }
  })
}

function deleteRole() {
  let roleID = this.parentElement.parentElement.id.split('-')[1];
  $.ajax({
    method: `DELETE`,
    url: `/api/v1/roles/${roleID}`,
  })
  .done(onRoleDelete)
  .fail(onFail);
}

$('.manage-roles-views').ready(function(){
  $('.role-name').on('click', editRole)
  $('.role-delete-button').on('click', deleteRole)
})

function onRoleDelete(data){
  let roleRow = document.getElementById(`role-${data['id']}`);
  roleRow.outerHTML = ""
}
