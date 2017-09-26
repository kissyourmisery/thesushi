class CreateTrellosubscriptions < ActiveRecord::Migration[5.0]
  def change
    create_table :trellosubscriptions do |t|
    	t.belongs_to :trelloteam
    	t.belongs_to :job
      t.timestamps
    end
  end
end