require 'rails'

module Systemjs
  module Rails

    class Reloader
      def self.on_change(watch_files, &block)
        @@file_checker = ActiveSupport::FileUpdateChecker.new(watch_files, &block)
      end

      def initialize(app)
        @app = app
      end

      def call(env)
        execute_if_updated!
        @app.call(env)
      end

      private

      def execute_if_updated!
        @@file_checker.execute_if_updated if @@file_checker
      end
    end

  end
end
