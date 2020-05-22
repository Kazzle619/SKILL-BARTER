class ChangeUserStatusColumnOnUser < ActiveRecord::Migration[5.2]
  def change
    change_column_null :users, :user_status, true
  end
end
