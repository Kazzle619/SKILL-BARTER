class CreateRequestCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :request_categories do |t|
      t.references :proposition, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end

    add_index :request_categories, [:proposition_id, :tag_id], unique: true
  end
end
