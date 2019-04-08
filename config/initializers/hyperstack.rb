# config/initializers/hyperstack.rb
# If you are not using ActionCable, see http://hyperstack.orgs/docs/models/configuring-transport/
Hyperstack.configuration do |config|
  config.transport = :action_cable
  config.prerendering = :off # or :on
  config.hotloader_ping = 10 # seconds
  config.cancel_import 'react/react-source-browser' # bring your own React and ReactRouter via Yarn/Webpacker
  config.import 'hyperstack/component/jquery', client_only: true # remove this line if you don't need jquery
  config.import 'hyperstack/hotloader', client_only: true if Rails.env.development?
end

# useful for debugging
module Hyperstack
  def self.on_error(operation, err, params, formatted_error_message)
    ::Rails.logger.debug(
      "#{formatted_error_message}\n\n" +
      Pastel.new.red(
        'To further investigate you may want to add a debugging '\
        'breakpoint to the on_error method in config/initializers/hyperstack.rb'
      )
    )
  end
end if Rails.env.development?

module ReactiveRecord
  class Broadcast
    def self.send_to_server(operation, data)
      salt = SecureRandom.hex
      authorization = Hyperstack.authorization(salt, data[:channel], data[:broadcast_id])
      raise 'no server running' unless Hyperstack::Connection.root_path
      root_path = Hyperstack::Connection.root_path
      if root_path =~ /^https:\/\/(\d+)-[a-f0-9\-]+\.[^\/]+\/(.+)\/$/
        root_path = "http://127.0.0.1:#{$1}/#{$2}"
      end
      SendPacket.remote(
        root_path,
        data,
        operation: operation,
        salt: salt,
        authorization: authorization
      ).tap { |p| raise p.error if p.rejected? }
    end
  end
end