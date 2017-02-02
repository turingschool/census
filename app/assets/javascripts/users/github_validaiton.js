$( document ).ready(function() {
  $('input#github-field').on('keyup', validateGithub);
});

function validateGithub() {
  if (this.value.match(/[^a-zA-Z0-9-]/)) {
    $(this).addClass('input-field-error')
    $(this).siblings('#github-hint').removeClass('hidden')
  } else {
    $(this).removeClass('input-field-error')
    $(this).siblings('#github-hint').addClass('hidden')
  }
}
