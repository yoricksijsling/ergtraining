class Team
  include MongoMapper::Document
  
  key :title, String
  
  many :members
  
end