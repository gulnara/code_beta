class AddSearchIndexToProblems < ActiveRecord::Migration
  def up
    execute "create index problems_title on problems using gin(to_tsvector('english', title))"
    execute "create index problems_description on problems using gin(to_tsvector('english', description))"
  end

  def down
    execute "drop index problems_title"
    execute "drop index problems_description"
  end
end