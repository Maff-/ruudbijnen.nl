(function ($) {

  $(document).on('click.rb.class.data-api', '[data-toggle=class]', function (e) {
    var $this   = $(this), href;
    var target  = $this.attr('data-target')
      || e.preventDefault()
      || (href = $this.attr('href')) && href.replace(/.*(?=#[^\s]+$)/, ''); //strip for ie7
    var $target = $(target);
    var className = $this.attr('data-value') || 'hidden';

    $target.toggleClass(className);
  })

})(window.jQuery);