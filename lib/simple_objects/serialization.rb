module SimpleObjects
  module Serialization
    def to_h(opts = {})
      apply_options(opts)
    end

    alias_method :to_hash, :to_h

    private

    def apply_options(opts)
      hsh = hashed_values
      return sub_hash(hsh, opts[:only]) if opts[:only]
      opts[:except].each { |attr| hsh.delete(attr) } if opts[:except]
      (opts[:methods] || {}).each_with_object(hsh) do |method, memo|
        memo[method] = send(method)
      end
    end

    def sub_hash(hash, keys)
      hash.select { |(key, _)| keys.include?(key) }
    end

    def hashed_values
      attributes.each_with_object({}) do |k, hsh|
        val = send(k)
        # `nil.to_h` => {} which we do not want
        if val.nil?
          val = nil
        elsif val.respond_to?(:map)
          val = val.map { |v| v.respond_to?(:to_h) ? v.to_h : v }
        elsif val.respond_to?(:to_h)
          val = val.to_h
        end
        hsh[k] = val
      end
    end

  end
end
