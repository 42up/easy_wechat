require "pry"

RSpec.describe EasyWechat do
  it "has a version number" do
    expect(EasyWechat::VERSION).not_to be nil
  end

  describe "a specification" do
    before do
      @app_id = "test_app_id"
      @app_secret = "test_app_secret"

      EasyWechat.configure do |config|
        config.app_id = @app_id
        config.app_secret = @app_secret
      end

      @client = EasyWechat::Client.new
    end

    it "get_user_summary" do
      begin_date = "2021-07-02"
      end_date = "2021-07-08"

      ret = @client.get_user_summary(begin_date, end_date)

      expect(ret.keys).to contain_exactly("list")
    end

    it "get_user_cumulate" do
      begin_date = "2021-07-02"
      end_date = "2021-07-08"

      ret = @client.get_user_cumulate(begin_date, end_date)
      expect(ret.keys).to contain_exactly("list")
    end
  end
end
