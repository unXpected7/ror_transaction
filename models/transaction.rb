class Transaction < ApplicationRecord
    belongs_to :source_wallet, class_name: 'Wallet', optional: true
    belongs_to :target_wallet, class_name: 'Wallet', optional: true
  
    validate :validate_wallets
    validates :amount, numericality: { greater_than: 0 }
  
    after_create :update_wallet_balances
  
    private
  
    def validate_wallets
      if source_wallet.nil? && target_wallet.nil?
        errors.add(:base, 'Source or Target wallet must be present')
      end
    end
  
    def update_wallet_balances
      source_wallet&.update_balance!
      target_wallet&.update_balance!
    end
  end
  