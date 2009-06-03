module MarkupHelper
  
  mattr_accessor :assets_cache_dir
  self.assets_cache_dir = "cache"

  def assets_cache_dir
    MarkupHelper.assets_cache_dir
  end
  
  def stylesheet_cache_link_tag(*sources)
    cache = assets_cache_dir ? assets_cache_dir : ""
    options = sources.extract_options!.stringify_keys
    cached_name  = options.delete("cached_name")
    stylesheet_link_tag(sources, :cache=> File.join(cache, cached_name))
    if cache && cached_name && cached_name != ""
      stylesheet_link_tag(sources, :cache=> File.join(cache, cached_name))
    else
      stylesheet_link_tag(sources)
    end
  end
  
  def javascript_cache_include_tag(*sources)
    cache = assets_cache_dir ? assets_cache_dir : ""
    options = sources.extract_options!.stringify_keys
    cached_name  = options.delete("cached_name")
    if cache && cached_name && cached_name != ""
      javascript_include_tag(sources, :cache=> File.join(cache, cached_name))
    else
      javascript_include_tag(sources)
    end
  end
  
  def create_begin_tag(tagName, attributeList = {})
    s = "<" + tagName
    attributeList.each do |key, value|
      attr = set_attribute(key, value)
      if attr && attr != ""
        s << attr
      end
    end
    s << ">"
  end  
  
  def set_id(idValue)
    set_attribute("id", idValue)
  end
  
  def set_class(classValue)
    set_attribute("class", classValue)
  end
    
  def set_attribute(attribute, attributeValue)
    if attribute && attribute != "" && attributeValue && attributeValue != ""
        fullAttribute = " #{attribute}=\"#{attributeValue}\""
    end
  end
  
end
