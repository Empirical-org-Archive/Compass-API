require 'yaml'
require File.expand_path('../../quill', __FILE__)
gem 'activesupport'
require 'active_support/core_ext'

module Quill
  module API
    def self.endpoints
      root = definition['root']
      description = root.delete 'description'
      title       = root.delete 'title'

      Hashie::Mash.new(root).map do |endpoint, definition|
        name = EndpointString.new(endpoint)
        spec = EndpointSpec.new(name, definition)
        [name, spec]
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
  end

  class EndpointSpec < Hashie::Mash
    def initialize name, spec
      @name = name
      spec.options ||= {}
      super(spec)
    end

    def singular?
      options.singular
    end

    def description_comment(type, indent)
      lines = description.strip.split("\n")

      if type == :find && !singular?
        lines << "@param id [String] the id of the #{@name.singularize.downcase.humanize}"
      end

      if type == :create
        lines << "@param [Hash] properties properties for create"

        attributes.each do |attr, _|
          lines << "@option properties [String] :#{attr}"
        end
      end

      lines.map do |line|
        indent + '# ' + line
      end.join("\n").strip
    end
  end
end
