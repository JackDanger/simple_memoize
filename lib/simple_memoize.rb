module SimpleMemoize
  VERSION = '1.1.2'

  module Module
    def memoize(*method_names)
      method_names.each do |method_name|
        method_name = method_name.to_s
        stripped_method_name = method_name.sub(/([!?])$/, '')

        punctuation = $1
        wordy_punctuation = (punctuation == '!' ? '_bang' : '_huh') if punctuation
        ivar_name = "@#{stripped_method_name}#{wordy_punctuation}"

        memoized_method_name = "#{stripped_method_name}_with_memo#{punctuation}"
        regular_method_name  = "#{stripped_method_name}_without_memo#{punctuation}"

        unless __include_method_name__( (instance_methods + private_instance_methods), method_name )
          raise NoMethodError, "The Method '#{method_name}' cannot be memoized because it doesn't exist in #{self}"
        end
        return if self.method_defined?(memoized_method_name)
    
        self.class_eval "
          def #{memoized_method_name}(*args)
            if defined?(#{ivar_name})
              #{ivar_name}
            else
              #{ivar_name} = #{regular_method_name}(*args)
            end
          end

          alias_method :#{regular_method_name}, :#{method_name}
          alias_method :#{method_name}, :#{memoized_method_name}

          protected :#{method_name} if __include_method_name__( protected_instance_methods, '#{regular_method_name}' )
          private   :#{method_name} if __include_method_name__( private_instance_methods, '#{regular_method_name}' )
        "
      end
    end

    private
    # Necessary because ruby1.9 now returns methods as symbols not strings
    def __include_method_name__(methods, method_name)
      methods.include?( method_name ) || methods.include?( method_name.to_sym )
    end
  end
end

Module.send :include, SimpleMemoize::Module
