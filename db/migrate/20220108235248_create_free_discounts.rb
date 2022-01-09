class CreateFreeDiscounts < ActiveRecord::Migration[7.0]
  def change
    create_table :free_discounts do |t|
      t.integer :minimum_items, null: false
      t.integer :free_items, null: false

      t.timestamps
    end
  end
end
