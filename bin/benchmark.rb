require 'securerandom'
require 'benchmark'
require 'msgpack'
require 'yaml'
require 'json'
require 'protobuf_nested_struct'

BIG_NUMBER = 100_000
AVG_NUMBER =  10_000
PRNS = ProtobufNestedStruct

MessagePack.singleton_class.class_eval do
  alias_method :dump, :pack
  alias_method :load, :unpack
end

primitives = [
{
  value: nil,
  description: "nil",
  count: BIG_NUMBER,
},
{
  value: 782,
  description: "small int",
  count: BIG_NUMBER,
},
{
  value: "whoa, what's up",
  description: "short string",
  count: BIG_NUMBER,
},
{
  value: 2.5,
  description: "float",
  count: BIG_NUMBER,
},
  {
    value: Date.new(2018, 11, 11),
    description: "date",
    count: BIG_NUMBER,
    exclude: [MessagePack]
  },
  {
    value: Time.now.utc,
    description: "time",
    count: BIG_NUMBER,
    exclude: [MessagePack]
  },
]

arrays = primitives.map do |spec|
  spec = spec.dup
  spec[:value] = [spec[:value]]*BIG_NUMBER
  spec[:description] = "array of #{spec[:description]}"
  spec[:count] = 10
  spec
end

hashes = primitives.map do |spec|
  spec = spec.dup
  spec[:value] = BIG_NUMBER.times.each.with_object({}) do |i, obj|
    obj[SecureRandom.hex(5)] = spec[:value]
  end
  spec[:description] = "hash, values of #{spec[:description]}"
  spec[:count] = 10
  spec
end

tests = primitives + arrays + hashes

tests.each do |job|
  value = job.fetch(:value)
  count = job.fetch(:count)

  Benchmark.bm do |x|
    [YAML, JSON, MessagePack, PRNS].reject{|x| job.fetch(:exclude, []).include?(x) }.each do |serializer|
      x.report("#{serializer.name.rjust(20)}: #{job[:description].rjust(30)}   serialization") do
        count.times { serializer.dump(value) }
      end
    end
  end

  Benchmark.bm do |x|
    [YAML, JSON, MessagePack, PRNS].reject{|x| job.fetch(:exclude, []).include?(x) }.each do |serializer|
      serialized = serializer.dump(value)

      x.report("#{serializer.name.rjust(20)}: #{job[:description].rjust(30)} deserialization") do
        count.times { serializer.load(serialized) }
      end
    end
  end

end

