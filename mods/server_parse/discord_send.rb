module Uvula
  class Disc
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

          event = @queue.pop
          go(event)
        end
      end
    end

    def go(event)
      @queued = true
      CFG.channels.each do |_n, c|
        BOT.send_message(c, COLOR.color_get(event.color1).to_s + "(#{event.nick}) " + event.txt.to_s + COLOR.color_get(event.color2).to_s, tts = false, embed = nil)
      end
      @queued = false
    end
  end
  DIS = Disc.new
end
