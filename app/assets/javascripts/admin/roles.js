function onFail(err) {
  console.error(err)
}

function onRoleSuccess(data) {
  let roleID = data['id'];
  let updatedRoleName = data['name'];
  let roleRow = document.getElementById("role-1");
  roleRow.children[0].innerHTML = `<p class="role-name">${updatedRoleName}</p>`
  roleRow.children[1].innerHTML = 'updated'
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
      .done(onRoleSuccess)
      .fail(onFail)
    }
  })
}

$('.manage-roles-views').ready(function(){
  $('.role-name').on('click', editRole)
})
