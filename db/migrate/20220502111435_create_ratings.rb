class CreateRatings < ActiveRecord::Migration[6.1]
  def change
    create_table :ratings do |t|
      t.references :user, foreign_key: { on_delete: :cascade }
      t.references :item, foreign_key: { on_delete: :cascade }
      t.integer :value, null: true, default: nil

      t.timestamps
    end
  end
end