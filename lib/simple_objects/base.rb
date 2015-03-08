require_relative 'defaults'

module SimpleObjects
  module Base

    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def attr_accessor(*attrs)
        @attributes ||= []
        @attributes.concat(attrs)
        super(*attrs)
      end

      def attributes
        @attributes || []
      end
    end

    def initialize(attributes = {})
      values = defaults.merge(attributes)
      values.each do |attr, value|
        mthd = "#{attr}="
        send(mthd, value) if self.respond_to?(mthd)
      end
    end

    def to_h
      attributes.each_with_object({}) do |k, hsh|
        val = send(k)
        if val.nil?
          val = nil
        elsif val.respond_to?(:to_h)
          val = val.to_h
        elsif val.respond_to?(:map)
          val = val.map { |v| v.respond_to?(:to_h) ? v.to_h : v }
        end
        hsh[k] = val
      end
    end

    alias_method :to_hash, :to_h

    def as_json(opts = {})
      to_h.as_json(opts)
    end

    def cache_key
      individual_key = [@id || 'new', @updated_at].reject(&:nil?).join('-')
      "#{self.class.to_s.underscore}/#{individual_key}"
    end

    protected

    def attributes
      self.class.attributes
    end
  end
end
