$( document ).ready(function() {
  $('input#slack-field').on('keyup', validateSlack);
});

function validateSlack() {
  if (this.value.match(/[^a-z0-9-.]/)) {
    $(this).addClass('input-field-error')
    $(this).siblings('#slack-hint').removeClass('hidden')
  } else {
    $(this).removeClass('input-field-error')
    $(this).siblings('#slack-hint').addClass('hidden')
  }
}
