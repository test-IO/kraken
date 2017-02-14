require 'test_helper'

class CreateEventsTest < ActionDispatch::IntegrationTest
  test 'delay the creation of the event' do
    event_name = Faker::Cat.name
    payload = {
      'breed' => Faker::Cat.breed,
      'registry' => Faker::Cat.registry
    }

    mock(CreateEventJob).perform_later(event_name, payload)

    post '/events', params: {
      event: {
        name: event_name,
        payload: payload
      }
    }.to_json
    assert_response :accepted
  end
end
