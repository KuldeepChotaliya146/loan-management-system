class AddApprovedAtInLoans < ActiveRecord::Migration[7.1]
  def change
    add_column :loans, :calculated_at, :datetime
  end
end
