class CreateOffers < ActiveRecord::Migration[5.2]
  def change
    create_table :offers do |t|
      t.references :offering, null: false, foreign_key: { to_table: :propositions }, unique: true
      t.references :offered, null: false, foreign_key: { to_table: :propositions }

      t.timestamps
    end
  end
end
