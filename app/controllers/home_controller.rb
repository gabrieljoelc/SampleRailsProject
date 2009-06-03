require "helpers/flickr_helper"

class HomeController < ApplicationController
  include FlickrAware
  def index
    
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
