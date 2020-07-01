require 'spec_helper'
require 'byebug'

RSpec.describe HeyYou::Channels::Nexmo do
  let!(:api_key) { SecureRandom.uuid }
  let!(:api_secret) { SecureRandom.uuid }
  let!(:from) { 'RubyTest' }
  let!(:client) do
    Nexmo::Client.new(api_key: api_key, api_secret: api_secret)
  end
  let!(:to) { FFaker::PhoneNumber.phone_number }
  let!(:config) { HeyYou::Config.instance }

  before(:each) do
    config.splitter = '.'
    config.registered_channels = [:nexmo]
    config.data_source.options = { collection_files: ['spec/fixtures/notifications.yml'] }
    config.nexmo.client = client
    config.nexmo.from = from
    config.nexmo.status_report_req = false
  end

  let!(:builder) { HeyYou::Builder.new(notification_key, pass_variable: FFaker::Lorem.word) }

  describe 'send!' do
    let!(:notification_key) { 'rspec.test_notification' }

    subject { described_class.send!(builder, to: to) }

    context 'pass :to option' do
      let!(:to) { FFaker::PhoneNumber.phone_number }

      it 'send sms via nexmo' do
        expect_any_instance_of(Nexmo::SMS).to receive(:send).with(
          text: builder.nexmo.text,
          from: from,
          to: to,
          status_report_req: HeyYou::Config.instance.nexmo.status_report_req,
          ttl: HeyYou::Config.instance.nexmo.ttl
        )

        subject
      end
    end

    context 'without :to option' do
      let!(:to) { nil }

      it 'raise CredentialsNotExists' do
        expect { subject }.to raise_error(HeyYou::Channels::Nexmo::CredentialsNotExists)
      end
    end

    context 'with from in builder' do
      let!(:notification_key) { 'rspec.test_notification_with_from' }

      it 'send sms via nexmo' do
        expect_any_instance_of(Nexmo::SMS).to receive(:send).with(
          text: builder.nexmo.text,
          from: builder.nexmo.from,
          to: to,
          status_report_req: HeyYou::Config.instance.nexmo.status_report_req,
          ttl: HeyYou::Config.instance.nexmo.ttl
        )

        subject
      end
    end

    context 'with is_unicode in builder' do
      let!(:notification_key) { 'rspec.test_notification_unicode' }

      it 'send sms via nexmo' do
        expect_any_instance_of(Nexmo::SMS).to receive(:send).with(
          text: builder.nexmo.text,
          from: from,
          to: to,
          status_report_req: HeyYou::Config.instance.nexmo.status_report_req,
          ttl: HeyYou::Config.instance.nexmo.ttl,
          type: 'unicode'
        )

        subject
      end
    end

    context 'with `status_report_req` as true' do
      context 'callback was passed' do
        let!(:callback_url) { FFaker::Internet.http_url }

        it 'send sms via nexmo' do
          config.nexmo.status_report_req = true
          config.nexmo.callback = callback_url

          expect_any_instance_of(Nexmo::SMS).to receive(:send).with(
            text: builder.nexmo.text,
            from: from,
            to: to,
            status_report_req: HeyYou::Config.instance.nexmo.status_report_req,
            callback: callback_url,
            ttl: HeyYou::Config.instance.nexmo.ttl
          )

          subject
        end
      end

      context 'callback was not passed' do
        before {  }

        it 'raise CredentialsNotExists' do
          config.nexmo.status_report_req = true
          config.nexmo.callback = nil

          expect { subject }.to raise_error(HeyYou::Channels::Nexmo::CredentialsNotExists)
        end
      end
    end

    context 'when client was not set' do
      before do
        HeyYou::Config::Nexmo.instance.instance_variable_set(:@client, nil)
      end

      it 'raise CredentialsNotExists' do
        expect { subject }.to raise_error(HeyYou::Channels::Nexmo::CredentialsNotExists)
      end
    end

    context 'when `from` was not set' do
      let!(:from) { nil }

      before do
        HeyYou::Config::Nexmo.instance.instance_variable_set(:@from, nil)
      end

      it 'raise CredentialsNotExists' do
        expect { subject }.to raise_error(HeyYou::Channels::Nexmo::CredentialsNotExists)
      end
    end
  end
end