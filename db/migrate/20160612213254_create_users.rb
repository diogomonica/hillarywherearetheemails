class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :provider
      t.string :oauth_token
      t.string :oauth_secret
      t.string :uid

      t.timestamps null: false
    end
  end
end
