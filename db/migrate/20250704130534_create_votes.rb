class CreateVotes < ActiveRecord::Migration[7.1]
  def change
    create_table :votes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :blog_post, null: false, foreign_key: true
      t.integer :value, null: false

      t.timestamps
    end
    add_index :votes, [:user_id, :blog_post_id], unique: true
  end
end
