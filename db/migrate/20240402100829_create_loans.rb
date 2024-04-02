class CreateLoans < ActiveRecord::Migration[7.1]
  def change
    create_table :loans do |t|
      t.text :reason
      t.references :user, null: false, foreign_key: true
      t.references :admin, null: false, foreign_key: true
      t.integer :status, default: 0
      t.integer :interest_rate, default: 5
      t.bigint :amount, default: 0

      t.timestamps
    end
  end
end
