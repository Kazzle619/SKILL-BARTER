class CreatePropositionRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :proposition_rooms do |t|
      t.references :proposition, null: false, foreign_key: true
      t.references :room, null: false, foreign_key: true

      t.timestamps
    end
    add_index :proposition_rooms, [:proposition_id, :room_id], unique: true
  end
end
