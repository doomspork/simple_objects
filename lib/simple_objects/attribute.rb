module SimpleObjects
  class Attribute
    attr_accessor :default, :name, :required, :type

    def initialize(name, opts = {})
      @name = name
      @required = false
      apply_opts(opts)
    end

    private

    def apply_opts(opts)
      opts.each do |opt, value|
        send("#{opt}=", value) if respond_to?(opt)
      end
    end
  end
end
