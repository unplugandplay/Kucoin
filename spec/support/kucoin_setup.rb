RSpec.configure do |config|
  config.before(:each) do
    # The famous singleton problem
    Kucoin.configure do |config|
      config.key        =   nil
      config.secret     =   nil
    end
  end
end

require "yaml"

def setup_kucoin(type = :full)
  cfg_path              =   File.join(File.dirname(__FILE__), "../../credentials.yml")
  
  if ::File.exists?(cfg_path)
    cfg                 =   YAML.load_file(cfg_path).fetch("#{type}_permissions", {})

    Kucoin.configure do |config|
      config.key        =   cfg["key"]
      config.secret     =   cfg["secret"]
      config.passphrase =   cfg["passphrase"]
  
      config.faraday    =   {
        user_agent: "Kucoin Ruby",
        verbose:    false
      }
    end
  else
    raise "Missing credentials.yml file - you need to create one and include api key and secret in order to run specs for private API endpoints."
  end
end
