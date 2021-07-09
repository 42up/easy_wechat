require "httpx"
require "http/form_data"
require "json"
require "active_support"

module EasyWechat
  class Client
    TOKEN_URL = "https://api.weixin.qq.com/cgi-bin/token"
    BATCHGET_MATERIAL_URL = "https://api.weixin.qq.com/cgi-bin/material/batchget_material"
    UPLOADIMG_URL = "https://api.weixin.qq.com/cgi-bin/media/uploadimg"
    ADD_NEWS_URL = "https://api.weixin.qq.com/cgi-bin/material/add_news"
    GET_USER_SUMMARY_URL = "https://api.weixin.qq.com/datacube/getusersummary"
    GET_USER_CUMULATE_URL = "https://api.weixin.qq.com/datacube/getusercumulate"

    def initialize
    end

    def access_token
      @access_token ||= token["access_token"]
    end

    def get_user_summary(begin_date, end_date)
      payload = { begin_date: begin_date, end_date: end_date }

      resp = HTTPX.post(GET_USER_SUMMARY_URL, params: { access_token: access_token }, json: payload)

      r = ::JSON.parse(resp.body, quirks_mode: true)
      yield r if block_given?
      r
    end

    def get_user_cumulate(begin_date, end_date)
      payload = { begin_date: begin_date, end_date: end_date }

      resp = HTTPX.post(GET_USER_CUMULATE_URL, params: { access_token: access_token }, json: payload)

      r = ::JSON.parse(resp.body, quirks_mode: true)
      yield r if block_given?
      r
    end

    # 获取access_token
    # https://developers.weixin.qq.com/doc/offiaccount/Basic_Information/Get_access_token.html
    def token
      resp = HTTPX.get(TOKEN_URL, params: {
                                    appid: EasyWechat.app_id,
                                    secret: EasyWechat.app_secret,
                                    grant_type: "client_credential",
                                  })

      r = ::JSON.parse(resp.body, quirks_mode: true)
      yield r if block_given?
      r
    end

    # 上传图文消息内的图片获取URL
    # https://developers.weixin.qq.com/doc/offiaccount/Asset_Management/Adding_Permanent_Assets.html
    def uploadimg(media)
      # https://honeyryderchuck.gitlab.io/httpx/wiki/Multipart-Uploads.html#notes
      file = if media.is_a?(String) ? HTTP::FormData::File.new(media) : meida
          resp = HTTPX.plugin(:multipart).post(UPLOADIMG_URL, params: { access_token: access_token }, form: { media: file })

          r = ::JSON.parse(resp.body, quirks_mode: true)
          yield r if block_given?
          r
        end

      # 获取永久素材的列表
      # https://developers.weixin.qq.com/doc/offiaccount/Asset_Management/Get_materials_list.html
      def batchget_material(type = "image", offset = 0, count = 20)
        # TODO: 检查参数完整性
        # TODO: 检查参数合法性
        payload = { type: type, offset: offset, count: count }

        resp = HTTPX.post(BATCHGET_MATERIAL_URL, params: { access_token: access_token }, json: payload)

        r = ::JSON.parse(resp.body, quirks_mode: true)
        yield r if block_given?
        r
      end

      # 新增永久图文素材
      # https://developers.weixin.qq.com/doc/offiaccount/Asset_Management/Adding_Permanent_Assets.html
      def add_news(articles)
        payload = { articles: articles }

        resp = HTTPX.post(ADD_NEWS_URL, params: { access_token: access_token }, json: payload)

        r = ::JSON.parse(resp.body, quirks_mode: true)
        yield r if block_given?
        r
      end

      def menu_create
        raise NotImplementedError
      end
    end
  end
end
