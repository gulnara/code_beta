class AddDetailsToProblems < ActiveRecord::Migration
  def change

  	add_column :problems, :rating, :integer
  end
end
