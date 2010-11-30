class MemberWorkout
  include MongoMapper::Document
  belongs_to :workout
  
  many :intervals
    
  def initialize params
    super params
    if self.intervals.length == 0
      self.workout.number_of_intervals.times { self.intervals << Interval.new }
    end
  end
  
  def member # Moet via team omdat member een EmbeddedDocument is
    self.workout.team.members.select { |m| m.member_workouts.include? self }.first
  end
  def member=(member)
    # Maybe check they are the same team?
    member.member_workouts << self if self.workout.team == member.team
  end
  
  # accepts_nested_attributes_for
  def intervals_attributes=(attributes)
    attributes.each do |key, sub|
      self.intervals[key.to_i].update_attributes(sub)
    end
  end
end