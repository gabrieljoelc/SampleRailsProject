require File.dirname(__FILE__) + '/../test_helper'

class FlickrUsersControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:flickr_users)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_flickr_user
    assert_difference('FlickrUser.count') do
      post :create, :flickr_user => { }
    end

    assert_redirected_to flickr_user_path(assigns(:flickr_user))
  end

  def test_should_show_flickr_user
    get :show, :id => flickr_users(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => flickr_users(:one).id
    assert_response :success
  end

  def test_should_update_flickr_user
    put :update, :id => flickr_users(:one).id, :flickr_user => { }
    assert_redirected_to flickr_user_path(assigns(:flickr_user))
  end

  def test_should_destroy_flickr_user
    assert_difference('FlickrUser.count', -1) do
      delete :destroy, :id => flickr_users(:one).id
    end

    assert_redirected_to flickr_users_path
  end
end
