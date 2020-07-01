require 'hey-you'
require 'hey_you_nexmo/version'
require_relative 'hey_you/config/nexmo'
require_relative 'hey_you/builder/nexmo'
require_relative 'hey_you/channels/nexmo'

module HeyYouNexmo
  CHANNEL_NAME = 'nexmo'.freeze

  HeyYou::Config.instance.registrate_channel(CHANNEL_NAME)
end
