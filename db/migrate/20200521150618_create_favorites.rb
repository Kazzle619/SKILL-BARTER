class CreateFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :favorites do |t|
      t.references :user, null: false, foreign_key: true
      t.references :proposition, null: false, foreign_key: true

      t.timestamps
    end

    add_index :favorites, [:user_id, :proposition_id], unique: true
  end
end
