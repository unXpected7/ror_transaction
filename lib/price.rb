module LatestStockPrice
    class Price
      BASE_URL = 'https://api.example.com/stock'
  
      def self.fetch(symbol)
        response = HTTParty.get("#{BASE_URL}/price?symbol=#{symbol}")
        response.parsed_response if response.success?
      rescue StandardError => e
        Rails.logger.error "Error fetching stock price: #{e.message}"
        nil
      end
    end
  end
  