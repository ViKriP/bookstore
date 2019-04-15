$(document).on "turbolinks:load", ->
  $ ->
    $('#read-more').click (event) ->
      event.preventDefault()
      $('#long-desc').toggle()
      $('#short-desc').toggle()
      return
    return
  $ ->
    $('#decrease').click (event) ->
      event.preventDefault()
      amount_in_input = parseInt($('#order-quantity').val())
      if (amount_in_input > 1)
        $('#order-quantity').val(amount_in_input - 1)
      return
    return
  $ ->
    $('#increase').click (event) ->
      event.preventDefault()
      amount_in_input = parseInt($('#order-quantity').val())
      current_amount = parseInt($('#quantity').val())
      if (amount_in_input < current_amount)
        $('#order-quantity').val(amount_in_input + 1)
      return
    return
  $ ->
    $('#review').on 'keyup', ->
      length = $(this).val().length
      $('#review-body-count').html 500 - length
      return
    return
  $ ->
    $('#order-quantity').on 'keyup', ->
      if isNaN($('#order-quantity').val())
        $('#order-quantity').val(1)
      amount_in_input = parseInt($('#order-quantity').val())
      current_amount = parseInt($('#quantity').html())
      if (amount_in_input > current_amount)
        $('#quantity-info').html 'Sorry, there are only ' + current_amount + ' books.'
        $('#order-quantity').val(current_amount)
      else
        $('#quantity-info').empty()
      return
    return