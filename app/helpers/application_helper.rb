# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def nav
    s = ""
    s << "<ul id=\"navbar\">"
    s << "<li>" + link_to_unless_current("Home", { :controller => "home",  :action => "index" }) + "</li>"
    s << "<li>" + link_to_unless_current("Photography", { :controller => "photosets", :action => "index" }) + "</li>"
    s << "</ul>"
    return s
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
