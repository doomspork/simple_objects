module SimpleObjects
  module Defaults

    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def attr_default(*defaults)
        @defaults ||= {}
        defaults.each { |default| @defaults.merge!(default) }
      end

      def defaults
        @defaults || {}
      end
    end

    def defaults
      self.class.defaults
    end
  end
end
