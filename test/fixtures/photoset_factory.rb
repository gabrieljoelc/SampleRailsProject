class PhotosetFactory
  def self.CreatePopaEliasPhotosetList
    list = YAML.load_file(File.join(RAILS_ROOT, 'test', 'fixtures', 'non_db_fixtures', 'photosets.yml'))
    list.each do |key, value|
      list[key] = Photoset.new(value)
    end
    return list
  end
end