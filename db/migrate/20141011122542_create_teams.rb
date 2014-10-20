class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.integer :event_id
      t.string  :name
      t.integer :user_id
      t.integer :category_id
      t.timestamps
    end
  end
end
