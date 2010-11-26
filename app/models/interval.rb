class Interval
  include MongoMapper::EmbeddedDocument
  
  key :pace, Float
  key :hravg, Integer
  key :hrmax, Integer
  key :tempoavg, Integer
  
end