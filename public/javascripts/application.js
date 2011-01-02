
window.addEvent('domready', function() {
	var app = new Application();
	app.applyEvents();
});


var AjaxToggler = new Class({
	Implements: [Options],

	options: {
		target: null
	},

	initialize: function(element, options) {
		this.element = $(element);
		this.setOptions(options);
	}

//	toggle: function() {
//		this.element.
//	}	
});


var Application = new Class({
	
	initialize: function() {
		
	},
	
	applyEvents: function() {
		document.addEvent('click:relay(.show_member_workout)', function(event, el) {
			target = el.getParent('.member_workout').getElement('.content');
			new Request.HTML({
				url: target.get('data-ajaxurl'),
				update: target,
				onSuccess: function() {
					// target.getElement('input').focus();
					el.addEvent('click:once', function(event) {
						el.getParent('.member_workout').getElement('.content').set('html', '');
						event.stop();
					});
				}
			}).get();
		});
	}
		
});

