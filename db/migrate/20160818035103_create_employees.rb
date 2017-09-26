class CreateEmployees < ActiveRecord::Migration[5.0]
  def change
    create_table :employees do |t|
    	t.string :name
    	t.string :email
    	t.boolean :employed?
    	t.belongs_to :user
    	t.belongs_to :job
      t.timestamps
    end
  end
end
