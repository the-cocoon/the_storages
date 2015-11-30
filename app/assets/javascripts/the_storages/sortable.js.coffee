@TheStorgesSortable = do ->
  rebuild_sortable_tree: (rebuild_url, item_id, parent_id, prev_id, next_id) ->
    $.ajax
      type:     'POST'
      dataType: 'script'
      url:      rebuild_url
      data:
        id:        item_id
        parent_id: parent_id
        prev_id:   prev_id
        next_id:   next_id

      beforeSend: (xhr) ->
        $('.the-storages--handler').css { opacity: 0 }

      success: (data, status, xhr) ->
        $('.the-storages--handler').css { opacity: 1 }

      error: (xhr, status, error) ->
        log error

  init: ->
    sortable_tree = $('.the-storages--list')
    return false if sortable_tree.length is 0

    rebuild_url = sortable_tree.data('rebuild_url') || sortable_tree.data('rebuild-url')
    max_levels  = sortable_tree.data('max_levels')  || sortable_tree.data('max-levels')

    ############################################
    # Initialize Sortable Tree
    ############################################
    sortable_tree.nestedSortable
      # nested sortable plugin options
      tabSize:          25
      listType:       'ol'
      disableNesting: 'the-storages--no-nest'
      listClass:      'the-storages--nested-set'
      errorClass:     'the-storages--sortable-error'
      maxLevels:       max_levels

      # JQ sortable optopns

      placeholder:      'the-storages--placeholder'
      handle:           '.the-storages--handler'
      toleranceElement: '> div'

      items:            'li'
      helper:           'clone'
      tolerance:        'pointer'

      revert:           250
      opacity:          0.6
      forcePlaceholderSize: true

      # JQ sortable Callbacks
      #
      # create:     ->
      # start:      ->
      # activate:   ->
      # over:       ->
      # sort:       ->
      # change:     ->
      # sort:       ->
      # beforeStop: ->
      # # => AJAX
      # update:     ->
      # deactivate: ->
      # out:        ->
      # stop:       ->
      # receive:    ->
      # remove:     ->

    ############################################
    # Sortable Update Event
    ############################################
    sortable_tree.on "sortupdate", (event, ui) =>
      item      = ui.item
      attr_name = 'node-id'
      item_id   = item.data(attr_name)
      prev_id   = item.prev().data(attr_name)
      next_id   = item.next().data(attr_name)
      parent_id = item.parent().parent().data(attr_name)

      TheStorgesSortable.rebuild_sortable_tree(rebuild_url, item_id, parent_id, prev_id, next_id)

    true