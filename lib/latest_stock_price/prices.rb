# lib/latest_stock_price/prices.rb
require 'httparty'

module LatestStockPrice
  class Prices
    BASE_URL = 'https://latest-stock-price.p.rapidapi.com/any'
    HEADERS = {
      'x-rapidapi-host' => 'latest-stock-price.p.rapidapi.com',
      'x-rapidapi-key' => 'ec058c7dbfmsha529d0d28cbac27p1b5101jsn854dffba0d9f'
    }

    def self.fetch(symbols)
      response = HTTParty.get(BASE_URL, headers: HEADERS)
      return unless response.success?

      data = response.parsed_response
      data.select { |stock| symbols.include?(stock['symbol']) }
    rescue StandardError => e
      Rails.logger.error "Error fetching stock prices: #{e.message}"
      []
    end
  end
end
