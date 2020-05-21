class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.references :user, null: false, foreign_key: true
      t.references :proposition, null: false, foreign_key: true
      t.text :comment, null: false

      t.timestamps
    end

    add_index :reviews, [:user_id, :proposition_id], unique: true
  end
end
