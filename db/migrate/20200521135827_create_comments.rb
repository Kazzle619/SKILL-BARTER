class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :proposition, null: false, foreign_key: true
      t.text :content
      t.string :image_id

      t.timestamps
    end
  end
end
