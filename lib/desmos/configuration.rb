module Desmos
  module Configuration

    def domain=(domain)
      @domain = case domain
      when String
        domain.match(/https?\:\/\//) ? ('https://' + domain.split('://')[1]) : 'https://' + domain
      else
        domain
      end
    end
    module_function :domain=

    def domain
      @domain || raise(ConfigurationError, 'Desmos::Configuration.domain is a required configuration value.')
    end
    module_function :domain

    def version=(version)
      @version = case version
      when String, Numeric
        version  = version.to_s
        version.match(/api_v\d+/) ? version : 'api_v' + version.match(/\d+/)[0]
      else
        version
      end
    end
    module_function :version=

    def version
      @version || raise(ConfigurationError, 'Desmos::Configuration.version is a required configuration value.')
    end
    module_function :version

    def key=(key)
      @key = key.nil? ? key : key.to_s
    end
    module_function :key=

    def key
      @key || raise(ConfigurationError, 'Desmos::Configuration.key is a required configuration value.')
    end
    module_function :key

    def secret=(secret)
      @secret = secret
    end
    module_function :secret=

    def secret
      @secret || raise(ConfigurationError, 'Desmos::Configuration.secret is a required configuration value.')
    end
    module_function :secret

  end
end