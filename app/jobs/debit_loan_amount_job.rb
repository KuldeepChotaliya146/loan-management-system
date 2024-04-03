class DebitLoanAmountJob < ApplicationJob
  def perform
    Loan.open.each do |loan|
      admin = loan.admin
      user = loan.user
      if loan.total_amount > user.wallet_balance
        amount_to_pay = user.wallet_balance
        ActiveRecord::Base.transaction do
          user.remove_amount(amount_to_pay)
          Admin.first.add_amount(amount_to_pay)
          loan.update(status: :closed)
        end
      end
    end
  end
end
