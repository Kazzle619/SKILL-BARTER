class CreateAchievements < ActiveRecord::Migration[5.2]
  def change
    create_table :achievements do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false
      t.text :introduction, null: false
      t.string :image_id

      t.timestamps
    end
  end
end
