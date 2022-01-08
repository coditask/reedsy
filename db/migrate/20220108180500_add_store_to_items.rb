class AddStoreToItems < ActiveRecord::Migration[7.0]
  def change
    add_reference :items, :store, null: false, foreign_key: true
  end
end
