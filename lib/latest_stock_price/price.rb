# lib/latest_stock_price/price.rb
require 'httparty'

module LatestStockPrice
  class Price
    BASE_URL = 'https://latest-stock-price.p.rapidapi.com/any'
    HEADERS = {
      'x-rapidapi-host' => 'latest-stock-price.p.rapidapi.com',
      'x-rapidapi-key' => 'ec058c7dbfmsha529d0d28cbac27p1b5101jsn854dffba0d9f'
    }

    def self.fetch(symbol)
      response = HTTParty.get(BASE_URL, headers: HEADERS)
      return unless response.success?

      data = response.parsed_response
      data.find { |stock| stock['symbol'] == symbol }
    rescue StandardError => e
      Rails.logger.error "Error fetching stock price: #{e.message}"
      nil
    end
  end
end
