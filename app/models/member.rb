class Member
  include MongoMapper::EmbeddedDocument
  embedded_in :team
  key :name, String
  many :member_workouts
  
end