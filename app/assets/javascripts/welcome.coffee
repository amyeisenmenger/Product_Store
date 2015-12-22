$(document).ready ->
  baseUrl = 'http://devpoint-ajax-example-server.herokuapp.com/api/v1/products'

  addProductToList = (id, name, base_price = null, description = null, quantity_on_hand = null, color = null, weight = null) ->
    $.ajax '/product_template', 
      type: 'GET',
      data:
        id: id
        name: name
        base_price: base_price
        description: description
        quantity_on_hand: quantity_on_hand
        color: color
        weight: weight
      dataType: 'HTML'
      success: (data) ->
        $('#product_list').append(data)
      error: (data) ->
        console.log(data)

  loadList = ->
    $("#product_list").children().remove()
    $.ajax "#{baseUrl}",
      type: 'GET',
      success: (data) ->
        if data.products.length
          for product in data.products
            addProductToList product.id, product.name, product.base_price, product.description, product.quantity_on_hand, product.color, product.weight
        else
          $('#message_div').text("No products found. Please add on!").slideToggle()
      error: (data) ->
        alert('oops')

  loadList()

  $(document).on 'click','.product', (e) ->
    e.preventDefault()
    productId = $(@).attr('href')
    $.ajax "#{baseUrl}/#{productId}",
      type: 'GET'
      success: (data) ->
        $('#product_list').toggleClass('hidden')
        $('#product_view').toggleClass('hidden')
        $('#create_product_form').toggleClass('hidden')
        product = data.product
        $('#product_name').text("#{product.name}")
        $('#product_base_price').text("#{product.base_price}")
        $('#product_description').text("#{product.description}")
        $('#product_quantity_on_hand').text("#{product.quantity_on_hand}")
        $('#product_color').text("#{product.color}")
        $('#product_weight').text("#{product.weight}")
        $('#edit_product_name').val("#{product.name}")
        $('#edit_product_base_price').val("#{product.base_price}")
        $('#edit_product_description').val("#{product.description}")
        $('#edit_product_quantity_on_hand').val("#{product.quantity_on_hand}")
        $('#edit_product_color').val("#{product.color}")
        $('#edit_product_weight').val("#{product.weight}")

      error: (data) ->
        console.log(data)

  $(document).on 'click','.back_to_product_list', (e) ->
    e.preventDefault()
    $('#product_list').toggleClass('hidden')
    $('#product_view').toggleClass('hidden')
    $('#create_product_form').toggleClass('hidden')



  $(document).on 'click', '.product_edit', (e) ->
    e.preventDefault()
    $('#edit_product_form').toggleClass('hidden')

  $('#create_product_form').on 'submit', (e) ->
    e.preventDefault()
    $.ajax "#{baseUrl}",
      type: 'POST'
      data: $(@).serializeArray()
      success: (data) ->
        $('#product_list').append(addProductToList(data.product.id, data.product.name, data.product.base_price, data.product.description, data.product.quantity_on_hand, data.product.color, data.product.weight))
        $('#create_product_form')[0].reset()
      error: (data) ->
        console.log(data)






