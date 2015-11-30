@TheStoragesFileUploader = do ->
  init: ->
    log 'INIT!'

    $('@the-storages--multiple-upload-input').fileupload
      type:      'POST'
      dataType:  'JSON'
      paramName: 'file'
      dropZone: $('@the-storages--drug-and-drop-files')

      add: (e, uploader) ->
        uploader.submit()

      done: (e, uploader) ->
        data = uploader.result
        # JODY.processor(data)

      fail: (e, uploader) ->
        [ xhr, response, status ] = [ null, uploader.jqXHR, uploader.textStatus ]
        # JODY.error_processor(xhr, response, status)
        log response

      progressall: (e, data) ->
        progress = parseInt data.loaded / data.total * 100, 10
        # progress_bar   = $('@files-uploading-progress-bar')
        log progress

        # if progress < 100
        #   size = "#{ progress }%"
        #   progress_bar.show()
        #   progress_bar.css { width: size }
        # else
        #   progress_bar.hide()
        #   progress_bar.css { width: '1%' }