module PhotosHelper
  def photo_list(photos, photoset, ulId="", ulClass="", liClass="", aClass="", imgClass="", emptyId="", emptyClass="")
    s = ""
    if !photos || photos.empty?
      s << content_tag(:p, "Uh, oh. No photos found ...</p>", {"id"=>emptyId, "class"=>emptyClass})
    else
      s << tag("ul", {"id"=>ulId, "class"=>ulClass}, true)
      for photo in photos
        s << content_tag(:li, link_to(image_tag(photo.thumb_link, :alt=>photo.title, :class=>imgClass, :id=>"photo_"+photo.id), photoset_photo_path(photoset,photo), :class=>aClass + " get"), :class=>liClass)
      end
      s << "</ul>"
    end
  end
end