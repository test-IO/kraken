require 'test_helper'

class CreateEventsTest < ActionDispatch::IntegrationTest
  test 'Create an event' do
    event_name = Faker::Cat.name
    payload = {
      'breed' => Faker::Cat.breed,
      'registry' => Faker::Cat.registry
    }

    assert_difference 'Event.count', 1 do
      post '/events', params: {
        event: {
          name: event_name,
          payload: payload
        }
      }.to_json
      assert_response :accepted
    end

    json = JSON.parse(response.body)
    assert_equal event_name, json['event']['name']
    assert_equal payload, json['event']['payload']

    event = Event.last
    assert_equal event_name, event.name
    assert_equal payload, event.payload
  end
end
