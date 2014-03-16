require 'yaml'
require File.expand_path('../../quill', __FILE__)

module Quill
  module API
    def self.endpoints
      Hashie::Mash.new(definition['root']).map do |endpoint, definition|
        e = EndpointString.new(endpoint)
        e.singular = definition.options.try(:[], :singular)
        [e, definition]
      end.inject({}) do |hsh, pair|
        hsh[pair[0]] = pair[1]
        hsh
      end
    end

    def self.definition
      YAML.load(File.read(File.expand_path('../api.yml', __FILE__)))
    end
  end

  class EndpointString < String
    attr_writer :singular

    def singular?
      !!@singular
    end
  end
end
