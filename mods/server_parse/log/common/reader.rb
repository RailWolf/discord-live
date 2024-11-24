module Uvula
  module Q2Log
    class LogReader

      def initialize(nick, logpath, game)
        @logpath = logpath
        @reader = SVS.new
        @reader.game = game
        @reader.nick = nick
        log_reader
      end

      def log_reader
        IO.popen("tail -n1 -f #{@logpath}") do |io|
          while (line = io.gets)
            line.chop!

            line = line.split(/\n/)
            # TODO: ... Need fixes below for a multi-game reader
            next unless @reader.game == 'q2'

            line.each do |line|
              next unless line =~ /\A\[\d\d\d\d-\d\d-\d\d\s\w\w\w\s\d\d:\d\d:\d\d\]\s([123])=(.*)\z/

              # puts "Line is: #{line}"
              @reader.txt = line
              ROUTER.queue << @reader
            end

          end
          rescue
            sleep 1
            retry
        end
      end
    end
  end
end
