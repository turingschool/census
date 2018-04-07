function onFail(err) {
  console.error(err)
}

function onGroupUpdate(data) {
  var groupID = data['id'];
  var updatedGroupName = data['name'];
  var updatedGroupMemberCount = data['member_count']
  var groupRow = document.getElementById('group-' + groupID);
  groupRow.children[0].innerHTML = '<p class="group-name">' + updatedGroupName + '</p>';
  groupRow.children[1].innerHTML = updatedGroupMemberCount;
}

function editGroup() {
  var group = this.innerText;
  var groupID = this.parentElement.parentElement.id.split('-')[1];
  var groupCell = this.parentElement;
  groupCell.innerHTML = '<input class="group-update" value="' + group + '">';
  groupCell.children[0].focus();
  $('input.group-update').on('blur keypress', function(keypress){
    if (keypress.keyCode == 13 || keypress.keyCode == null) {
      var updatedGroupName = document.getElementsByClassName('group-update')[0].value;
      $.ajax({
        method: 'PATCH',
        url: '/api/v1/admin/groups/' + groupID,
        data: {group: {'name': updatedGroupName}}
      })
      .done(onGroupUpdate)
      .fail(onFail)
    }
  })
}

function deleteGroup() {
  var groupID = this.parentElement.parentElement.id.split('-')[1];
  $.ajax({
    method: 'DELETE',
    url: '/api/v1/admin/groups/' + groupID,
  })
  .done(onGroupDelete)
  .fail(onFail);
}

function onGroupDelete(data){
  var groupRow = document.getElementById('group-' + data['id']);
  groupRow.outerHTML = ""
}

$('.manage-groups-views').ready(function(){
  $('.group-table').on('click', '.group-name', editGroup)
  $('.group-delete-button').on('click', deleteGroup)
})
