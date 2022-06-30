class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.references :parent, index: true, null: true, default: nil
      t.string :name, null: false, default: nil
      t.json :owner, default: nil
      t.json :options, default: nil

      t.timestamps
    end
  end
end