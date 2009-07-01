require 'test_helper'
#require './fixtures/flickr_user_factory'
#require './fixtures/photoset_factory'
require(File.join(RAILS_ROOT, 'test', 'fixtures', 'flickr_user_factory'))
require(File.join(RAILS_ROOT, 'test', 'fixtures', 'photoset_factory'))

class PhotosetTest < ActiveSupport::TestCase
  def setup
    @flickr_user_fixture = FlickrUserFactory.CreatePopaEliasUser
    @photoset_fixture = PhotosetFactory.CreatePopaEliasPhotosetList
  end
  
  test "does it return photosets by flickr user with ID 25376136@N08" do
    @photosets = Photoset.by_user(@flickr_user_fixture)
    assert_not_nil(@photosets)
    assert_equal(@photoset_fixture.length, @photosets.length)
  end
end
