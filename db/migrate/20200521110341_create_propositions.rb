class CreatePropositions < ActiveRecord::Migration[5.2]
  def change
    create_table :propositions do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false
      t.text :introduction, null: false
      t.date :deadline
      t.integer :barter_status,null: false, default: 1
      t.string :rendering_image_id

      t.timestamps
    end

    add_index :propositions, :title
    add_index :propositions, :introduction
    add_index :propositions, :deadline
    add_index :propositions, :barter_status
  end
end
