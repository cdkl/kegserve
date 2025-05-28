class SetBeverageColumnOptional < ActiveRecord::Migration[8.0]
  def change
    change_column_null :taps, :beverage_id, true
    change_column_default :taps, :beverage_id, nil
  end
end
