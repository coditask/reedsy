class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :code, null: false
      t.string :name
      t.integer :price

      t.timestamps
    end
  end
end
