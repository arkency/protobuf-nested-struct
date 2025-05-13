# frozen_string_literal: true

require_relative "lib/protobuf_nested_struct/version"

Gem::Specification.new do |spec|
  spec.name = "protobuf_nested_struct"
  spec.version = ProtobufNestedStruct::VERSION
  spec.authors = ["Robert Pankowecki", "Arkency"]
  spec.email = ["dev@arkency.com"]
  spec.summary =
    "Serialize primitives and deep structures (array, hash) to protobuf"
  spec.description = <<~EOD
    Serialize primitives and deep structures (array, hash) to protobuf
  EOD
  spec.homepage = "https://github.com/arkency/protobuf-nested-struct"
  spec.files = Dir["lib/**/*"]
  spec.require_paths = %w[lib]
  spec.extra_rdoc_files = %w[README.md]

  spec.metadata = {
    "homepage_uri" => "https://github.com/arkency/protobuf-nested-struct",
    "changelog_uri" =>
      "https://github.com/arkency/protobuf-nested-struct/releases",
    "source_code_uri" => "https://github.com/arkency/protobuf-nested-struct",
    "bug_tracker_uri" =>
      "https://github.com/arkency/protobuf-nested-struct/issues",
    "rubygems_mfa_required" => "true"
  }

  spec.add_dependency "google-protobuf", "< 4"
end
