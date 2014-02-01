class AddSourceToProblems < ActiveRecord::Migration
  def change
    add_column :problems, :source, :string
  end
end
