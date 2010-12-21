class Interval
  include MongoMapper::EmbeddedDocument
  embedded_in :member_workout
  key :pace_as_float, Float
  key :hravg, Integer
  key :hrmax, Integer
  key :tempoavg, Integer
    
  def pace=(pace)
    self.pace_as_float = Pace.parse(pace)
  end
  def pace
    self.pace_as_float.nil? ? nil : Pace.to_s(self.pace_as_float)
  end
  
  def contains_data
    self.attributes.except("_id").values.any?
  end
end