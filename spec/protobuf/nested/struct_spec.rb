require "protobuf/nested/struct"

RSpec.describe Protobuf::Nested::Struct do
  Value = RubyEventStore::Protobuf::Value

  it "has a version number" do
    expect(Protobuf::Nested::Struct::VERSION).not_to be nil
  end

  specify "serializes nil" do
    v = Value.new
    v.from_ruby(nil)
    expect(v.to_ruby).to eql(nil)

    expect(clone(v).to_ruby).to eql(nil)
  end

  specify "serializes int" do
    v = Value.new
    v.from_ruby(2)
    expect(v.to_ruby).to eql(2)

    expect(clone(v).to_ruby).to eql(2)
  end

  specify "serializes float" do
    v = Value.new
    v.from_ruby(2.2)
    expect(v.to_ruby).to eql(2.2)

    expect(clone(v).to_ruby).to eql(2.2)
  end

  specify "serializes string" do
    v = Value.new
    v.from_ruby("wow")
    expect(v.to_ruby).to eql("wow")

    expect(clone(v).to_ruby).to eql("wow")
  end

  specify "serializes true" do
    v = Value.new
    v.from_ruby(true)
    expect(v.to_ruby).to eql(true)

    expect(clone(v).to_ruby).to eql(true)
  end

  specify "serializes false" do
    v = Value.new
    v.from_ruby(false)
    expect(v.to_ruby).to eql(false)

    expect(clone(v).to_ruby).to eql(false)
  end

  specify "serializes Date" do
    v = Value.new
    v.from_ruby(Date.new(2018, 4, 18))
    expect(v.to_ruby).to eql(Date.new(2018, 4, 18))

    expect(clone(v).to_ruby).to eql(Date.new(2018, 4, 18))
  end

  specify "serializes Time" do
    v = Value.new
    v.from_ruby(Time.new(2018,  4, 18, 12 , 13, 14.5))
    expect(v.to_ruby).to eql(Time.new(2018,  4, 18, 12 , 13, 14.5))

    expect(clone(v).to_ruby).to eql(Time.new(2018,  4, 18, 12 , 13, 14.5))
  end

  def clone(v)
    Value.decode(Value.encode(v))
  end
end
