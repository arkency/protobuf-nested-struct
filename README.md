# ProtobufNestedStruct

Serialize your primitives, arrays and hashes using protobuf. Supports nested arrays and hashes.

Supported types:

* nil
* integer
* float
* boolean
* string
* date
* time
* hash (keys must be strings, values' types must be on this list)
* array (elements' types must be on this list)

Inspired by `google/protobuf/struct.proto` but it can additionally handle Date, Time and Integer values.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'protobuf_nested_struct'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install protobuf_nested_struct

## Usage

```ruby
# store the serialized binary string in DB or send over network
serialized = ProtobufNestedStruct.dump(v)


# receive de-serialized binary string from DB or network 
copy = ProtobufNestedStruct.load(serialized)

expect(copy).to eql(obj)
```

where `obj` can be an instance of one of the supported types.

## Development

* `bundle install`
* `bundle exec rspec`

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/arkency/protobuf-nested-struct 

## Credits

* https://github.com/google/protobuf/blob/07b9238a1c03ef0351bcb4ca57d773eb7b7c5824/src/google/protobuf/struct.proto
* https://github.com/google/protobuf/blob/9497a657d577ebda0272711651c3dcdda3a4ac35/ruby/lib/google/protobuf/well_known_types.rb#L149
* https://github.com/google/protobuf/blob/9497a657d577ebda0272711651c3dcdda3a4ac35/ruby/tests/well_known_types_test.rb#L35

## About

<img src="https://arkency.com/images/arkency.png" alt="Arkency" width="60px" align="left" />

This repository is funded and maintained by [Arkency](https://arkency.com). Check out our other [open-source projects](https://github.com/arkency), especially [Rails Event Store](https://github.com/RailsEventStore).

Consider [hiring us](https://arkency.com/hire-us) to grow your Ruby/Rails apps and business. Make sure to check out [our blog](https://blog.arkency.com).