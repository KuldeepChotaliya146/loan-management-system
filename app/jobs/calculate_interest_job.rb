class CalculateInterestJob < ApplicationJob
  def perform
    Loan.open.each do |loan|
      loan.calculate_interest_and_update
    end
  end
end
