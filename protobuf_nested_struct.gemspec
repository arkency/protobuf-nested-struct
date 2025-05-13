
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "protobuf_nested_struct/version"

Gem::Specification.new do |spec|
  spec.name          = "protobuf_nested_struct"
  spec.version       = ProtobufNestedStruct::VERSION
  spec.authors       = ["Robert Pankowecki", "Arkency"]
  spec.email         = ["dev@arkency.com"]

  spec.summary       = %q{Serialize primitives and deep structures (array, hash) to protobuf}
  spec.description   = %q{Serialize primitives and deep structures (array, hash) to protobuf}
  spec.homepage      = "https://github.com/arkency/protobuf-nested-struct"
  spec.metadata      = {
    "homepage_uri"    => "https://github.com/arkency/protobuf-nested-struct",
    "changelog_uri"   => "https://github.com/arkency/protobuf-nested-struct/releases",
    "source_code_uri" => "https://github.com/arkency/protobuf-nested-struct",
    "bug_tracker_uri" => "https://github.com/arkency/protobuf-nested-struct/issues",
  }

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.add_dependency "google-protobuf"
end
