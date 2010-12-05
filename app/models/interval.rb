class Interval
  include MongoMapper::EmbeddedDocument
  embedded_in :member_workout
  key :pace, Float # add a class for Pace
  key :hravg, Integer
  key :hrmax, Integer
  key :tempoavg, Integer
end