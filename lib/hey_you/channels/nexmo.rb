require 'nexmo'

module HeyYou
  module Channels
    class Nexmo < Base
      class ResponseError < StandardError; end
      class CredentialsNotExists < StandardError; end

      ERROR_MESSAGES = {
        from_required: 'You must pass `from` globally (to configure) or in your notifications',
        config_required: 'You must pass `{%{options}}` to `configure``',
        to_required: 'You must pass `to` as option. Can not send sms to nowhere.',
        callback_required: 'You must pass `callback` to `configure` if `status_report_req` is true'
      }.freeze

      class << self
        # @param [HeyYou::Builder] builder - builder with notifications texts and settings=
        # @option [String/Symbol] to - msisdn receiver
        def send!(builder, **options)
          raise CredentialsNotExists, ERROR_MESSAGES[:config_required] % { options: required_credentials } unless credentials_present?
          raise CredentialsNotExists, ERROR_MESSAGES[:to_required] unless options[:to]

          params = build_params(builder, **options)

          config.nexmo.client.sms.send(params)
        rescue ::Nexmo::Error => e
          fail ResponseError, e
        end

        private

        def build_params(builder, **options)
          from = builder.nexmo.from || config.nexmo.from

          raise CredentialsNotExists, ERROR_MESSAGES[:from_required] unless from

          if config.nexmo.status_report_req && !config.nexmo.callback
            raise CredentialsNotExists, ERROR_MESSAGES[:callback_required]
          end

          params = {
            from: from,
            to: options[:to],
            text: builder.nexmo.text,
            status_report_req: config.nexmo.status_report_req,
            ttl: config.nexmo.ttl
          }

          params.merge!(type: 'unicode') if builder.nexmo.is_unicode || config.nexmo.is_unicode
          params.merge!(callback: config.nexmo.callback) if params[:status_report_req]

          params
        end

        def required_credentials
          %i[client]
        end
      end
    end
  end
end