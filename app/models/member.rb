class Member
  include MongoMapper::EmbeddedDocument
  embedded_in :team
  key :name, String
  many :member_workouts

  def to_param
    self._id.to_s
  end
end