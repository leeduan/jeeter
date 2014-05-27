(function($) {
  var formEl = $('.admin-post-form');
  if (!formEl.length) return;

  var categoryListEl = $('#categories-list');
  var tagListEl = $('#tags-list');
  var tagLabelsListEl = $('#labels-list');
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
        renderError(response.responseJSON, categoryListEl);
      }
    });
  };

  var createNewTags = function(el) {
    var inputEl = $('#add-new-tags-input');
    el = $(el);

    $.ajax({
      type: 'POST',
      url: el.attr('href'),
      data: {
        new_tag: inputEl.val()
      },
      success: function(response) {
        renderNewTags(response);
      },
      error: function(response) {
        renderError(response.responseJSON, tagListEl);
      }
    });

    inputEl.val('');
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

  var handleAddNewTags = function() {
    $('#add-new-tags-submit').on('click', function(e) {
      e.preventDefault();
      createNewTags(this);
    });
  };

  var renderError = function(error, el) {
    var alertEl = el.find('.alert');
    var template = templateError(error);

    if (alertEl.length) {
      alertEl.replaceWith(template);
    } else {
      el.append(template);
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

  var renderNewTags = function(tagsArray) {
    var tagsFormListEl = $('#tags-input-list');

    $.each(tagsArray, function(i, tag) {
      tagLabelsListEl.append(templateTag(tag.name));
      tagsFormListEl.append(templateTagInput(tag.id));
    });
  };

  var templateCategory = function(name, id) {
    return [
      '<label class="checkbox" for="post_category_ids_' + id + '">',
        '<input class="checkbox" id="post_category_ids_' + id + '"',
          'name="post[category_ids][]" type="checkbox" value="' + id + '">',
        name,
      '</label>'
    ].join('');
  };

  var templateTag = function(name) {
    return '<div class="label label-default">' + name + '</div>';
  };

  var templateTagInput = function(id) {
    return '<input multiple="multiple" name="post[tag_ids][]" type="hidden" value="' + id + '">';
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
  handleAddNewTags();
})(jQuery);
