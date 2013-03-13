VCR.configure do |config|
  config.hook_into :webmock
  config.cassette_library_dir = 'fixtures/cassettes'
end

VCR.cucumber_tags do |t|
  t.tag '@vcr', use_scenario_name: true
end
