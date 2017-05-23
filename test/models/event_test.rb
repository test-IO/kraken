require 'test_helper'

class EventTest < ActiveSupport::TestCase
  test 'delay the publication of new events in kafka' do
    mock(PublishToKafkaJob).perform_later(anything) { |*args| @job_params = args }

    event = Event.create!(name: Faker::Cat.name)

    assert_equal event, @job_params[0]
  end
end
