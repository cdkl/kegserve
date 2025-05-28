class CreateTaps < ActiveRecord::Migration[8.0]
  def change
    create_table :taps do |t|
      t.string :name
      t.references :beverage, null: false, foreign_key: true

      t.timestamps
    end
  end
end
