class CreateJobs < ActiveRecord::Migration[5.0]
  def change
    create_table :jobs do |t|
    	t.string :position
    	t.belongs_to :user
      t.timestamps
    end
  end
end