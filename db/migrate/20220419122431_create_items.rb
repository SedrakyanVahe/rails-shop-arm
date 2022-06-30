class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.references :category, null: false, default: nil, foreign_key: { on_delete: :cascade }
      t.references :owner, polymorphic: true
      t.string :title, null: false, default: nil
      t.text :description, null: true, default: nil
      t.float :price, null: false, default: 0
      t.integer :countity, null: false, default: 0
      t.json :views, null: true, default: nil
      t.integer :state, null: false, default: 0, limit: 1
      t.json :options, null: true, default: nil

      t.timestamps
    end
  end
end