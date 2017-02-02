class EventsController < ApplicationController
  def create
    json = JSON.parse(request.body.read)
    event = Event.create!(name: json['event']['name'],
                          payload: json['event']['payload'])
    render json: { event: event }, status: :accepted
  end
end
