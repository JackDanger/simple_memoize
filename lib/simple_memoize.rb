module SimpleMemoize
  VERSION = '1.0.0'

  module Module
    def memoize(method_name)
      memoized_method_name = "#{method_name}_with_memo"
      regular_method_name  = "#{method_name}_without_memo"

      return if self.method_defined?(memoized_method_name)
    
      self.class_eval do

        define_method memoized_method_name do |*args|
          @simple_memo ||= {}
          @simple_memo[method_name] ||= {}
          @simple_memo[method_name][args] ||= send(regular_method_name, *args)
        end

        alias_method regular_method_name, method_name
        alias_method method_name, memoized_method_name

        protected method_name if protected_instance_methods.include?(regular_method_name)
        private   method_name if private_instance_methods.include?(regular_method_name)

      end
    end
  end
end

Module.send :include, SimpleMemoize::Module