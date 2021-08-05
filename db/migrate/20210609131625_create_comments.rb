class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.text :sentence, null: false
      t.references :bug, null: false, foreign_key: true
      t.string :global_ip, null: false

      t.timestamps
    end
  end
end
