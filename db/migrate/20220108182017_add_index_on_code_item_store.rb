class AddIndexOnCodeItemStore < ActiveRecord::Migration[7.0]
  def change
    add_index :items, [:code, :store_id], unique: true
  end
end
