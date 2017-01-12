$( document ).ready(function() {
  $('input#search-by-name').on('keyup', searchByName)
});

function searchByName() {
  $('.user').each(function(index, user) {
    var query = $('input#search-by-name')
                  .val()
                  .toLowerCase()
                  .replace(/[^a-zA-Z]/, '')
    var name  = $(this)
                  .children('td.user-name')
                  .children('a')
                  .text()
                  .toLowerCase()
                  .replace(/[^a-zA-Z]/, '')

    if (name.includes(query)) {
      $(this).show()
    } else {
      $(this).hide()
    }
  })
}
