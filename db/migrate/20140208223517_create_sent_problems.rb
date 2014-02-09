class CreateSentProblems < ActiveRecord::Migration
  def change
    create_table :sent_problems do |t|

      t.timestamps
    end
  end
end
