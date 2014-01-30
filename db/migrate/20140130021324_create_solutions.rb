class CreateSolutions < ActiveRecord::Migration
  def change
    create_table :solutions do |t|
      t.string :answer

      t.timestamps
    end
  end
end
