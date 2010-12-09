class MemberWorkout
  include MongoMapper::Document
  belongs_to :workout
  belongs_to :member
  
  many :intervals
  
  # before_save :should_contain_data
  
  def ensure_enough_intervals
    if self.intervals.length == 0
      self.workout.number_of_intervals.times { self.intervals << Interval.new }
    end
    self
  end
  
  def create(*args)
    self.contains_data ? super : false
  end
  def update(*args)
    self.contains_data ? super : (self.destroy && false)
  end
  
  def contains_data
    # false
    self.intervals.map{ |i| i.contains_data }.any?
  end
  
  def member # Moet via team omdat member een EmbeddedDocument is
    self.workout.team.get_member self.member_id
  end
  def member=(member)
    member.member_workouts << self # unless self.workout && (self.workout.team != member.team) && Logger.new(STDOUT).info(self.workout.team) && Logger.new(STDOUT).info(member.team)
  end
  
  # accepts_nested_attributes_for
  def intervals_attributes=(attributes)
    attributes.each do |key, sub|
      self.intervals[key.to_i].update_attributes(sub)
    end
  end
end