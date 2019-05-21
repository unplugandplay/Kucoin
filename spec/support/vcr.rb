require 'vcr'
require 'webmock/rspec'

VCR.configure do |c|
  c.allow_http_connections_when_no_cassette = false
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock # or :fakeweb
  c.configure_rspec_metadata!
  
  c.filter_sensitive_data('API-KEY') do |interaction|
    Kucoin.configuration.key
  end
  
  c.filter_sensitive_data('API-PASSPHRASE') do |interaction|
    Kucoin.configuration.passphrase
  end
end
