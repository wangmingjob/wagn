require File.dirname(__FILE__) + '/../../test_helper'

class DiscussionDatatypeTest < Test::Unit::TestCase
  def setup
    @tag = Tag.new( :name=>'datatype_tester',:datatype_key=>"Discussion" )
    @card = Card::Basic.new( :tag=>@tag )
    @datatype = @tag.datatype
  end
  
  # Replace this with your real tests.
  def test_render
    # test me!!
  end
end
