$( document ).ready(function() {
  $('input#twitter-field').on('keyup', validateTwitter);
});

function validateTwitter() {
  if (this.value.match(/[^a-zA-Z0-9_]/)) {
    $(this).addClass('input-field-error')
    $(this).siblings('#twitter-hint').removeClass('hidden')
  } else {
    $(this).removeClass('input-field-error')
    $(this).siblings('#twitter-hint').addClass('hidden')
  }
}
