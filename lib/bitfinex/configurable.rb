module Bitfinex
  module Configurable
    def self.included(base)
      base.extend(ClassMethods)
    end

    def config
      self.class.config
    end

    module ClassMethods
      def configure
        yield config
        initialize_configuration
      end

      def config
        @configuration ||= Configuration.new
      end

      def initialize_configuration
        modules = case @configuration.version
        when 1: V1_MODULES
        when 2: V2_MODULES
          else: V1_MODULES
        end

        class_eval do
          modules.each do |mod|
            include mod
          end
        end
      end

    end
  end

  class Configuration
    attr_accessor :api_endpoint, :debug, :debug_connection, :secret, :api_key, :websocket_api_endpoint, :version
    def initialize
      self.api_endpoint = "https://api.bitfinex.com/v1/"
      self.websocket_api_endpoint = "wss://api2.bitfinex.com:3000/ws"
      self.version
      self.debug = false

      self.debug_connection = false
    end

    def switch_to_version num
      case num
      when 1:
        api_endpoint = "https://api.bitfinex.com/v1/"
        websocket_api_endpoint = "wss://api2.bitfinex.com:3000/ws"
        version = 1
      when 2:
        api_endpoint = "https://api.bitfinex.com/v2/"
        websocket_api_endpoint = "wss://api2.bitfinex.com:3000/ws/2"
        version = 2
      else
        raise UnknownVersionException
      end
    end

  end

end
