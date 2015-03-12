require_relative 'attribute'
require_relative 'errors/mismatched_type_error'
require_relative 'errors/required_missing_error'

module SimpleObjects
  module Attributes

    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      attr_reader :attributes

      def attribute(attribute, opts = {})
        @attributes ||= {}
        attr = Attribute.new(attribute, opts)
        @attributes[attribute] = attr
        send(:attr_reader, attribute)
      end

      def attributes
        @attributes || {}
      end
    end

    protected

    def mass_assign(inputs)
      attributes.each do |(name, attr)|
        value = inputs[name]
        if value
          mismatch(attr, value) if (type = attr.type) && !(value.is_a? type)
          set_value(name, value)
          next
        end

        missing(name) if attr.required
        set_value(name, attr.default) if attr.default
      end
    end

    def attributes
      self.class.attributes
    end

    def set_value(name, value)
      instance_variable_set("@#{name}", value)
    end

    def missing(name)
      raise RequiredMissingError.new("Missing required value for #{name}")
    end

    def mismatch(attribute, value)
      raise MismatchedTypeError.new("Expected #{attribute.name} to be #{attribute.type} but was #{value.class}")
    end
  end
end
