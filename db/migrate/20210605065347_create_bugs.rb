class CreateBugs < ActiveRecord::Migration[6.0]
  def change
    create_table :bugs do |t|
      t.string :name, null: false
      t.text :feature
      t.text :approach
      t.text :prevention
      t.text :harm
      t.integer :size
      t.integer :color
      t.integer :season
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :bugs, :name, unique: true
  end
end
