class CreateGoogleOauths < ActiveRecord::Migration[5.0]
  def change
    create_table :google_oauths do |t|
      t.string :refresh_token
      t.string :username
      t.integer :service_id
      t.integer :user_id
      t.timestamps
    end
  end
end

# still need this! but link it to job_id!!!

# store the access_token so that I could use the google api on other pages, and update it whenever it expires