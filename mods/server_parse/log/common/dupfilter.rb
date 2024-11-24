# frozen_string_literal: true

module Uvula
  module Q2Log
    # Duplicate Filter. Some things like invite! generate too many duplicates.
    class DupFilter
      def initialize(num_lines_memory = 7)
        @n_mem_len = num_lines_memory
        @lines = []
      end

      def accept(line)
        if @lines.include?(line)
          nil
        else
          @lines << line
          @lines.shift while @lines.length > @n_mem_len
          line
        end
      end
    end
    DUPF = DupFilter.new
  end
end
