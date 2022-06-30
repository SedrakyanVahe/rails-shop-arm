class CreateCarts < ActiveRecord::Migration[6.1]
  def change
    create_table :user_items do |t|
      t.references :user, index: true, foreign_key: { on_delete: :cascade }
      t.references :item, index: true, foreign_key: { on_delete: :cascade }
      t.datetime :ordered_at, null: true, default: nil

      t.timestamps
    end
  end
end