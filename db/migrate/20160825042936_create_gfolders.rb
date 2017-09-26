class CreateGfolders < ActiveRecord::Migration[5.0]
  def change
    create_table :gfolders do |t|
      t.string :name
      t.string :google_id
      t.belongs_to :google_oauth
      t.timestamps
    end
  end
end