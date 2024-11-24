require_relative 'cfg/config'
require_relative 'log/log_reader_thread'
require_relative 'discord_send'
require_relative 'log/common/dupfilter'
require_relative 'api/server/tcp_serv'

module Uvula


  class LogRouter
    attr_accessor :queue

    def initialize
      @queue = Queue.new
      @queued = false
      queue_loop
    end

    def queue_loop
      Thread.new do
        loop do
          next if @queued

          # puts @queue.length
          event = @queue.pop
          # puts 'queue popped'
          run(event)
        end
      end
      end

    def run(event)
      @queued = true
      case event.game
      when 'q2' then Uvula::Q2Log::Q2PARSE.run(event)
      when 'ql' then puts 'ql'
      end
      @queued = false
    end
  end
  ROUTER = LogRouter.new
end
