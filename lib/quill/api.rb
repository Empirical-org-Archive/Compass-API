require 'yaml'
require File.expand_path('../../quill', __FILE__)

module Quill
  module API
    def self.endpoints
      Hashie::Mash.new(definition['root'])
    end

    def self.definition
      YAML.load(File.read(File.expand_path('../api.yml', __FILE__)))
    end
  end
end
