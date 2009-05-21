xml.instruct!

xml.urlset "xmlns" => "http://www.sitemaps.org/schemas/sitemap/0.9" do
@photosets.each do |photoset|
 xml.url do
   xml.loc url_for(:controller => 'photosets',:action => 'show',
                 :id => photoset.id,:only_path => false)
   #xml.lastmod photoset.updated_at.to_date
 end
end
end
