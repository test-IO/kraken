require 'test_helper'

class PublishToKafkaJobTest < ActiveJob::TestCase
  test 'initialises a Kafka client and publish the event' do
    event = Event.create!(name: Faker::Cat.name,
                          payload: {
                            'breed' => Faker::Cat.breed,
                            'registry' => Faker::Cat.registry
                          })

    kafka_client = stub
    mock(Kafka).new(anything) { kafka_client }
    mock(kafka_client).deliver_message(event.to_json, topic: Settings.kafka.topic)

    PublishToKafkaJob.perform_now(event)
  end
end
