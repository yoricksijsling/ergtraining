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
    # self.member_workouts.select{ |mw| mw.member == member }.first
    MemberWorkout.first :member_id => member._id, :workout_id => self._id
  end
  
  def get_or_create_for(member)
    self.get_for(member) || MemberWorkout.create(:member => member, :workout => self)
  end
  
  # accepts_nested_attributes_for
  def member_workouts_attributes=(attributes)
    attributes.each do |key, sub|
      MemberWorkout.find(key).update_attributes(sub)
    end
  end
  
  def to_bson
    self._id
  end
end
