require 'simulator/datasources/redis/connection'
require 'simulator/datasources/redis/serializer'
module Simulator
  module Datasources
    module Redis
      ##
      # Positions datasource
      class Positions
        include Serializer
        include Connection

        POSITIONS_KEY = 'simu:positions'.freeze

        def create(positions)
          positions.each do |key, value|
            client.zadd(
              POSITIONS_KEY,
              key,
              serialize(value)
            )
          end
        end

        def find_all
          result = client.zrange(POSITIONS_KEY, 0, -1)
          result.map { |value| deserialize(value) }
        end
      end
    end
  end
end
