class Workout
  include MongoMapper::Document
  belongs_to :team
  key :title, String
  key :date, Date, :default => Date.today
  many :member_workouts
  
  def workout_config
    multipliers = @title.scan(/(\d*)x/).flatten.map{ |m| m.to_i }
    { :intervals => multipliers.pop || 1, :repeats => multipliers.pop || 1 }
  end
  
  def number_of_intervals_per_repeat
    self.workout_config[:intervals]
  end
  
  def number_of_repeats
    self.workout_config[:repeats]
  end
  
  def number_of_intervals
    config = self.workout_config
    config[:intervals] * config[:repeats]
  end

  def get_for(member)
    MemberWorkout.first :member_id => member._id, :workout_id => self._id
  end
  
  def get_or_new_for(member)
    self.get_for(member) || MemberWorkout.new(:member => member, :workout_id => self._id)
  end
  
  def for_member_attributes=(attributes)
    attributes.each do |member_id, sub|
      # mw = MemberWorkout.find key || self.get_or_new_for
      mw = self.get_or_new_for self.team.get_member(BSON::ObjectId.from_string(member_id))
      mw.ensure_enough_intervals.update_attributes(sub) if mw
    end
  end
  
end
