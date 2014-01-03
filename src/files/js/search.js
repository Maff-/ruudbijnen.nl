(function ($) {
  var $input = $('#search-input');
  var $search = $('#search');
  var $navItem = $('#search-nav-item');

  $('#search-nav-link').on('click', function (e) {
    if ($search.hasClass('in')) e.preventDefault();
    $search.collapse('toggle');
  });

  $('a[href="#search"]').on('click', function (e) {
    //e.preventDefault();
    $search.collapse('show');
    $input.trigger('search.focus');
  });

  $input.on('search.focus', function () {
    $input.attr('autofocus', 'autofocus');
    $input.focus();
  });

  $input.on('search.blur', function () {
    $input.removeAttr('autofocus');
    $input.blur();
  });

  $search.on('show.bs.collapse', function () {
    $input.trigger('search.focus');
    $navItem.addClass('active');
  });

  $search.on('hide.bs.collapse', function () {
    $input.trigger('search.blur');
    $navItem.removeClass('active');
  });

  if (window.location.hash.indexOf('stq=') >= 0) {
    $search.collapse('show');
  }
})(jQuery);

var Swiftype = window.Swiftype || {};
(function () {
  Swiftype.key = 'utdvEWfiyh1Hf6pcuMBz';
  Swiftype.inputElement = '#search-input';
  Swiftype.resultContainingElement = '#search-results';
  Swiftype.attachElement = '#search';
  Swiftype.renderStyle = 'inline';

  var script = document.createElement('script');
  script.type = 'text/javascript';
  script.async = true;
  script.src = "//swiftype.com/embed.js";
  var entry = document.getElementsByTagName('script')[0];
  entry.parentNode.insertBefore(script, entry);
}());