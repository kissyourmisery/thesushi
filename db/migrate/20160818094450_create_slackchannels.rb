class CreateSlackchannels < ActiveRecord::Migration[5.0]
  def change
    create_table :slackchannels do |t|
    	t.boolean :public?
      t.string :name
      t.string :slack_id
      t.belongs_to :slackbot
      t.timestamps
    end
  end
end