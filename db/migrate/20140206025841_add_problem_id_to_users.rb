class AddProblemIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :problem_id, :integer
  end
end
