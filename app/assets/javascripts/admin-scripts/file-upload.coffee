$formEl = null;

handleFileUpload = ->
  $formEl.fileupload
    url: $formEl.attr 'action'
    dataType: 'json'
    autoUpload: true
    maxFileSize: 5000000
    previewMaxWidth: 100
    previewMaxHeight: 100
    previewCrop: true
  .on 'fileuploadadd', (e, data) ->
    return
  .on 'fileuploadprocessalways', (e, data) ->
    return
  .on 'fileuploadprogressall', (e, data) ->
    return
  .on 'fileuploaddone', (e, data) ->
    return
  .on 'fileuploadfail', (e, data) ->
    return

$(document).on 'page:change', ->
  return unless ($formEl = $ '#fileupload').length
  $formEl.on 'click', (e) ->
    e.preventDefault()
  handleFileUpload()