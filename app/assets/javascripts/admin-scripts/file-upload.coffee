$formEl = null;
$uploadTableEl = null;
$uploadTableBodyEl = null;

handleFileUpload = ->
  $formEl.fileupload
    url: $formEl.attr 'action'
    dataType: 'json'
    add: (e, data) ->
      $uploadTableEl.addClass 'active' unless $uploadTableEl.hasClass 'active'
      fileData = data.files[0]
      data.context = $('<tr/>').html renderFileUpload(fileData)
      data.context.appendTo $uploadTableBodyEl
      data.submit();
    progress: (e, data) ->
      progress = parseInt(data.loaded / data.total * 100, 10);
      data.context.find('.progress-bar')
        .attr('aria-valuenow', progress)
        .css('width', "#{progress}%")
        .text("#{progress}%")
    done: (e, data) ->
      data.context.find('.progress-bar')
        .attr('aria-valuenow', 100)
        .css('width', "100%")
        .text("100%")
      data.context.find('.uploadFileStatus').text 'Complete'
    fail: (e, data) ->
      failureText = if (data.loaded is data.total) then 'Invalid File Type' else 'Failed'
      data.context.find('.progress-bar')
        .addClass('progress-bar-danger')
      data.context.find('.uploadFileStatus')
        .css('color', '#d9534f')
        .text(failureText)

renderFileUpload = (fileData) ->
  [
    "<td class=\"uploadFileName\">#{fileData.name}</td>",
    "<td class=\"uploadFileType\">#{fileData.type}</td>",
    "<td class=\"uploadFileStatus\">Uploading</td>",
    "<td class=\"uploadFileProgress\">",
      "<div class=\"progress\">",
        "<div class=\"progress-bar\" role=\"progressbar\" aria-valuenow=\"0\"",
          " aria-valuemin=\"0\" aria-valuemax=\"100\" style=\"width: 0%;\">",
          "0%",
        "</div>",
      "</div>",
    "</td>"
  ].join ''

$(document).on 'page:change', ->
  return unless ($formEl = $ '#fileupload').length
  $uploadTableEl = $ '#drag-upload-files'
  $uploadTableBodyEl = $uploadTableEl.find 'tbody'
  $formEl.on 'click', (e) ->
    e.preventDefault()
  handleFileUpload()
