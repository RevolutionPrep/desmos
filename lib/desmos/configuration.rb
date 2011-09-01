module Desmos
  class Configuration

    class << self

      def domain=(domain)
        @domain = domain.match(/https?\:\/\//) ? domain : 'https://' + domain
      end

      def domain
        @domain || raise(ConfigurationError, 'Configuration.domain is a required configuration value.')
      end

      def version=(version)
        @version = 'api_v' + version.to_s
      end

      def version
        @version || raise(ConfigurationError, 'Configuration.version is a required configuration value.')
      end

      def key=(key)
        @key = key
      end

      def key
        @key || raise(ConfigurationError, 'Configuration.key is a required configuration value.')
      end

      def secret=(secret)
        @secret = secret
      end

      def secret
        @secret || raise(ConfigurationError, 'Configuration.secret is a required configuration value.')
      end

    end

  end
end