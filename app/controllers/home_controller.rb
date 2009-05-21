require 'flickr_helper'

class HomeController < ApplicationController
  include FlickrAware
  layout 'photo_master'
  
  def index
    
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
