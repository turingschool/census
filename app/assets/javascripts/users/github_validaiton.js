$( document ).ready(function() {
  $('input#github-field').on('keyup', validateGithub);
});

function validateGithub() {
  if (this.value.match(/\B@([a-z0-9](?:-?[a-z0-9]){0,38})/)) {
    $(this).addClass('input-field-error')
    $(this).siblings('#github-hint').removeClass('hidden')
  } else {
    $(this).removeClass('input-field-error')
    $(this).siblings('#github-hint').addClass('hidden')
  }
}
