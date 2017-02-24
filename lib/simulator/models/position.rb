module Simulator
  module Models
    ##
    # Position Model
    class Position
      attr_reader :lat, :long, :shuttle_id, :track_id, :created_at, :ref_ratio

      def initialize(data)
        @lat = data[:lat]
        @long = data[:long]
        @shuttle_id = data[:shuttle_id]
        @track_id = data[:track_id]
        @created_at = DateTime.parse(data[:created_at])
        @ref_ratio = data[:ref_ratio]
      end

      def to_h
       {}.tap do |result|
          result[:type] = 'Feature'
          result[:geometry] = {}
          result[:geometry][:type] = 'Point'
          result[:geometry][:coordinates] = [@long, @lat]
          result[:properties] = {
            speed: 7,
            time: format_date(@created_at),
            name: @shuttle_id,
            refRatio: @ref_ratio
          }
          if @track_id
            result[:properties][:track] = {
              id: @track_id
            }
          end
        end
      end

      private

      def format_date(date)
        date.strftime("%d-%m-%YT%H:%M:%SGMT%:z")
      end
    end
  end
end
