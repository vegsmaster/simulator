require 'zlib'

module Simulator
  module Datasources
    module Redis
      ##
      # Redis data serializer
      #
      module Serializer
        def deserialize(value)
          return nil if value.nil?
          binary = Zlib::Inflate.inflate(value)
          Marshal.load(binary)
        rescue
          nil
        end

        def serialize(data)
          Zlib::Deflate.deflate(Marshal.dump(data), Zlib::BEST_COMPRESSION)
        end
      end
    end
  end
end
