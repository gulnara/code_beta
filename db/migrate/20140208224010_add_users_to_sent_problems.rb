class AddUsersToSentProblems < ActiveRecord::Migration
  def change
    add_column :sent_problems, :user_id, :integer
    add_column :sent_problems, :problem_id, :integer
  end
end
