class AddLanguageToSolutions < ActiveRecord::Migration
  def change
    add_column :solutions, :language, :string
  end
end
