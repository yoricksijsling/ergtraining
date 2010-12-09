require 'test_helper'

class IntervalTest < ActiveSupport::TestCase
  
  setup do
    clear
    @interval = Interval.new
  end
  
  context "contains_data" do
    should "return false when empty" do
      assert !@interval.contains_data
    end
    
    should "return false when values are set to empty strings" do
      @interval.update_attributes :hravg => "", :hrmax => "", :pace => "", :tempoavg => ""
      assert !@interval.contains_data
    end
    
    should "return true when hravg is set" do
      @interval.hravg = "123"
      assert @interval.contains_data
    end

    should "return true when hrmax is set" do
      @interval.hrmax = "123"
      assert @interval.contains_data
    end
    
    should "return true when pace is set" do
      @interval.pace = "123"
      assert @interval.contains_data
    end
    
  end
end
