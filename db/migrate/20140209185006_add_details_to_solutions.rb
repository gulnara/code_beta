class AddDetailsToSolutions < ActiveRecord::Migration
  def change
	add_column :solutions, :title, :string
	add_column :solutions, :rating, :integer

  end
end
