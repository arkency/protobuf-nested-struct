require "protobuf/nested/struct/version"
require "protobuf/nested/struct_pb"

module Protobuf
  module Nested
    module Struct

    end
  end
end

module RubyEventStore
  module Protobuf
    Value.class_eval do
      def from_ruby(obj)
        case obj
          when NilClass
            self.null_value = 0
          when Integer
            self.int_value = obj
          when Float
            self.double_value = obj
          when String
            self.string_value = obj
          when TrueClass, FalseClass
            self.bool_value = obj
          else
            raise ArgumentError
          end
      end

      def to_ruby
        case self.kind
        when :null_value
          nil
        when :int_value
          int_value
        when :double_value
          double_value
        when :string_value
          string_value
        when :bool_value
          bool_value
        else
          raise ArgumentError
        end
      end

    end
  end
end
