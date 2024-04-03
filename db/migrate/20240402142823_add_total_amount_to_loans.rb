class AddTotalAmountToLoans < ActiveRecord::Migration[7.1]
  def change
    add_column :loans, :total_amount, :bigint, default: 0
  end
end
