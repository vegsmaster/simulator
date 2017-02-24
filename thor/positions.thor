require 'thor'
require 'csv'
require 'simulator/models/position'
require 'simulator/datasources/redis/positions'

class Positions < Thor

  desc 'provision', 'provision positions in redis from a file'
  def provision(path_to_file)
    positions_by_date = {}
    CSV.foreach(path_to_file) do |row|
      position = Simulator::Models::Position.new(
        created_at: row.first,
        shuttle_id: row[1],
        lat: row[2],
        long: row[3],
        track_id: row[4],
        ref_ratio: false
      )
      if positions_by_date.key?(position.created_at.to_time.to_i)
        positions_by_date[position.created_at.to_time.to_i] << position.to_h
      else
        positions_by_date[position.created_at.to_time.to_i] = [position.to_h]
      end
    end
    Simulator::Datasources::Redis::Positions.new.create(positions_by_date)
  end
end
