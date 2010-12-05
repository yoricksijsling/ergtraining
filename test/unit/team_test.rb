require 'test_helper'

class TeamTest < ActiveSupport::TestCase
  
  setup do
    clear
  end
  
  context "A saved team" do
    setup do
      @yorick = Member.new :name => "Yorick"
      @henk = Member.new :name => "Henk"
      @team = Team.create :title => "TJL", :members => [@yorick, @henk]
    end
    
    should "get member" do
      assert_equal @yorick, @team.get_member(@yorick._id)
    end
  end

end