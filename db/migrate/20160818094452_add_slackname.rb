class AddSlackname < ActiveRecord::Migration[5.0]
  def change
    add_column :slackbots, :name, :string
  end
end