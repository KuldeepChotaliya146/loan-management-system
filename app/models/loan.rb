class Loan < ApplicationRecord
  belongs_to :user
  belongs_to :admin

  validates :reason, presence: true
  validates :interest_rate, numericality: { greater_than: 0 }
  validates :amount, numericality: { greater_than: 0 }

  enum status: %i[requested approved open closed rejected]

  def calculate_interest_and_update
    time_period_in_years = 5.minutes.to_f / 1.year.to_f # Convert 5 minutes to years
    updated_interest_rate = interest_rate / 100.0
    total_amount = amount * Math.exp(updated_interest_rate * time_period_in_years)
    p "total_amount---->#{total_amount}"
    update(total_amount:)
  end
end
