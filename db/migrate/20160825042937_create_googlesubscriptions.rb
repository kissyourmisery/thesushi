class CreateGooglesubscriptions < ActiveRecord::Migration[5.0]
  def change
    create_table :googlesubscriptions do |t|
    	t.belongs_to :gfolder
    	t.belongs_to :job
      t.timestamps
    end
  end
end