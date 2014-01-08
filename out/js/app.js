(function($){

	$('.gallery-list').magnificPopup({
		delegate: 'a',
		gallery: {enabled: true},
		type: 'image'
	});

	var cok = 'cookieOkay';
	var i = document.cookie.indexOf(cok+'=');
	if (i >= 0) {
		var cln = cok.length;
		window[cok] = document.cookie.substring(i + cln + 1, i + cln + 2) == 1;
	} else {
		// insert cookie bar
		var d = $('<div />', {text: 'Sorry to bother you about this, but I would like to use cookies to gather some basic usage statistics. Is that okay with you?', id: 'cookie-banner'});
		var okayButton = $('<a>', {href: '#', text: 'Sure', 'class': 'btn btn-primary'}).on('click', function(e) {
			e.preventDefault();
			allowCookies(true);
			d.remove();
		});
		var nopeButton = $('<a>', {href: '#', text: 'Please Don\'t'}).on('click', function(e) {
			e.preventDefault();
			allowCookies(false);
			d.remove();
		});
		d.append(okayButton);
		d.append(nopeButton);
		d.prependTo($('#wrapper'));
	}

	function allowCookies(okay) {
		window[cok] = !!okay;
		var d = new Date();
		d.setDate(d.getDate() + 356);
		document.cookie = cok + '=' + (okay ? '1' : '0') + '; expires=' + d.toUTCString();
    if (okay && typeof window.fireGa == 'function') {
        window.fireGa()
    }
	}

})(jQuery);