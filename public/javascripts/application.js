
window.addEvent('domready', function() {
	var app = new Application();
	app.applyEvents();
});

var Application = new Class({
	
	initialize: function() {
	},
	
	applyEvents: function() {
		$('right_pane').addEvent('click:relay(.show_member_workout)', function(event, el) {
			target = el.getParent('.member_workout').getElement('.content');
			new Request.HTML({
				url: target.get('data-ajaxurl'),
				update: target,
				onSuccess: function() {
					el.addEvent('click:once', function(event) {
						el.getParent('.member_workout').getElement('.content').set('html', '');
						event.stop();
					});
				}
			}).get();
		});
	}
		
});

