class Lift < ActiveRecord::Base
  belongs_to :user
  validates :name, presence: true
  validates :user_id, presence: true
  validates :departure, presence: true
  validates :destination, presence: true
  validates :description, presence: true
  validates :open_seats, presence: true
  validates :zip, presence: true, numericality: true, length: { is: 5 }
end
