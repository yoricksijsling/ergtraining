class Interval
  include MongoMapper::EmbeddedDocument
  embedded_in :member_workout
  key :pace, Float
  key :hravg, Integer
  key :hrmax, Integer
  key :tempoavg, Integer
end