module PhotosHelper
  def photo_list(photos, photoset, ulId="", ulClass="", liClass="", aClass="", imgClass="", emptyId="", emptyClass="")
    s = ""
    if !photos || photos.empty?
      s << MarkupHelper.create_begin_tag("p", {"id"=>emptyId, "class"=>emptyClass}) + "Uh, oh. No photosets found ...</p>"
    else
      s << MarkupHelper.create_begin_tag("ul", {"id"=>ulId, "class"=>ulClass})
      for photo in photos
        s << MarkupHelper.create_begin_tag("li", {"class"=>liClass})
        s << MarkupHelper.create_begin_tag("a", {"href"=>photoset_photo_url(photoset,photo), "class"=>aClass})
        img = image_tag photo.thumb_link, :alt=>photo.title, :class=>imgClass
        s << img
        s << "</a></li>"
      end
      s << "</ul>"
    end
  end
end
