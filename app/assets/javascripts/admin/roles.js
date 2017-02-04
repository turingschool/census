function onFail(err) {
  console.error(err)
}

function onRoleSuccess(data) {
  debugger;
}

function editRole() {
  let role = this.innerText;
  let roleID = this.parentElement.parentElement.id.split('-')[1];
  let roleCell = this.parentElement;
  roleCell.innerHTML = `<input class="role-update" value="${role}">`;
  let updatedRoleName = document.getElementsByClassName('role-update')[0].value;
  $('input.role-update').on('keypress', function(keypress){
    if (keypress.keyCode == 13) {
      $.ajax({
        method: 'PATCH',
        url: `/api/v1/roles/${roleID}`,
        data: {role: {'name': updatedRoleName}}
      })
      .done(onRoleSuccess)
      .fail(onFail)
    }
  })
}

$('.manage-roles-views').ready(function(){
  $('.role-name').on('click', editRole)
})
