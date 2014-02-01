class AddSolutionIdToProblems < ActiveRecord::Migration
  def change
    add_column :problems, :solution_id, :integer
  end
end
