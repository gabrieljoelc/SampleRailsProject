# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def navUL(id="", cssClass="")
    if id && id != ""
      id = " id=\"" + id + "\" "
    end
    if cssClass && cssClass != ""
      cssClass = " class=\"" + cssClass + "\" "
    end
    s = ""
    s << "<ul#{id}#{cssClass}>"
    s << "<li>" + link_to_unless_current("Home", { :controller => "home",  :action => "index" }) + "</li>"
    s << "<li>" + link_to_unless_current("Photography", { :controller => "photosets", :action => "index" }) + "</li>"
    s << "</ul>"
    return s
    #return link_to_unless_current("Home", { :controller => "home",  :action => "index" }).to_a +
    #link_to_unless_current("Photography", { :controller => "photosets", :action => "index" }).to_a
  end
  
  def url_for_unless_current(name, options = {})
	anchorTag = link_to_unless_current(name, options)
	if anchorTag == name
		return nil
	else
		return anchorTag.slice(anchorTag.index("\"")+1..anchorTag.rindex("\"")-1)
	end
  end
  
  def link_to_unless_current_with_inline_html(name, options = {}, tag_name = "span")#, active_class="active")
	url = url_for_unless_current(name, options)
	first = ""
	second = ""
	if url != nil
		first << "<a href=\"#{url}\">"
		second << "</a>"
	#elsif url == nil && active_class != ""
	#	active_class = " class=\"#{active_class}\""
	end
	
	first << "<#{tag_name}>#{name}</#{tag_name}>"
	
	return first + second
  end
    
  def footer
    s = ""
    s << "<div style=\"position: fixed; top: 95%\" >"
    s << "<span style=\"font-size: 80%\">"
    s << "<b>RailTrackr</b>: Written in a matter of hours by <a href=\"mailto:battlehorse@google.com\">Riccardo Govoni</a>"
    s << "</span></div>"
    return s
  end
end
