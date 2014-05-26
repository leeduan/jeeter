(function($) {
  var formEl = $('.admin-post-form');
  if (!formEl.length) return;

  var categoryListEl = $('#categories-list');
  var inputStatusEl = $('#post_publish_status');

  var createNewCategory = function(el) {
    el = $(el);

    $.ajax({
      type: 'POST',
      url: el.attr('href'),
      data: {
        category: {
          name: $('#add-new-category-container input[type=text]').val()
        }
      },
      success: function(response) {
        renderNewCategory(response);
      },
      error: function(response) {
        var errorMessage = JSON.parse(response.responseText);
        renderError(errorMessage);
      }
    });
  };

  var handleFormSubmission = function() {
    formEl.find('input[type=submit]').on('click', function(e) {
      var el = $(this);
      if (el.val() === 'Publish') inputStatusEl.val(true);
    });
  };

  var handleDropdowns = function() {
    $('#add-new-category-dropdown').on('click', function(e) {
      e.preventDefault();
      $('#add-new-category-container').slideDown();
    });
  };

  var handleAddNewCategory = function() {
    $('#add-new-category-submit').on('click', function(e) {
      e.preventDefault();
      createNewCategory(this);
    });
  };

  var renderError = function(error) {
    var alertEl = categoryListEl.find('.alert');
    var template = templateError(error);

    if (alertEl.length) {
      alertEl.replaceWith(template);
    } else {
      categoryListEl.append(template);
    }
  };

  var renderNewCategory = function(category) {
    var categories = categoryListEl.find('label.checkbox');
    var count = categories.count;
    var template = templateCategory(category.name, category.id);

    if (count > 0) {
      categoryListEl.prepend(template);
    } else {
      categories.last().after(template);
    }
  };

  var templateCategory = function(name, id) {
    return [
      '<label class="checkbox" for="post_category_ids_'+id+'">',
        '<input class="checkbox" id="post_category_ids_'+id+'"',
          'name="post[category_ids][]" type="checkbox" value="'+id+'">',
        name,
      '</label>'
    ].join('');
  };

  var templateError = function(error) {
    return [
      '<div class="alert alert-danger">',
        '<a class="close" data-dismiss="alert">&#215;</a>',
        '<div>' + error.name + '</div>',
      '</div>'
    ].join('');
  };

  handleFormSubmission();
  handleDropdowns();
  handleAddNewCategory();
})(jQuery);
