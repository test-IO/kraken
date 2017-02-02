class Event < ApplicationRecord
  serialize :payload

  validates :name, presence: true
end
