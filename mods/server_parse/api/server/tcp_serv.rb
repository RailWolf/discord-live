require 'socket'

module Uvula
  # Server to accept remote incoming chat.
  class UvulaServer
    def initialize
      @sv = SVS.new
      @server = TCPServer.new(CFG.tcp_port)
      run
    end

    def run
      Thread.new do
        loop do
          @client = @server.accept
          while (input = @client.gets)
            puts "Input is: #{input}" unless input.nil?
            # puts "Unpacked Input is: #{input.unpack("a*")}" unless input.nil?
            next if input.nil?
            # input = input.unpack("a*")
            next if input !~ /^uv-((.*\s){3}).*/

            key, @sv.game, @sv.nick, @sv.txt = input.split(' ', 4)
            @sv.txt = @sv.txt.gsub(/\^\d/, '')
            @sv.color1 = :none1
            @sv.color2 = :none2
            next (puts 'key failed') if key != KEY

            DIS.queue << @sv
          end
          @client.close
        end
      end
    end
  end
  US = UvulaServer.new
end
