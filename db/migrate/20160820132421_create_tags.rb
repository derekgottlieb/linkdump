class CreateTags < ActiveRecord::Migration[4.2]
  def change
    create_table :tags do |t|
      t.string :name
      t.datetime :created_at
      t.datetime :updated_at
    end

    add_column :links, :tags, :string
  end
end
