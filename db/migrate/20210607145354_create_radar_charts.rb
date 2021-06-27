class CreateRadarCharts < ActiveRecord::Migration[6.0]
  def change
    create_table :radar_charts do |t|
      t.integer :capture, null: false
      t.integer :breeding, null: false
      t.integer :quickness, null: false
      t.integer :evil, null: false
      t.integer :discomfort, null: false
      t.references :bug, null: false, foreign_key: true

      t.timestamps
    end
  end
end
