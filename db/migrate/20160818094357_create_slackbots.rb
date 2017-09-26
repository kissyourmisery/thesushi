class CreateSlackbots < ActiveRecord::Migration[5.0]
  def change
    create_table :slackbots do |t|
      t.text :authenticity_token 
    	t.belongs_to :user
    	t.belongs_to :service
      t.timestamps
    end
  end
end

