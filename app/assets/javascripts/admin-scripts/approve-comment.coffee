$anchorEls = null

handleApproving = ->
  $anchorEls.on 'click', (e) ->
    e.preventDefault()
    $aEl = $ this
    approvedStatus = $aEl.attr('data-approved') is "true"

    $.ajax
      type: 'POST'
      url: $aEl.attr 'href'
      data:
        id: $aEl.attr 'data-id'
        approved: approvedStatus
      success: (response) ->
        if approvedStatus
          $aEl.closest('tr').removeClass 'warning'
          $aEl.text 'Unapprove'
          $aEl.attr('data-approved', false)
        else
          $aEl.closest('tr').addClass 'warning'
          $aEl.text 'Approve'
          $aEl.attr('data-approved', true)
      error: (response) ->
        window.location = response.responseJSON.url

$(document).on 'page:change', ->
  return unless ($anchorEls = $ 'a[data-approved]').length
  handleApproving()