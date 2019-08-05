# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../../lib', __dir__)
require 'cveiche'
require 'minitest/autorun'
require 'vcr'
require 'webmock'

VCR.configure do |config|
  config.cassette_library_dir = 'test/fixtures'
  config.hook_into :webmock
end
