class AddTweet < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :last_id

      t.timestamps null: false
    end

  end
end