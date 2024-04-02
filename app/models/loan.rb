class Loan < ApplicationRecord
  belongs_to :user
  belongs_to :admin

  validates :reason, presence: true
  validates :interest_rate, numericality: { greater_than: 0 }

  enum status: %i[requested approved open closed rejected]
end
