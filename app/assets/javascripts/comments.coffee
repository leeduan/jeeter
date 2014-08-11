$commentFormEl = null

handleReplyPlacement = ->
  $('.main-col').on 'click', '.reply-form', (e) ->
    e.preventDefault()
    $commentEl = $(this).closest '.comment'
    $commentFormEl
      .appendTo $commentEl
      .find('#comment_parent_id').val $commentEl.attr 'data-id'
    removeFormErrors()
    resetFormFields()
    renderCancelReply()
    scrollTo $commentFormEl

handleCancelPlacement = ->
  $commentFormEl.on 'click', '.reply-cancel', (e) ->
    e.preventDefault()
    renderFormTop()

handleFormSubmit = ->
  $commentFormEl.submit (e) ->
    e.preventDefault()
    removeFormErrors()
    $.ajax
      url: $commentFormEl.attr 'action'
      type: 'POST'
      data: $commentFormEl.serialize()
      success: (response) ->
        template = response.comment_template
        renderNewComment template
        renderFormTop()
      error: (response) ->
        prefixSel = 'comment_';
        response = response.responseJSON
        $.each response, (field, arr) ->
          renderFormErrors($('#' + prefixSel + field), arr[0])

removeCancelReply = ->
  $commentFormEl.find('.reply-cancel').remove()

removeFormErrors = ->
  $commentFormEl.find('.text-danger').remove()
  $commentFormEl.find('.has-error').removeClass 'has-error'
  $('.alert').remove()

renderCancelReply = ->
  unless $commentFormEl.find('.reply-cancel').length
    $commentFormEl.find('h4').first().append '<a class="small reply-cancel" href="#">Cancel Reply</a>'

renderFormErrors = ($inputEl, message) ->
  $inputEl.after '<p class="text-danger">' + message + '</p>'
  $inputEl.closest('.form-group').addClass 'has-error'

renderFormTop = ->
  $commentFormEl
    .insertBefore $('.post-comments').first()
    .find('#comment_parent_id').val ''
  resetFormFields()
  removeCancelReply()

renderNewComment = (template) ->
  $commentEl = $commentFormEl.closest '.comment'
  nestedTemplate = '<div class="comment-nested"></div>'
  $commentNewEl = $commentFormEl

  if $commentEl.length
    $commentNestedEl = $commentEl.next '.comment-nested'
    $commentNestedEl.append template
    $commentNewEl = $commentNestedEl.children().last()
    $commentNewEl.prepend templateAlert('New comment created.', 'success')
    $commentNestedEl.append nestedTemplate
  else
    $commentsContainerEl = $ '.post-comments'
    $commentsContainerEl.append template
    $commentsContainerEl.append nestedTemplate
    $commentFormEl.find('h4').first().after templateAlert('New comment created.', 'success')
  scrollTo $commentNewEl

resetFormFields = ->
  $commentFormEl.find('input[type=text], input[type=email], textarea').val ''

scrollTo = ($element) ->
  $('html, body').animate
    scrollTop: $element.offset().top,
    500

templateAlert = (message, type) ->
  [
    "<div class=\"alert alert-#{type}\">"
      "<a class=\"close\" data-dismiss=\"alert\">&#215;</a>"
      "<div>#{message}</div>"
    "</div>"
  ].join ''

$(document).on 'page:change', ->
  return unless ($commentFormEl = $ '#new_comment').length
  handleReplyPlacement()
  handleCancelPlacement()
  handleFormSubmit()