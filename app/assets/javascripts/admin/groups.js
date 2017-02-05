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
  $('input.group-update').on('keypress', function(keypress){
    if (keypress.keyCode == 13) {
      var updatedGroupName = document.getElementsByClassName('group-update')[0].value;
      $.ajax({
        method: 'PATCH',
        url: '/api/v1/groups/' + groupID,
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
    url: '/api/v1/groups/' + groupID,
  })
  .done(onGroupDelete)
  .fail(onFail);
}

function onGroupDelete(data){
  var groupRow = document.getElementById('group-' + data['id']);
  groupRow.outerHTML = ""
}

$('.manage-groups-views').ready(function(){
  $('.group-name').on('click', editGroup)
  $('.group-delete-button').on('click', deleteGroup)
})
