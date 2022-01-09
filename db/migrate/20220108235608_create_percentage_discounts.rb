class CreatePercentageDiscounts < ActiveRecord::Migration[7.0]
  def change
    create_table :percentage_discounts do |t|
      t.integer :minimum_items, null: false
      t.integer :discounted_items, null: false
      t.integer :percentage, null: false

      t.timestamps
    end
  end
end
