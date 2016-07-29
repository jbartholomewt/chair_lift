class Lift < ActiveRecord::Base
  include PgSearch
  
  belongs_to :user
  validates :name, presence: true
  validates :user_id, presence: true
  validates :departure, presence: true
  validates :destination, presence: true
  validates :description, presence: true
  validates :open_seats, presence: true
  validates :departure_date, presence: true
  validates :zip, presence: true, numericality: true, length: { is: 5 }

  pg_search_scope :search_lift_only,
    against: [:name, :departure, :zip, :destination, :departure_date]
  scope :search, -> (query) { search_lift_only(query) if query.present? }
  end
