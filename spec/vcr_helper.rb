require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = "fixtures/cassettes"
  config.hook_into :webmock
  config.filter_sensitive_data("<GOOGLE API KEY>") { ENV.fetch("GOOGLE_API_KEY") }
  config.default_cassette_options = { re_record_interval: 1.week }
end
