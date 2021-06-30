module EasyWechat
  class Configuration
    attr_accessor :app_id, :app_secret

    def initialize
      @app_id = ""
      @app_secret = ""
    end
  end
end
