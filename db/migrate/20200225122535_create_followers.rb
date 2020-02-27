class CreateFollowers < ActiveRecord::Migration[6.0]
  def change
    create_table :followers do |t|
      t.integer :follow_id
      t.integer :followed_id

      t.timestamps
    end
    add_index :followers, :follow_id
    add_index :followers, :followed_id
    add_index :followers, [:follow_id, :followed_id], unique: true
  end
end
