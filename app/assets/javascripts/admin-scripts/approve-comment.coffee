$anchorEls = null

handleApproving = ->
  $anchorEls.on 'click', (e) ->
    e.preventDefault()
    el = $ this
    approvedStatus = el.attr('data-approved') is "true"

    $.ajax
      type: 'POST'
      url: el.attr 'href'
      data:
        id: el.attr 'data-id'
        approved: approvedStatus
      success: (response) ->
        if approvedStatus
          el.closest('tr').removeClass 'warning'
          el.text 'Unapprove'
          el.attr('data-approved', false)
        else
          el.closest('tr').addClass 'warning'
          el.text 'Approve'
          el.attr('data-approved', true)
      error: (response) ->
        window.location = response.responseJSON.url

$(document).on 'page:change', ->
  return unless ($anchorEls = $ 'a[data-approved]').length
  handleApproving()