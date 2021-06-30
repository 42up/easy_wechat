require "easy_wechat/version"
require "easy_wechat/client"
require "easy_wechat/configuration"

require "httpx"

module EasyWechat
  class Error < StandardError; end
  def self.configuration
    @configuration ||= Configuration.new
  end

  class << self
    attr_writer :configuration

    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end

    def app_id
      configuration.app_id
    end

    def app_secret
      configuration.app_secret
    end
  end
end
