require 'spec_helper'

RSpec.describe HeyYou::Config::Nexmo do
  before do
    described_class.instance.instance_variable_set(:@configured, false)
    described_class.instance.instance_variable_set(:@client, nil)
  end

  include_examples :singleton

  describe 'attributes' do
    include_examples :have_accessors, :client, :from, :is_unicode, :ttl, :status_report_req, :callback, :response_handler
  end
end