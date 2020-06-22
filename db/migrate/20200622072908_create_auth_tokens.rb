class CreateAuthTokens < ActiveRecord::Migration[6.0]
  def change
    create_table :auth_tokens do |t|
      t.integer :user_id
      t.string :token
      t.string :platform
      t.string :device_type
      t.string :device_udid_number
      t.datetime :expire_at
      t.timestamps
    end
  end
end
