class CreateLinks < ActiveRecord::Migration[4.2]
  def change
    create_table :links do |t|
      t.string :url
      t.string :title
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
