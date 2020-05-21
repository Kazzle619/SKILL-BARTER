class CreateBackgroundJobs < ActiveRecord::Migration[5.2]
  def change
    create_table :background_jobs do |t|
      t.references :user, null: false, foreign_key: true
      t.string :company_name, null: false
      t.string :department
      t.string :position
      t.date :joining_date, null: false
      t.date :retirement_date

      t.timestamps
    end

    add_index :background_jobs, :company_name
    add_index :background_jobs, :department
    add_index :background_jobs, :position
  end
end
