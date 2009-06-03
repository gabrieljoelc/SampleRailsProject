require 'test_helper'

require File.dirname(__FILE__) + '/../lib/markup_helper'

class MarkupTest < ActiveSupport::TestCase
  # Explicitly include the module
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::AssetTagHelper
  include MarkupHelper

  def test_set_id
    assert_equal " id=\"idName\"", set_id("idName")
  end
  
  def test_default_assets_cache_dir
    assert_equal "cache", MarkupHelper.assets_cache_dir
  end

  def test_stylesheet_cache_link_tag
    stylesheet_cache_link_tag "undohtml", "default", :cached_name => "defaults"
    assert true, "stylesheet_cache_link_tag call blew up."
  end

  def test_javascript_cache_include_tag
    javascript_cache_include_tag "default", "jquery", :cached_name => "defaults"
    assert true, "stylesheet_cache_link_tag call blew up."
  end

end
