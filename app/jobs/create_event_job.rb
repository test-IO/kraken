class CreateEventJob < ApplicationJob
  queue_as :default

  def perform(name, payload)
    Event.create!(name: name, payload: payload)
  end
end
