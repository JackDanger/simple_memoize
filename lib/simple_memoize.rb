module SimpleMemoize
  VERSION = '1.1.0'

  module Module
    def memoize(*method_names)
      method_names.each do |method_name|
        method_name = method_name.to_s
        memoized_method_name = "#{method_name}_with_memo"
        regular_method_name  = "#{method_name}_without_memo"

        unless (instance_methods + private_instance_methods).include?(method_name)
          raise NoMethodError, "The Method '#{method_name}' cannot be memoized because it doesn't exist in #{self}"
        end
        return if self.method_defined?(memoized_method_name)
    
        self.class_eval "
          def #{memoized_method_name}(*args)
            @#{method_name} ||= #{regular_method_name}(*args)
          end

          alias_method :#{regular_method_name}, :#{method_name}
          alias_method :#{method_name}, :#{memoized_method_name}

          protected :#{method_name} if protected_instance_methods.include?('#{regular_method_name}')
          private   :#{method_name} if private_instance_methods.include?('#{regular_method_name}')
        "
      end
    end
  end
end

Module.send :include, SimpleMemoize::Module
