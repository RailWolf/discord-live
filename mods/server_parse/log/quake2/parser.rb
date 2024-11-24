require_relative 'filters'


module Uvula
  module Q2Log

    class ParseQ2Log

      def run(event)
        @event = event
        type, txt = parse_wallfly_line
        return unless !type.nil? && !txt.to_s.strip.empty?

        @out, @color1, @color2 = filter_and_colorize(type, txt)
        send if !@out.nil? && DUPF.accept(txt) && !@color1.nil?

        # send
      end

      def parse_wallfly_line
        # [2005-09-05 Mon 12:13:54] 1=Miami was popped by Seth's grenade
        # I think what bill did here was make the type a match group for the $1.
        [$1.to_i, $2] if @event.txt =~ /\A\[\d\d\d\d-\d\d-\d\d\s\w\w\w\s\d\d:\d\d:\d\d\]\s([123])=(.*)\z/
      end

      def filter_and_colorize(type, txt)
        return nil if txt =~ CHAT_FILTER

        case type
        when 1
          if txt =~ /name-+fph-+minutes-+frags|\s+\d+\s+\d+\.\d+\s+\d+/
            @event.color1 = :green1
            @event.color2 = :green2
            @out = txt
          end
        when 2
          @out = nil
          @color1 = nil
        when 3
          case txt
          when /\Aconsole:/
            @event.color1 = :red1
            @event.color2 = :red2
          when /\AWallFly\[BZZZ\]:/
            @event.color1 = :yellow1
            @event.color2 = :yellow2
          when CHAT_HILITE
            @event.color1 = :orange1
            @event.color2 = :orange2
          else
            @event.color1 = :none1
            @event.color2 = :none2
          end
          @out = txt
        else
          @out = nil
          @color1 = nil
        end
        [@out, @event.color1, @event.color2]
      end

      def send
        @event.txt = @out
        DIS.queue << @event
      end
    end
    Q2PARSE = ParseQ2Log.new
  end
end

