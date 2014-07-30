$commentFormEl = null

handleReplyPlacement = ->
  $('.reply-form').on 'click', (e) ->
    e.preventDefault()
    $commentEl = $(this).closest '.comment'
    $commentFormEl
      .appendTo $commentEl
      .find('#comment_parent_id').val $commentEl.attr('data-id')
    renderCancelReply()

handleCancelPlacement = ->
  $commentFormEl.on 'click', '.reply-cancel', (e) ->
    e.preventDefault()
    $commentFormEl
      .insertBefore $('.post-comments').first()
      .find('#comment_parent_id').val ''
    removeCancelReply()

renderCancelReply = ->
  unless $commentFormEl.find('.reply-cancel').length
    $commentFormEl.find('h4').first().append '<a class="small reply-cancel" href="#">Cancel Reply</a>'

removeCancelReply = ->
  $commentFormEl.find('.reply-cancel').remove()

$(document).on 'page:change', ->
  return unless ($commentFormEl = $ '#new_comment').length
  handleReplyPlacement()
  handleCancelPlacement()