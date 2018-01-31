RSpec.configure do |config|
  config.before(:each) do
    # The famous singleton problem
    Bibox.configure do |config|
      config.key        =   nil
      config.secret     =   nil
    end
  end
end

require "yaml"

def setup_bibox(type = :full)
  cfg_path              =   File.join(File.dirname(__FILE__), "../../credentials.yml")
  
  if ::File.exists?(cfg_path)
    cfg                 =   YAML.load_file(cfg_path).fetch("#{type}_permissions", {})

    Bibox.configure do |config|
      config.key        =   cfg["key"]
      config.secret     =   cfg["secret"]
  
      config.faraday    =   {
        user_agent: "Bibox Ruby",
        verbose:    false
      }
    end
  else
    raise "Missing credentials.yml file - you need to create one and include api key and secret in order to run specs for private API endpoints."
  end
end
