$(document).ready ->
  window.galleryProductTemplate = Handlebars.compile($('#gallery_product_template').text());
  $('#gallery_products').sortable({
    handle: ".js-sort-handle"
  });

  $('#gallery_products').on "sortstop", (event, ui) ->
    $.ajax
      url: $(this).data('items-route'),
      method: 'PUT',
      dataType: 'json',
      data:
        token: Spree.api_key,
        product_id: ui.item.data('product-id'),
        gallery_id: $('#gallery_id').val(),
        position: ui.item.index()

  if $('#gallery_products').length > 0
    el = $('#gallery_products')
    $.ajax
      url: el.data('products-route'),
      data:
        id: $('#gallery_id').val(),
        token: Spree.api_key
      success: (data) ->
        el.empty()
        if data.products.length == 0
          $('#gallery_items').html("<div class='alert alert-info'>" + Spree.translations.no_results + "</div>")
        else
          for product in data.products
            if product.master.images[0] != undefined && product.master.images[0].medium_url != undefined
              product.image = product.master.images[0].medium_url
            else
              for variant in product.variants
                if variant.images[0] != undefined && variant.images[0].medium_url != undefined
                  product.image = variant.images[0].medium_url
                  break
            el.append(galleryProductTemplate({product: product}))

  $('#add_product').on "click", (e) ->
    search_el = $("#search_product")
    data = search_el.select2("data");
    route = $(this).data('route');
    if data
      product_id = data['id']
      current_gallery_id = $("#gallery_id").val()
      $.ajax
        url: route
        data:
          product_id: product_id
          gallery_id: current_gallery_id
          token: Spree.api_key
        method: "POST",
        success: (data) ->
          el.append(galleryProductTemplate({product: data.product}))

  $('#gallery_products').on "click", ".js-delete-product", (e) ->
    current_gallery_id = $("#gallery_id").val()
    product = $(this).parents(".product")
    product_id = product.data("product-id")

    $.ajax
      url: $(this).data('route'),
      data:
        gallery_id: current_gallery_id,
        product_id: product_id,
        token: Spree.api_key
      method: "DELETE"
      success: (data, textStatus, jqXHR) ->
        product.fadeOut 400, (e) ->
          product.remove()

  $('#search_product').productAutocomplete({multiple: false})