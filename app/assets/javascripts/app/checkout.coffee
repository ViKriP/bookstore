$(document).ready ->
  $('#credit-card').mask '0000 0000 0000 0000'
  $('#exp-month').mask '00'
  $('#exp-year').mask '00'
  $('#cvv').mask '0000'
  $('#phone').mask '+000000000000000'
  $('[data-toggle="tooltip"]').tooltip()
  $('#use_billing').change ->
    if @checked
      $('#shipping').fadeOut 'fast'
    else
      $('#shipping').fadeIn 'fast'
  return