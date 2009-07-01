class PhotosController < ApplicationController
  layout "photosets"
  
  # GET /photos
  # GET /photos.xml
  def index
    session[:flickr_page] ||= 1
    session[:flickr_per_page] ||= 5
    
    get_photos    
    session[:flickr_page_total] ||= @photoset.pages
    
    if params[:scroll]
      @scroll = params[:scroll].to_s
      if @scroll == "left"
        scroll_left
      elsif @scroll == "right"
        scroll_right
      end
    else
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @photos }
      end
    end
  end

  

  # GET /photos/1
  # GET /photos/1.xml
  def show
    @photo = Photo.find(params[:id])
    get_photos
    respond_to do |format|
      format.html {render :action=> "index"}
      #format.html
      format.js {render :layout => false}
    end
  end

private
  def get_photos
    @photoset = Photoset.find(params[:photoset_id])
    @photos = Photo.by_photoset(@photoset, session[:flickr_per_page], session[:flickr_page])
  end

def scroll_right
    if session[:flickr_page] < session[:flickr_page_total]
      session[:flickr_page] += 1
      get_and_render
    end
  end
  
  def scroll_left
    if session[:flickr_page] > 1
      session[:flickr_page] -= 1
      get_and_render
    end
  end
  
  def get_and_render
    get_photos
    respond_to do |format|
      format.html
      format.js {render :partial=>"photo_list"}
    end
  end

end
