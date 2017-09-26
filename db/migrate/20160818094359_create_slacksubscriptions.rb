class CreateSlacksubscriptions < ActiveRecord::Migration[5.0]
  def change
    create_table :slacksubscriptions do |t|
    	t.belongs_to :slackchannel
    	t.belongs_to :job
      t.timestamps
    end
  end
end