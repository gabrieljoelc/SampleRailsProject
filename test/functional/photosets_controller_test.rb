require 'test_helper'

class PhotosetsControllerTest < ActionController::TestCase
  def test_truth
    assert true
  end

=begin
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:photosets)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_photoset
    assert_difference('Photoset.count') do
      post :create, :photoset => { }
    end

    assert_redirected_to photoset_path(assigns(:photoset))
  end
  
  def test_should_show_photoset
    get :show, :id => photosets(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => photosets(:one).id
    assert_response :success
  end

  def test_should_update_photoset
    put :update, :id => photosets(:one).id, :photoset => { }
    assert_redirected_to photoset_path(assigns(:photoset))
  end

  def test_should_destroy_photoset
    assert_difference('Photoset.count', -1) do
      delete :destroy, :id => photosets(:one).id
    end

    assert_redirected_to photosets_path
  end
=end
end
