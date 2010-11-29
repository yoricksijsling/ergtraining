class Member
  include MongoMapper::EmbeddedDocument
  
  key :name, String
  
  many :member_workouts
  belongs_to :team
  
end