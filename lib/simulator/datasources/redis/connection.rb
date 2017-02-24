require 'redis'
module Simulator
  module Datasources
    module Redis
      module Connection
        def client
          ::Redis.current ||= Redis.new(url: ENV['REDIS_URL'])
        end
      end
    end
  end
end
