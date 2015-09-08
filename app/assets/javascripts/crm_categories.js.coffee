(($) ->

  # init
  $(document).on 'focus', "[name='account[category]']", (event) ->
    $(this).data("previous", $(this).val())

  # every time we update the category
  $(document).on 'change', "[name='account[category]']", (event) ->
    new_value = $(this).val()
    old_value = $(this).data("previous")
    console.log 'change from', old_value, 'to', new_value

    # remove old section(s)
    $("#field_groups div[data-category='" + old_value + "']").remove()

    # add new section(s)
    url      = $(this).data('url')
    asset_id = $(this).data('asset-id')
    $.get(url, {
      category: new_value
      asset_id: asset_id
      collapsed: "no"
    })

    # remember the change
    $(this).data("previous", $(this).val())

) jQuery