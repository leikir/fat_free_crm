(($) ->

  # init
  $(document).on 'focus', "[name='account[category]']", (event) ->
    $(this).data("previous", $(this).val())

  # every time we update the category
  $(document).on 'change', "[name='account[category]']", (event) ->
    new_value = $(this).val()
    old_value = $(this).data("previous")

    # remove old section(s) if old category is not "other"
    if old_value != ""
      $("#field_groups div[data-category='" + old_value + "']").remove()

    # add new section(s) if new category is not "other"
    if new_value != ""
      url      = $(this).data('url')
      asset_id = $(this).data('asset-id')
      $.get(url, {
        tag: $(this).closest("form").find("[name='account[tag_list]']").val()
        fromCat: true
        category: new_value
        asset_id: asset_id
        collapsed: "no"
      })

    # remember the change
    $(this).data("previous", $(this).val())

) jQuery