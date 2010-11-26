class MemberWorkout
  include MongoMapper::Document
  
  many :intervals
  
end