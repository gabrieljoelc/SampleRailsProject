require 'test_helper'
#require './fixtures/photoset_factory'
require(File.join(RAILS_ROOT, 'test', 'fixtures', 'photoset_factory'))

class PhotosControllerTest < ActionController::TestCase
  
  def setup
    @photoset_fixture = PhotosetFactory.CreatePopaEliasPhotosetList
    @weddings = @photoset_fixture[:weddings]
    @wedding_per_page = 5
    @wedding_total_pages = 11
  end
  
  #def test_should_get_index
  test "should get index" do
    get :index, :photoset_id=>@weddings.id
    assert_response :success
    assert_not_nil assigns(:photos)
    assert_equal 1, session[:flickr_page]
    assert_equal @wedding_per_page, session[:flickr_per_page]
    assert_equal @wedding_total_pages, session[:flickr_page_total]
  end

  test "should scroll right once from page 1" do
    get :index, :photoset_id=>@weddings.id
    get :index, :photoset_id=>@weddings.id, :scroll=>"right"
    assert_response :success
    assert_not_nil assigns(:photos)
    assert_equal 2, session[:flickr_page]
    assert_equal @wedding_per_page, session[:flickr_per_page]
    assert_equal @wedding_total_pages, session[:flickr_page_total]
  end
  
  test "should scroll right 11 times from page 1" do
    get :index, :photoset_id=>@weddings.id
    for i in 1..10
      get :index, :photoset_id=>@weddings.id, :scroll=>"right"
    end
    assert_response :success
    assert_not_nil assigns(:photos)
    assert_equal 11, session[:flickr_page]
    assert_equal @wedding_per_page, session[:flickr_per_page]
    assert_equal @wedding_total_pages, session[:flickr_page_total]
  end

=begin
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:photos)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_photo
    assert_difference('Photo.count') do
      post :create, :photo => { }
    end

    assert_redirected_to photo_path(assigns(:photo))
  end

  def test_should_show_photo
    get :show, :id => photos(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => photos(:one).id
    assert_response :success
  end

  def test_should_update_photo
    put :update, :id => photos(:one).id, :photo => { }
    assert_redirected_to photo_path(assigns(:photo))
  end

  def test_should_destroy_photo
    assert_difference('Photo.count', -1) do
      delete :destroy, :id => photos(:one).id
    end

    assert_redirected_to photos_path
  end
=end
end
