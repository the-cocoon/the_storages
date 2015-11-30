@TheStoragesFileUploader = do ->
  init: ->
    @inited ||= do ->
      $(document).on 'ajax:success', '.the-storages--delete-attachment', (xhr, data, status) ->
        JODY.processor(data)

    $('@the-storages--multiple-upload-input').fileupload
      type:      'POST'
      dataType:  'JSON'
      paramName: 'file'
      dropZone: $('@the-storages--drug-and-drop-files')

      add: (e, uploader) ->
        uploader.submit()

      done: (e, uploader) ->
        data = uploader.result
        JODY.processor(data)

      fail: (e, uploader) ->
        [ xhr, response, status ] = [ null, uploader.jqXHR, uploader.textStatus ]
        JODY.error_processor(xhr, response, status)

      progressall: (e, data) ->
        progress = parseInt data.loaded / data.total * 100, 10
        holder   = $('.the-storages--uploading-percent')

        if progress < 100
          size = "#{ progress }%"
          holder.html size
        else
          holder.html ''