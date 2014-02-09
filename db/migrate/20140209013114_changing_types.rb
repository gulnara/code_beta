class ChangingTypes < ActiveRecord::Migration
  def change
  	change_column :problems, :description, :text
  	change_column :problems, :title, :text
  	change_column :problems, :source, :text
  	change_column :solutions, :answer, :text
  end
end
