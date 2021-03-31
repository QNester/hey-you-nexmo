require 'spec_helper'

RSpec.describe HeyYou::Builder::Nexmo do
  include_examples :have_readers, :text, :from, :is_unicode

  describe '#build' do
    let!(:key) { 'key' }
    let!(:code) { '123456' }
    let!(:ch_data) { { 'text' => 'Your code %{code}' } }
    let!(:options) { { code: code } }

    subject { described_class.new(ch_data, key, options) }

    it 'returns interpolated text' do
      expect(subject.text).to eq(ch_data['text'] % { code: code })
    end

    context 'pass google_autofill_code_hash' do
      let!(:autofill_hash) { SecureRandom.uuid }
      let!(:options) { { code: code, google_autofill_code_hash: autofill_hash } }

      it 'returns interpolated string with autofill hash' do
        expected_result = ch_data['text'] % { code: code }
        expected_result << "\n\n#{autofill_hash}"
        expect(subject.text).to eq(expected_result)
      end
    end
  end
end