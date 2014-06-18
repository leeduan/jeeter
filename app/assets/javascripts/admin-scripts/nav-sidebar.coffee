$sidebarEl = null

handleDropdownClick = (e) ->
  $(e.target).parent().addClass 'open'

handleBodyClick = (e) ->
  $el = $(e.target)
  $sidebarEl.find('.open').removeClass 'open'

  if $el.closest('.admin-menu').length and $el.hasClass 'dropdown-toggle'
    handleDropdownClick e

$(document).on 'page:change', ->
  $sidebarEl = $ '.admin-menu'
  $(document.body).on 'click', handleBodyClick
