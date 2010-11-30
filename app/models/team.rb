class Team
  include MongoMapper::Document
  key :title, String
  many :members
  many :workouts
  
end