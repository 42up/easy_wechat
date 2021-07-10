module EasyWechat
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc "EasyWechat installation: initializer"
      source_root File.expand_path("../../templates", __FILE__)

      def install
        puts "==> generate initializer file ..."
        copy_initializer
        puts "Done!"
      end

      private

      def copy_initializer
        template "initializer.rb", "config/initializers/easy_wechat.rb"
      end
    end
  end
end
