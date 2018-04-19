require "yaml"

module ProtobufNestedStruct
  RSpec.describe self do
    specify "serializes nil" do
      v = Value.new
      v.from_ruby(nil)
      expect(v.to_ruby).to eql(nil)

      expect(clone(v).to_ruby).to eql(nil)

      expect(v.null_value).to eq(:NULL_VALUE)
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

    specify "serializes Hash" do
      s = HashMapStringValue.new
      s.from_ruby({'one' => 1, 'two' => 2.0})
      expect(s.to_ruby).to eql({'one' => 1, 'two' => 2.0})
      expect(clone(s).to_ruby).to eql({'one' => 1, 'two' => 2.0})
    end

    specify "serializes nested Hash" do
      s = HashMapStringValue.new
      s.from_ruby({'1' => 1, '2' => 2.0, '3' => {'4' => Date.today, '5' => {'6' => '7'}}})
      expect(s.to_ruby).to eql({'1' => 1, '2' => 2.0, '3' => {'4' => Date.today, '5' => {'6' => '7'}}})
      expect(clone(s).to_ruby).to eql({'1' => 1, '2' => 2.0, '3' => {'4' => Date.today, '5' => {'6' => '7'}}})

      v = Value.new
      v.from_ruby({'1' => 1, '2' => 2.0, '3' => {'4' => Date.today, '5' => {'6' => '7'}}})
      expect(v.to_ruby).to eql({'1' => 1, '2' => 2.0, '3' => {'4' => Date.today, '5' => {'6' => '7'}}})
      expect(clone(v).to_ruby).to eql({'1' => 1, '2' => 2.0, '3' => {'4' => Date.today, '5' => {'6' => '7'}}})
    end

    specify "serializes Array" do
      l = ListValue.new
      l.from_ruby([1, 2.0, Date.today, nil])
      expect(l.to_ruby).to eql([1, 2.0, Date.today, nil])
      expect(clone(l).to_ruby).to eql([1, 2.0, Date.today, nil])

      l.from_ruby([true, false])
      expect(l.to_ruby).to eql([true, false])
    end

    specify "serializes nested Array" do
      l = ListValue.new
      l.from_ruby([1, [2.0, [Date.today], nil]])
      expect(l.to_ruby).to eql([1, [2.0, [Date.today], nil]])
      expect(clone(l).to_ruby).to eql([1, [2.0, [Date.today], nil]])

      v = Value.new
      v.from_ruby([1, [2.0, [Date.today], nil]])
      expect(v.to_ruby).to eql([1, [2.0, [Date.today], nil]])
      expect(clone(v).to_ruby).to eql([1, [2.0, [Date.today], nil]])
    end

    specify "serializes anything" do
      hash = {
        '1' => nil,
        '2' => 2,
        '3' => 3.2,
        '4' => '44',
        '5' => true,
        '6' => false,
        '7' => Date.new(2018, 4, 18),
        '8' => Time.new(2018, 4, 18),
        '9' => {
          '1' => nil,
          '2' => 2,
          '3' => 3.2,
          '4' => '44',
          '5' => true,
          '6' => false,
          '7' => Date.new(2018, 5, 18),
          '8' => Time.new(2018, 5, 18),
          '9' => {
            '1' => nil,
            '2' => 2,
            '3' => 3.2,
            '4' => '44',
            '5' => true,
            '6' => false,
            '7' => Date.new(2018, 6, 18),
            '8' => Time.new(2018, 6, 18),
          },
          '10' => [
            nil,
            5,
            7.4,
            's',
            true,
            false,
            Date.new(2018, 4, 18),
            Time.new(2018, 4, 18),
            [
              nil,
              5,
              7.4,
              's',
              true,
              false,
              Date.new(2018, 4, 18),
              Time.new(2018, 4, 18),
            ]
          ]
        },
        '10' => [
          nil,
          5,
          7.4,
          's',
          true,
          false,
          Date.new(2018, 4, 18),
          Time.new(2018, 4, 18),
          {
            '1' => nil,
            '2' => 2,
            '3' => 3.2,
            '4' => '44',
            '5' => true,
            '6' => false,
            '7' => Date.new(2018, 4, 18),
            '8' => Time.new(2018, 4, 18),
            '9' => {
              '1' => nil,
              '2' => 2,
              '3' => 3.2,
              '4' => '44',
              '5' => true,
              '6' => false,
              '7' => Date.new(2018, 6, 18),
              '8' => Time.new(2018, 6, 18),
            },
            '10' => [
              nil,
              5,
              7.4,
              's',
              true,
              false,
              Date.new(2018, 4, 18),
              Time.new(2018, 4, 18),
              {
                '1' => nil,
                '2' => 2,
                '3' => 3.2,
                '4' => '44',
                '5' => true,
                '6' => false,
                '7' => Date.new(2018, 4, 18),
                '8' => Time.new(2018, 4, 18),
                '9' => {
                  '1' => nil,
                  '2' => 2,
                  '3' => 3.2,
                  '4' => '44',
                  '5' => true,
                  '6' => false,
                  '7' => Date.new(2018, 6, 18),
                  '8' => Time.new(2018, 6, 18),
                },
                '10' => [
                  nil,
                  5,
                  7.4,
                  's',
                  true,
                  false,
                  Date.new(2018, 4, 18),
                  Time.new(2018, 4, 18),
                ]
              }
            ]
          }
        ]
      }

      hash2 = YAML.load(YAML.dump(hash))
      v = Value.new
      v.from_ruby(hash)
      expect(v.to_ruby).to eql(hash2)
      expect(clone(v).to_ruby).to eql(hash2)

      s = HashMapStringValue.new
      s.from_ruby(hash)
      expect(s.to_ruby).to eql(hash2)
      expect(clone(s).to_ruby).to eql(hash2)
    end

    specify "cannot deserialize nothing" do
      v = Value.new
      expect{ v.to_ruby }.to raise_error(ArgumentError)
    end

    specify "cannot serialize unsupported types" do
      v = Value.new
      expect{ v.from_ruby(Object.new) }.to raise_error(ArgumentError, /not allowed.*<Object:.*>/)
      expect{ v.from_ruby(Class.new{def inspect; "YO"; end}.new) }.to raise_error(ArgumentError, /not allowed.*YO/)

      v = HashMapStringValue.new
      expect{ v.from_ruby(Object.new) }.to raise_error(ArgumentError)

      v = ListValue.new
      expect{ v.from_ruby(Object.new) }.to raise_error(ArgumentError)
    end

    def clone(v)
      klass = v.class
      klass.decode(klass.encode(v))
    end
  end
end