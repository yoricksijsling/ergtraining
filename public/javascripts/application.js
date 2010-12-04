
window.addEvent('domready', function() {
	var app = new Application();
	app.applyEvents();
});




var Application = new Class({
	
	initialize: function() {
		
	},
	
	applyEvents: function() {
		document.addEvent('click:relay(.add_member_workout)', function(event, el) {
			mw = el.getParent('.member_workout');
			new Request.HTML({
				url: mw.get('data-ajaxurl'),
				update: mw,
				onSuccess: function() {
					mw.getElement('input').focus();
				}
			}).get();
		});
	}
		
});