require 'spec_helper'

RSpec.describe HeyYou::Builder::Nexmo do
  include_examples :have_readers, :text, :from, :is_unicode
end