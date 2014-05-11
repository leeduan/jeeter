(function($) {
  var sidebarEl = $('.admin-menu');
  var dropdownEls = sidebarEl.find('.dropdown-toggle');

  var handleDropdownClick = function(e) {
    var el = $(e.target);
    el.parent().addClass('open');
  };

  var handleBodyClick = function(e) {
    var el = $(e.target);
    cancelDropdown();

    if (el.closest('.admin-menu').length) {
      if (el.hasClass('dropdown-toggle')) {
        handleDropdownClick(e);
      }
    }
  };

  var cancelDropdown = function() {
    sidebarEl.find('.open').removeClass('open');
  };

  // dropdownEls.on('click', handleDropdownClick);
  $(document.body).on('click', handleBodyClick);
})(jQuery);