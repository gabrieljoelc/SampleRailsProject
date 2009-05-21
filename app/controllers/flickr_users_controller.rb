class FlickrUsersController < ApplicationController
  layout 'photo_master'
  
  # GET /flickr_users/1  
  def show
    @flickr_user = FlickrUser.find_by_nsid(params[:id])
    if @flickr_user
      redirect_to flickr_user_photosets_url(@flickr_user)
    else
      flash[:notice] = "User not found"
      redirect_to :controller => :home
    end
  end

  # POST /flickr_users
  # POST /flickr_users.xml
  def create
    @flickr_user = FlickrUser.new(params[:flickr_user])
    if @flickr_user.populate
      redirect_to flickr_user_photosets_url(@flickr_user)
    else
      flash[:notice] = "User not found"
      redirect_to :controller => :home
    end
  end

end
