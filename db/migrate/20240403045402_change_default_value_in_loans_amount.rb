class ChangeDefaultValueInLoansAmount < ActiveRecord::Migration[7.1]
  def change
    change_column_default :loans, :amount, 1000
  end
end
