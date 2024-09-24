# lib/latest_stock_price/price_all.rb
require 'httparty'

module LatestStockPrice
  class PriceAll
    BASE_URL = 'https://latest-stock-price.p.rapidapi.com/any'
    HEADERS = {
      'x-rapidapi-host' => 'latest-stock-price.p.rapidapi.com',
      'x-rapidapi-key' => 'ec058c7dbfmsha529d0d28cbac27p1b5101jsn854dffba0d9f'
    }

    def self.fetch
      response = HTTParty.get(BASE_URL, headers: HEADERS)
      response.success? ? response.parsed_response : []
    rescue StandardError => e
      Rails.logger.error "Error fetching all stock prices: #{e.message}"
      []
    end
  end
end
