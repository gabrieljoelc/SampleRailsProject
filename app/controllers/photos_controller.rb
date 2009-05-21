class PhotosController < ApplicationController
  layout 'photo_master'
  
  # GET /photos
  # GET /photos.xml
  def index
    @photos = Photo.by_set(params[:photoset_id])
    @photoset = Photoset.new
    @photoset.id = params[:photoset_id]

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @photos }
    end
  end

  # GET /photos/1
  # GET /photos/1.xml
  def show
    @photo = Photo.find(params[:id])

    respond_to do |format|
      format.jpg
    end
  end

end
