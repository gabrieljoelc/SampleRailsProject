class SitemapController < ActionController::Base
  def index   
    @photosets = Photoset.by_user(FlickrUser.find_by_nsid(FLICKR_CONFIG[:user_id]))[0..50]
    respond_to do |format|
      format.xml
    end
  end
end
