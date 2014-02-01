class RemoveSolutionIdFromProblems < ActiveRecord::Migration
  def change
    remove_column :problems, :solution_id, :integer
  end
end
