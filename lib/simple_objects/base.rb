require_relative 'attributes'
require_relative 'serialization'

module SimpleObjects
  module Base
    include Attributes
    include Serialization

    def self.included(base)
      base.extend(ClassMethods)
    end

    def initialize(attributes = {})
      mass_assign(attributes)
    end
  end
end
