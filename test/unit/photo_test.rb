require 'test_helper'
#require './fixtures/flickr_user_factory'
#require './fixtures/photoset_factory'

require(File.join(RAILS_ROOT, 'test', 'fixtures', 'flickr_user_factory'))
require(File.join(RAILS_ROOT, 'test', 'fixtures', 'photoset_factory'))

class PhotoTest < ActiveSupport::TestCase
  def setup
    #@flickr_user_fixture = FlickrUserFactory.CreatePopaEliasUser
    @photoset_fixture = PhotosetFactory.CreatePopaEliasPhotosetList
    @weddings = @photoset_fixture[:weddings]
    #@photo_fixture = PhotoFactory.CreatePopaEliasPhotoList
    @wedding_per_page = 5
    @wedding_total_pages = 11
  end
  
  test "does it return all photos by wedding photoset of flickr user with ID 25376136@N08" do
    @photos = Photo.by_set @weddings.id, 500, 1
    assert_not_nil @photos
    assert_equal @weddings.photos_num.to_s, @photos.length.to_s
  end
  
  test "does it return 5 photos for page 1 by wedding photoset ID" do
    @photos = Photo.by_set @weddings.id, @wedding_per_page, 1
    assert_not_nil @photos
    assert_equal @wedding_per_page, @photos.length
  end
  
  test "does it return 1 photo for page 11 by wedding photoset ID" do
    @photos = Photo.by_set @weddings.id, @wedding_per_page, @wedding_total_pages
    assert_not_nil @photos
    assert_equal 1, @photos.length
  end
  
  test "does it return 5 photos for page 1 by wedding photoset" do
    @photos = Photo.by_photoset @weddings, @wedding_per_page, 1
    assert_not_nil @photos
    assert_equal @wedding_per_page, @photos.length
    assert_equal 1, @weddings.page
    assert_equal @wedding_per_page, @weddings.per_page
    assert_equal @wedding_total_pages, @weddings.pages
  end
  
end
