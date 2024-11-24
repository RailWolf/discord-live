require_relative 'common/reader'
require_relative 'quake2/parser'
load 'server-info.cfg'

module Uvula
  Thread.new do
    Fiber.set_scheduler(FiberScheduler.new)
    $server_list.each do |sv|

      if sv.hide_goto
        warn("skipping #{sv.nick}, because hide_goto is set")
        next
      end
      if sv.nick =~ /mnh.*/
        warn("skipping #{sv.nick} in SKIP_LIST")
        next
      end
      log_path = "../dorkbuster/sv/#{sv.nick}/wallfly.log"
      Fiber.schedule { Q2Log::LogReader.new(sv.nick, log_path, 'q2') }
    end
    # Add other server types here
    # ex. doom_server_list.each do...
    # Just use a hash to give it an sv.nick
  end
end
