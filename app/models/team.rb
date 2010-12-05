class Team
  include MongoMapper::Document
  key :title, String
  many :members
  many :workouts
  
  def get_member(member_id)
    self.members.select{ |m| m._id == member_id}.first
  end
  
end