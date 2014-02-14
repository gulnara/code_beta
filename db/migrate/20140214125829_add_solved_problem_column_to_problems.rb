class AddSolvedProblemColumnToProblems < ActiveRecord::Migration
  def change

  	add_column :problems , :solutions_number, :integer , :default => 0
  end
end
