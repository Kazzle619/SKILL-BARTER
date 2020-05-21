class CreateAchievementCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :achievement_categories do |t|
      t.references :achievement, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end

    add_index :achievement_categories, [:achievement_id, :tag_id], unique: true
  end
end
