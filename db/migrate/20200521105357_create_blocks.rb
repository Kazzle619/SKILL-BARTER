class CreateBlocks < ActiveRecord::Migration[5.2]
  def change
    create_table :blocks do |t|
      t.references :blocker, null: false, foreign_key: true
      t.references :blocked, null: false, foreign_key: true

      t.timestamps
    end

    add_index :blocks, [:blocker_id, :blocked_id], unique: true
  end
end
