$(document).on 'turbolinks:load', ->
  $('#checkbox_consent').click ->
    if @checked then $('#button_delete_account').removeClass('disabled') else $('#button_delete_account').addClass('disabled')
  return