class AddDiscountsToItem < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :free_discount_id, :integer
    add_column :items, :percentage_discount_id, :integer
  end
end
