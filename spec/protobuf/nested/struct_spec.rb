require "protobuf/nested/struct"

RSpec.describe Protobuf::Nested::Struct do
  Value = RubyEventStore::Protobuf::Value

  it "has a version number" do
    expect(Protobuf::Nested::Struct::VERSION).not_to be nil
  end

  specify "serializes nil" do
    v = Value.new
    v.from_ruby(nil)
    expect(v.to_ruby).to eq(nil)

    expect(clone(v).to_ruby).to eq(nil)
  end

  def clone(v)
    Value.decode(Value.encode(v))
  end
end
