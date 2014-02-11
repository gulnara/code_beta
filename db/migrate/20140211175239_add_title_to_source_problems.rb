class AddTitleToSourceProblems < ActiveRecord::Migration
  def change

  	add_column :problems, :source_title, :string
  end
end
