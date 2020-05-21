class CreateUserPrefectures < ActiveRecord::Migration[5.2]
  def change
    create_table :user_prefectures do |t|
      t.references :user, null: false, foreign_key: true
      t.references :prefecture, null: false, foreign_key: true

      t.timestamps
    end

    add_index :user_prefectures, [:user_id, :prefecture_id], unique: true
  end
end
