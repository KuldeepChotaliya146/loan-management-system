class Loan < ApplicationRecord
  belongs_to :user
  belongs_to :admin

  validates :reason, presence: true
  validates :interest_rate, numericality: { greater_than: 0 }
  validates :amount, numericality: { greater_than: 0 }

  enum status: %i[requested approved open closed rejected]

  def calculate_interest_and_update
    time_elapsed = (Time.now - calculated_at) / 1.minute
    interest = amount * interest_rate * time_elapsed / (100.0 * 60.0)

    # Update loan amount with interest
    update(total_amount: amount + interest, calculated_at: Time.now)
  end
end
