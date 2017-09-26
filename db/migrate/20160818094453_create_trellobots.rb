class CreateTrellobots < ActiveRecord::Migration[5.0]
  def change
    create_table :trellobots do |t|
    	t.text :authenticity_key
    	t.text :authenticity_token
    	t.string :username
    	t.belongs_to :service
    	t.belongs_to :user
      t.timestamps
    end
  end
end