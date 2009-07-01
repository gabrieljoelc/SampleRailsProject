class FlickrUserFactory
  def self.CreatePopaEliasUser
    return self.CreateUserList[:popa_elias]
  end
  
  def self.CreateUserList
    list = YAML.load_file(File.join(RAILS_ROOT, 'test', 'fixtures', 'non_db_fixtures', 'flickr_users.yml'))
    list.each do |key, value|
      list[key] = FlickrUser.new(value)
    end
    return list
  end
end