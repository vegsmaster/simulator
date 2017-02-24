require 'typhoeus'
require 'simulator/datasources/redis/positions'
require 'multi_json'
module Simulator
  class Launcher

    def execute
      positions_by_date = redis.find_all[0..59]
      return if positions_by_date.empty?
      send_requests(positions_by_date)
    end

    private

    def send_requests(positions_by_date)
      $stderr.puts 'new'
      $stderr.puts Time.now
      Typhoeus::Config.user_agent = 'FWS-SIMULATOR'
      hydra = Typhoeus::Hydra.new
      positions_by_date.each do |positions|
        positions.map do |position|
          hydra.queue(
            Typhoeus::Request.new(
              ENV['FORUM_GO_URL'],
              method: :post,
              body: MultiJson.dump({ position: position }),
              headers: { 'Content-Type' => 'application/json' }
            )
          )
        end
        hydra.run
      end
      send_requests(positions_by_date)
    end

    def redis
      @redis ||= Datasources::Redis::Positions.new
    end
  end
end

