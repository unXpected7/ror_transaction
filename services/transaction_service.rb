class TransactionService
    def self.transfer(source_wallet:, target_wallet:, amount:)
      ApplicationRecord.transaction do
        raise 'Insufficient funds' if source_wallet.balance < amount
  
        Transaction.create!(
          source_wallet: source_wallet,
          target_wallet: target_wallet,
          amount: amount,
          transaction_type: 'Debit'
        )
  
        Transaction.create!(
          source_wallet: nil,
          target_wallet: target_wallet,
          amount: amount,
          transaction_type: 'Credit'
        )
      end
    rescue StandardError => e
      # Handle errors, log, or notify
      raise ActiveRecord::Rollback, e.message
    end
  end
  