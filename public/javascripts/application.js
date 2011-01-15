
window.addEvent('domready', function() {
	var app = new Application();
	app.applyEvents();
});

Event.definePseudo('onPause', function(split, fn, args){
  clearTimeout(fn.onPauseId);
  fn.onPauseId = fn.delay(split.value, this, args);
});

var Application = new Class({
	
	initialize: function() {
	},
	
	applyEvents: function() {
		
		$('body').addEvent('keydown:keys(a)', function(event) {
			if (event.target == $('body')) {
				this.addWorkout()
			}
		}.bind(this));
		
		$('right_pane').addEvent('click:relay(.show_member_workout)', function(event, el) {
			var target = el.getParent('.member_workout').getElement('.content');
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
		
		if ($('new_workout')) {
			$('new_workout').getElement('#workout_title')
				.addEvent('keyup:onPause(500)', function(event) {
					var previewDiv = event.target.getParent('.field').getElement('.workout_config_preview');
					new Request.HTML({
						url: event.target.get('data-workout_config_url'),
						update: previewDiv,
						onSuccess: function() {
							previewDiv.highlight();
						}					
					}).get({
						title: event.target.get('value')
					});
				})
				.focus();
		}
		
	},
	
	addWorkout: function() {
		document.location = $('new_workout_link').get('href');
	}
		
});

