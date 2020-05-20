class CreateBackgroundSchools < ActiveRecord::Migration[5.2]
  def change
    create_table :background_schools do |t|
      t.references :user, null: false, foreign_key: true
      t.string :school_name, null: false
      t.integer :school_type, null: false
      t.string :department
      t.integer :enrollment_status, null: false

      t.timestamps
    end

    add_index :background_schools, :school_name
  end
end
