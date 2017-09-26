class CreateTrelloteams < ActiveRecord::Migration[5.0]
  def change
    create_table :trelloteams do |t|
      t.string :name
      t.string :trello_id
      t.belongs_to :trellobot
      t.timestamps
    end
  end
end