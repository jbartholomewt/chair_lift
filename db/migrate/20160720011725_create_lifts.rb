class CreateLifts < ActiveRecord::Migration
  def change
    create_table :lifts do |t|
      t.integer :user_id, null: false
      t.string :name, null: false
      t.string :departure, null: false
      t.string :destination, null: false
      t.text :description, null: false
      t.string :zip, null: false
      t.integer :open_seats, null: false
      t.datetime :created_at
      t.datetime :updated_at
      t.timestamp

    end
  end
end
