$( document ).ready(function() {
  $('input#linkedin-field').on('keyup', validateLinkedIn);
});

function validateLinkedIn() {
  if (this.value.match(/[^a-zA-Z0-9-]/)) {
    $(this).addClass('input-field-error')
    $(this).siblings('#linkedin-hint').removeClass('hidden')
  } else {
    $(this).removeClass('input-field-error')
    $(this).siblings('#linkedin-hint').addClass('hidden')
  }
}
