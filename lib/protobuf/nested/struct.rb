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
          else
            raise ArgumentError
          end
      end

      def to_ruby
        case self.kind
        when :null_value
          nil
        else
          raise ArgumentError
        end
      end

    end
  end
end
