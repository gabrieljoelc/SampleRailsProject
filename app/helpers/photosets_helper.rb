module PhotosetsHelper
  def photoset_title_link_list(photosets, ulId="", ulClass="", liClass="", aClass="", emptyId="", emptyClass="")
    s = ""
    if !photosets || photosets.empty?
      s << content_tag(:p, "Uh, oh. No photosets found ...</p>", {"id"=>emptyId, "class"=>emptyClass})
    else
      s << tag("ul", {"id"=>ulId, "class"=>ulClass}, true)
      for photoset in photosets
        s << content_tag(:li, link_to(photoset.title.to_s.capitalize, photoset_photos_path(photoset), {"class"=>aClass}), :class=>liClass)
      end
      s << "</ul>"
    end
  end
end
