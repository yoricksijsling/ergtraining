class Interval
  include MongoMapper::EmbeddedDocument
  embedded_in :member_workout
  key :pace, Float # add a class for Pace
  key :hravg, Integer
  key :hrmax, Integer
  key :tempoavg, Integer
  
  def pace=(pace)
    self.write_attribute :pace, pace == "" ? nil : pace
  end
  
  def contains_data
    self.attributes.except("_id").values.any?
  end
end