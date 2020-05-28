class ChangeBarterStatusColumnOnProposition < ActiveRecord::Migration[5.2]
  def change
    change_column_null :propositions, :barter_status, true
  end
end
