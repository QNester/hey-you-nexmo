require 'json'

module HeyYou
  class Config
    class Nexmo
      extend Configurable
      DEFAULTS = {
        is_unicode: false,
        status_report_req: false,
        ttl: 259200000 # 72 hours
      }.freeze

      attr_accessor :client, :from, :is_unicode, :ttl, :status_report_req, :callback, :response_handler

      def initialize
        @is_unicode = DEFAULTS[:is_unicode]
        @status_report_req = DEFAULTS[:status_report_req]
        @ttl = DEFAULTS[:ttl]
      end
    end
  end
end