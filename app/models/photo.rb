require 'net/http'
require 'rexml/document'
require 'helpers/flickr_helper'

class Photo
  include FlickrAware
  
  attr_accessor :id,:server,:title,:secret, :farm, :owner
  
  def initialize(params = {})
    @id, @server, @title, @secret = params[:id], params[:server], params[:title], params[:secret]
    @farm, @owner = params[:farm], params[:owner]
  end
  
  def image_data
    raise "Unsufficient params to load the image" unless server && farm && id && secret  
    puts "Grabbing #{image_link}"
    r = Net::HTTP.get_response(URI.parse(image_link))
    if r.kind_of? Net::HTTPSuccess
      r.body
    else
      nil
    end
  end
  
  def Photo.find(id)
    d = FlickrAware.invoke("flickr.photos.getInfo", :photo_id => id)
    if d
      photo_el = d.root.get_elements("//photo")[0]
      p = Photo.new
      p.id = photo_el.attributes["id"]
      p.server = photo_el.attributes["server"]
      p.secret = photo_el.attributes["secret"]
      p.farm = photo_el.attributes["farm"]        
      # p.originalformat = photo_el.attributes["originalformat"]        
      # p.originalsecret = photo_el.attributes["originalsecret"]
      return p
    end
    return nil
  end
  
  # gets photos by a single tag
  def Photo.search_by_tag(tag, user_id = nil)
	tags = tag.split(/,/);
	if (tags.length > 0)
		tag = tags[0].strip()
		d = FlickrAware.invoke("flickr.photos.search", :tags => tag, :user_id => user_id)
		if d
		  photos = []
		  d.root.get_elements("//photo").each do |photo|
			p = Photo.from_xml(photo)
			#p.owner = owner
			photos << p
		  end
		  return photos
		end
	end
    return nil
  end
  
  def Photo.from_xml(photo_el)
    p = Photo.new
    p.id = photo_el.attributes["id"]
    p.server = photo_el.attributes["server"]
    p.farm = photo_el.attributes["farm"]        
    p.title = photo_el.attributes["title"]        
    p.secret = photo_el.attributes["secret"]    
    p.owner ||= FlickrUser.new(:id => photo_el.attributes["owner"])
    return p
  end
  
  def Photo.by_set(photoset_id, per_page = 5, page = 1)
    # extract only the first 30 photos
    d = FlickrAware.invoke("flickr.photosets.getPhotos", :photoset_id => photoset_id, :per_page => per_page, :page => page)
    if d
      photos = []
      photoset = d.root.get_elements("//photoset")[0]
      owner = FlickrUser.new(:username => photoset.attributes["ownername"] , :id => photoset.attributes["owner"])
      d.root.get_elements("//photo").each do |photo|
        p = Photo.from_xml(photo)
        p.owner = owner
        photos << p
      end
      return photos
    end
    return nil    
  end
  
  def Photo.by_photoset(photoset, per_page = 5, page = 1)
    # extract only the first 30 photos
    d = FlickrAware.invoke("flickr.photosets.getPhotos", :photoset_id => photoset.id, :per_page => per_page, :page => page)
    if d
      photoset.photos = []
      photoset_attr = d.root.get_elements("//photoset")[0]
      photoset.page = photoset_attr.attributes["page"].to_i
      photoset.per_page = photoset_attr.attributes["perpage"].to_i
      photoset.pages = photoset_attr.attributes["pages"].to_i
      owner = FlickrUser.new(:username => photoset_attr.attributes["ownername"], :id => photoset_attr.attributes["owner"])
      d.root.get_elements("//photo").each do |photo|
        p = Photo.from_xml(photo)
        p.owner = owner
        photoset.photos << p
      end
      return photoset.photos
    end
    return nil    
  end
  
  def thumb_link
    "http://farm#{farm}.static.flickr.com/#{server}/#{id}_#{secret}_s.jpg"
  end  
  
  def image_link
#    "http://farm#{farm}.static.flickr.com/#{server}/#{id}_#{originalsecret}_o.#{originalformat}"
    "http://farm#{farm}.static.flickr.com/#{server}/#{id}_#{secret}.jpg"
  end
  
  def to_s
    @id
  end
end
