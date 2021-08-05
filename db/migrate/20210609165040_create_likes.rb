class CreateLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :likes do |t|
      t.references :comment, null: false, foreign_key: true
      t.string :global_ip, null: false

      t.timestamps
    end
    add_index :likes, [:global_ip, :comment_id], unique: true
  end
end
