require "helpers/flickr_helper"

class HomeController < ApplicationController
  include FlickrAware
  
  def index
    @photos = Photo.search_by_tag('featured', FLICKR_CONFIG[:user_id])
  end
  
  def show
    render :action => params[:page]
  end
    
  def search
    d = FlickrAware.invoke("flickr.interestingness.getList")
    @interesting_list = []
    if d
      d.root.get_elements("//photo").each do |photo|
        @interesting_list << Photo.from_xml(photo)
      end
    end
  end
  
end
