$formEl = null
$categoryListEl = null
$tagListEl = null
$tagLabelsListEl = null
$inputStatusEl = null

createNewCategory = (el) ->
  $.ajax
    type: 'POST'
    url: el.attr 'href'
    data:
      category:
        name: $('#add-new-category-container input[type=text]').val()
    success: (response) ->
      renderNewCategory response
    error: (response) ->
      renderError response.responseJSON, $categoryListEl

createNewTags = (el) ->
  tagsInputEl = $ '#add-new-tags-input'
  return if tagsInputEl.val() is ''

  $.ajax
    type: 'POST'
    url: el.attr 'href'
    data:
      new_tag: tagsInputEl.val()
    success: (response) ->
      renderNewTags response
    error: (response) ->
      renderError response.responseJSON, $tagListEl

  tagsInputEl.val ''

handleAddNewCategory = ->
  $('#add-new-category-submit').on 'click', (e) ->
    e.preventDefault()
    createNewCategory $(@)

handleAddNewTags = ->
  $('#add-new-tags-submit').on 'click', (e) ->
    e.preventDefault()
    createNewTags $(@)

handleCkEditor = ->
  $('.ck-textarea').ckeditor()

handleDropdowns = ->
  $('#add-new-category-dropdown').on 'click', (e) ->
    e.preventDefault()
    $('#add-new-category-container').slideDown()

handleFormSubmission = ->
  $formEl.find('input[type=submit]').on 'click', (e) ->
    $inputStatusEl.val(true) if $(@).val() is 'Publish'

renderError = (error, $el) ->
  $alertEl = $el.find '.alert'
  template = templateError error

  if $alertEl.length then $alertEl.replaceWith template else $el.append template

renderNewCategory = (category) ->
  categories = $categoryListEl.find 'label.checkbox'
  count = categories.count
  template = templateCategory category.name, category.id

  if count > 0 then $categoryListEl.prepend template else categories.last().after template

renderNewTags = (tagsArray) ->
  $tagsFormListEl = $ '#tags-input-list'

  $.each tagsArray, (i, tag) ->
    $tagLabelsListEl.append templateTag(tag.name)
    $tagsFormListEl.append templateTagInput(tag.id)

templateCategory = (name, id) ->
  [
    "<label class=\"checkbox\" for=\"post_category_ids_#{id}\">"
      "<input class=\"checkbox\" id=\"post_category_ids_#{id}\""
      "name=\"post[category_ids][]\" type=\"checkbox\" value=\"#{id}\">"
      name
    "</label>"
  ].join ''

templateTag = (name) ->
  "<div class=\"label label-default\">#{name}</div>"

templateTagInput = (id) ->
  "<input multiple=\"multiple\" name=\"post[tag_ids][]\" type=\"hidden\" value=\"#{id}\">"

templateError = (error) ->
  [
    "<div class=\"alert alert-danger\">"
      "<a class=\"close\" data-dismiss=\"alert\">&#215;</a>"
      "<div>#{error.name}</div>"
    "</div>"
  ].join ''

$(document).on 'page:change', ->
  return unless ($formEl = $ '.admin-post-form').length
  $categoryListEl = $ '#categories-list'
  $tagListEl = $ '#tags-list'
  $tagLabelsListEl = $ '#labels-list'
  $inputStatusEl = $ '#post_publish_status'

  handleFormSubmission()
  handleDropdowns()
  handleAddNewCategory()
  handleAddNewTags()
  handleCkEditor()
