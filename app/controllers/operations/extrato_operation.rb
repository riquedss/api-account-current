# frozen_string_literal: true

module Operations
  class ExtratoOperation
    def self.extrato(checking_account)
      @transfer = Transfer.where(checking_account_id: checking_account.id)
      @operation = Operation.where(checking_account_id: checking_account.id)
      @extrato = @transfer + @operation
      ordena_extrato_by_time
    end

    def self.ordena_extrato_by_time
      @extrato.sort_by { |elemento| -elemento[:created_at].to_f }
    end
  end
end
