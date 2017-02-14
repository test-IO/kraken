class EventsController < ApplicationController
  def create
    json = JSON.parse(request.body.read)
    CreateEventJob.perform_later json['event']['name'], json['event']['payload']
    render json: {}, status: :accepted
  end
end
