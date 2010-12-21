class Pace
  attr_accessor :as_float
  
  def self.parse(string)
    m = /(\d)+:(\d\d)(\.\d)?/.match string
    return nil if m.nil?
    p = Pace.new
    p.as_float = m[1].to_f*60 + m[2].to_f + m[3].to_f
    p
  end
  
  def self.to_s(pace)
    pace_to_f = pace.to_f
    pace.nil? ? nil : "%d:%02d.%1d" % [(pace_to_f/60).to_i, pace_to_f%60, pace_to_f%1*10]
  end
  def to_f
    self.as_float
  end
end