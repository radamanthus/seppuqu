require "seppuqu/version"
require 'sidekiq'

module Seppuqu
  def install
    Sidekiq.class_exec{
      def self.current_release_version
        @current_release_version ||= File.expand_path(__FILE__).scan(/\d{10,}/).map(&:to_i)[0]
      end

      def self.latest_release_version
        Sidekiq.redis do |conn|
          conn.get("release_version") || -1
        end.to_i
      end
    }

    Sidekiq::Middleware.class_exec{
      Object.const_set("VersionEnforcerMiddleware", Class.new{
        def call(worker, msg, queue)
          lrv, crv = Sidekiq.latest_release_version, Sidekiq.current_release_version
          if lrv <= crv
            yield
          elsif
            Sidekiq.logger.info "My version (#{crv}) mismatches latest version (#{lrv}). Shutting down..."
            Thread.main.raise Interrupt
          end
        end
      })
    }

    Sidekiq.configure_server do |config|
      config.server_middleware do |chain|
        chain.add Sidekiq::Middleware::VersionEnforcerMiddleware
      end
    end
  end
  module_function :install

  def update_release_version
    Sidekiq.redis {|c| c.set "release_version", Sidekiq.current_release_version }
  end
  module_function :update_release_version
end
