class CreateBeverages < ActiveRecord::Migration[8.0]
  def change
    create_table :beverages do |t|
      t.string :name
      t.string :style
      t.string :ibu
      t.string :abv

      t.timestamps
    end
  end
end
