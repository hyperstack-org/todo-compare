class HyperComponent
  include Hyperstack::Component
  include Hyperstack::State::Observable
end

module Hyperstack
    class Hotloader
        def connect_to_websocket(port)
            if `window.location.host` =~ /\d+-([a-f0-9\-]+\..+\.gitpod.io)/
              ws_url = "#{port}-#{$1}"
            else
              host = `window.location.host`.sub(/:\d+/, '')
              host = '127.0.0.1' if host == ''
              ws_url = "#{host}"
            end
            puts "Hot-Reloader connecting to #{ws_url}"
            protocol = `window.location.protocol` == 'https:' ? 'wss:' : 'ws:'
            ws = `new WebSocket(#{protocol} + '//' + #{ws_url})`
            `#{ws}.onmessage = #{lambda { |e| reload(e) }}`
            `setInterval(function() { #{ws}.send('') }, 10000)` if @ping
        end
    end
end