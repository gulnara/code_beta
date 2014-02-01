class AddLevelToProblems < ActiveRecord::Migration
  def change
    add_column :problems, :level, :string
  end
end
