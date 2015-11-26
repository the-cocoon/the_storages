require 'haml'
require 'slim'
require 'paperclip'
require 'image_tools'
require 'to_slug_param'
require 'the_sortable_tree'

require 'the_storages/config'
require 'the_storages/version'

# TODO:
# require app level initializer if it's exists
def require_storages_app_level_initializer
  app_initializer = "#{ Rails.root }/config/initializers/the_storages.rb"
  require(app_initializer) if File.exists?(app_initializer)
end

module TheStorages
  class Engine < Rails::Engine
    config.autoload_paths += Dir["#{config.root}/app/controllers/concerns/**"]
    config.autoload_paths += Dir["#{config.root}/app/models/concerns/**"]
  end

  def self.file_name file_name
    file_name = File.basename(file_name)
    ext       = File.extname(file_name)
    File.basename(file_name, ext).to_s.to_slug_param
  end

  def self.file_ext file_name
    File.extname(file_name)[1..-1].to_s.to_slug_param
  end
end
