module MarkupHelper

  def self.create_begin_tag(tagName, attributeList = {})
    s = "<" + tagName
    attributeList.each do |key, value|
      attr = set_attribute(key, value)
      if attr && attr != ""
        s << attr
      end
    end
    s << ">"
  end
  
  def self.set_id(idValue)
    set_attribute("id", idValue)
  end
  
  def self.set_class(classValue)
    set_attribute("class", classValue)
  end
    
  def self.set_attribute(attribute, attributeValue)
    if attribute && attribute != "" && attributeValue && attributeValue != ""
        fullAttribute = " #{attribute}=\"#{attributeValue}\""
    end
  end
end
