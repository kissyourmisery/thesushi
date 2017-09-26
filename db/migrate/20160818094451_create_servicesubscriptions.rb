class CreateServicesubscriptions < ActiveRecord::Migration[5.0]
  def change
    create_table :servicesubscriptions do |t|
    	t.belongs_to :user
      t.belongs_to :service
      t.timestamps
    end
  end
end