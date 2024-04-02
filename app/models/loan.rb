class Loan < ApplicationRecord
  belongs_to :user
  belongs_to :admin

  validates :reason, presence: true

  enum status: %i[requested approved rejected open closed]
end
