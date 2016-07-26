class AddDateToLifts < ActiveRecord::Migration
  def change
    add_column :lifts, :departure_date, :datetime, null: false
  end
end
