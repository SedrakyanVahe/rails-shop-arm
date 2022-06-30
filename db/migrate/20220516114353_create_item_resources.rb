class CreateItemResources < ActiveRecord::Migration[6.1]
  def change
    create_table :item_resources do |t|
      t.references :item, foreign_key: { on_delete: :cascade }
      t.string :name, null: false, default: nil
      t.integer :resource_type, null: false, default: 0, limit: 1
      t.text :url, null: true, default: nil

      t.timestamps
    end
  end
end