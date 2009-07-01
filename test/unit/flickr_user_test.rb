require 'test_helper'
#require './fixtures/flickr_user_factory'
require(File.join(RAILS_ROOT, 'test', 'fixtures', 'flickr_user_factory'))

class FlickrUserTest < ActiveSupport::TestCase
  def setup
    @flickr_user_fixture = FlickrUserFactory.CreatePopaEliasUser
  end
  
  test "do it return user by flickr ID 25376136@N08" do
    @flickr_user = FlickrUser.find_by_nsid(FLICKR_CONFIG[:user_id])
    assert_not_nil(@flickr_user)
    assert_equal(@flickr_user_fixture.id, @flickr_user.id)
    assert_equal(@flickr_user_fixture.username, @flickr_user.username)
  end
end
