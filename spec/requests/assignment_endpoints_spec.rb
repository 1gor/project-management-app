require 'rails_helper'

RSpec.describe AssignmentsController do
  specify do
    post '/assignments'

    expect(response).to have_http_status(204)
  end

  def parsed_body
    JSON.parse(response.body)
  end
end
