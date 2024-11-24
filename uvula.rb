require 'rubygems'
require 'bundler/setup'
require 'discordrb'
require 'resolv-replace'
require 'fiber_scheduler'
require_relative 'core/auth'
require_relative 'core/config'
require_relative 'core/discord_colors'
require_relative 'mods/server_parse/router'


module Uvula
  begin
    BOT = Discordrb::Bot.new token: AUTH.token
    BOT.run :async
    BOT.join
  rescue RestClient::ServerBrokeConnection
    retry
  rescue Net::OpenTimeout
    retry
  rescue RestClient::Exceptions::OpenTimeout
    retry
  rescue Discordrb::Errors::MessageTooLong
    puts "MSG Too Long"
    retry
  end
end
