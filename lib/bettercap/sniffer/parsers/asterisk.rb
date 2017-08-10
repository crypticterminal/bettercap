=begin

BETTERCAP

Author : Simone 'evilsocket' Margaritelli
Email  : evilsocket@gmail.com
Blog   : https://www.evilsocket.net/

This project is released under the GPL 3 license.

=end

module BetterCap
module Parsers
# Asterisk Call Manager authentication parser.
class Asterisk  < Base
  def initialize
    @name = 'Asterisk'
  end
  def on_packet( pkt )
    begin
      if pkt.tcp_dst == 5038
        if pkt.to_s =~ /action:\s+login\r?\n/i
          if pkt.to_s =~ /username:\s+(.+?)\r?\n/i && pkt.to_s =~ /secret:\s+(.+?)\r?\n/i
            user = pkt.to_s.scan(/username:\s+(.+?)\r?\n/i).flatten.first
            pass = pkt.to_s.scan(/secret:\s+(.+?)\r?\n/i).flatten.first
            StreamLogger.log_raw( pkt, @name, "username=#{user} password=#{pass}" )
          end
        end
      end
    rescue
    end
  end
end
end
end
