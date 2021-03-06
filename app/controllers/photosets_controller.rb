class PhotosetsController < ApplicationController
  before_filter :load_user
  
  def load_user
    @flickr_user = FlickrUser.find_by_nsid(FLICKR_CONFIG[:user_id])
  end
  
  # GET /photosets
  # GET /photosets.xml
  def index
    
    session[:flickr_page] = nil
    session[:flickr_per_page] = nil
    session[:flickr_page_total] = nil
    
    @photosets = Photoset.by_user(@flickr_user)[0..50]
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @photosets }
    end
  end

  # GET /photosets/1
  # GET /photosets/1.xml
  def show
    @photoset = Photoset.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @photoset }
    end
  end

end
