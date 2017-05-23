class PublishToKafkaJob < ApplicationJob
  queue_as :default

  def perform(event)
    kafka.deliver_message(event.to_json, topic: Settings.kafka.topic)
  end

  private

  def kafka
    Kafka.new(seed_brokers: Settings.kafka.seed_brokers,
              client_id: Settings.kafka.client_id,
              logger: Rails.logger)
  end
end
