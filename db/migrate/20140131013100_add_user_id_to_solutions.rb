class AddUserIdToSolutions < ActiveRecord::Migration
  def change
    add_column :solutions, :user_id, :integer
    add_index :solutions, :user_id
  end
end
