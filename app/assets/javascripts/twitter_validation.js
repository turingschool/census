$( document ).ready(function() {
  $('input#twitter-field').on('keyup', validateTwitter);
});

function validateTwitter() {
  if (this.value.match(/[^a-zA-Z0-9_]/)) {
    $(this).addClass('input-field-error')
  } else {
    $(this).removeClass('input-field-error')
  }
}
