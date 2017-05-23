class Event < ApplicationRecord
  serialize :payload

  validates :name, presence: true

  after_commit :publish_to_kafka, on: :create

  private

  def publish_to_kafka
    PublishToKafkaJob.perform_later(self)
  end
end
