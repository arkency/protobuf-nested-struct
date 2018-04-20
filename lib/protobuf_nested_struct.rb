require 'date'
require 'google/protobuf'
require 'google/protobuf/well_known_types'

require 'protobuf_nested_struct/version'
require 'protobuf_nested_struct/struct_pb'

module ProtobufNestedStruct
  class Value
    def self.dump(obj)
      v = new
      v.from_ruby(obj)
      encode(v)
    end

    def self.load(string)
      v = decode(string)
      v.to_ruby
    end

    def from_ruby(obj)
      case obj
        when nil
          self.null_value = 0
        when Integer
          self.int_value = obj
        when Float
          self.double_value = obj
        when String
          self.string_value = obj
        when TrueClass, FalseClass
          self.bool_value = obj
        when Date
          self.date_value = Google::Type::Date.new(day: obj.day, month: obj.month, year: obj.year)
        when Time
          self.timestamp_value = Google::Protobuf::Timestamp.new.tap{|gpt| gpt.from_time(obj) }
        when Hash
          self.string_map_value = HashMapStringValue.new.tap{|ps| ps.from_ruby(obj) }
        when Array
          self.list_value = ListValue.new.tap{|ps| ps.from_ruby(obj) }
        else
          raise ArgumentError, "not allowed: #{obj.inspect}"
      end
    end

    def to_ruby
      case kind
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
        when :date_value
          Date.new(date_value.year, date_value.month, date_value.day)
        when :timestamp_value
          timestamp_value.to_time
        when :string_map_value
          string_map_value.to_ruby
        when :list_value
          list_value.to_ruby
        else
          raise ArgumentError
      end
    end

  end

  class HashMapStringValue
    def self.dump(obj)
      v = new
      v.from_ruby(obj)
      encode(v)
    end

    def self.load(string)
      v = decode(string)
      v.to_ruby
    end

    def from_ruby(obj)
      Hash === obj or raise ArgumentError
      obj.each do |key, value|
        fields[key] ||= Value.new
        fields[key].from_ruby(value)
      end
    end

    def to_ruby
      fields.each_with_object({}) do |(key, value), hash|
        hash[key] = value.to_ruby
      end
    end
  end

  class ListValue
    def self.dump(obj)
      v = new
      v.from_ruby(obj)
      encode(v)
    end

    def self.load(string)
      v = decode(string)
      v.to_ruby
    end

    def from_ruby(obj)
      Array === obj or raise ArgumentError
      values.clear
      obj.each do |value|
        values << Value.new.tap{|v| v.from_ruby(value) }
      end
    end

    def to_ruby
      values.map{|v| v.to_ruby }
    end
  end

  def self.dump(obj)
    Value.dump(obj)
  end

  def self.load(string)
    Value.load(string)
  end
end