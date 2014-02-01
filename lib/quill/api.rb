require 'yaml'
require File.expand_path('../../quill', __FILE__)

class Quill::API
  def self.endpoints
    definition['root']
  end

  def self.definition
    YAML.load(File.read(File.expand_path('../api.yml', __FILE__)))
  end
end
