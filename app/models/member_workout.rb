class MemberWorkout
  include MongoMapper::Document
  belongs_to :workout
  belongs_to :member
  
  many :intervals
  
  def ensure_enough_intervals
    if self.intervals.length == 0
      self.workout.number_of_intervals.times { self.intervals << Interval.new }
    end
  end
  
  def member # Moet via team omdat member een EmbeddedDocument is
    self.workout.team.members.select { |m| m.member_workouts.include? self }.first
  end
  def member=(member)
    member.member_workouts << self unless self.workout && (self.workout.team != member.team)
  end
  
  # accepts_nested_attributes_for
  def intervals_attributes=(attributes)
    attributes.each do |key, sub|
      self.intervals[key.to_i].update_attributes(sub)
    end
  end
end