module PhotosetsHelper
  def photoset_title_link_list(photosets, ulId="", ulClass="", liClass="", aClass="", emptyId="", emptyClass="")
    s = ""
    if !photosets || photosets.empty?
      s << MarkupHelper.create_begin_tag("p", {"id"=>emptyId, "class"=>emptyClass}) + "Uh, oh. No photosets found ...</p>"
    else
      s << MarkupHelper.create_begin_tag("ul", {"id"=>ulId, "class"=>ulClass})
      for photoset in photosets
        s << MarkupHelper.create_begin_tag("li", {"class"=>liClass})
        link = link_to photoset.title.to_s.capitalize, photoset_photos_path(photoset), {"class"=>aClass}
        s << link
        s << "</li>"
      end
      s << "</ul>"
    end
  end
end
