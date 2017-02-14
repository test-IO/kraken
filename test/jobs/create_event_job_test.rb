require 'test_helper'

class CreateEventJobTest < ActiveJob::TestCase
  test 'create an event with the given parameters' do
    event_name = Faker::Cat.name
    payload = {
      'breed' => Faker::Cat.breed,
      'registry' => Faker::Cat.registry
    }

    assert_difference 'Event.count', 1 do
      CreateEventJob.perform_now event_name, payload
    end

    event = Event.last
    assert_equal event_name, event.name
    assert_equal payload, event.payload
  end
end
