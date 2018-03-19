require "graphql/client"
require "graphql/client/http"

module Enroll
  ENROLL_URL = Rails.application.secrets.enroll_graphql_endpoint

  HTTP = GraphQL::Client::HTTP.new(ENROLL_URL) do
    def headers(context)
      { "X-TURING-AUTH": Rails.application.secrets.api_auth_secret }
    end
  end

  Schema = GraphQL::Client.load_schema("#{Rails.root}/public/graphql_enroll_schema.json")
  Client = GraphQL::Client.new(schema: Schema, execute: HTTP)
end

CohortsQuery = Enroll::Client.parse <<-'GRAPHQL'
  query {
    cohorts {
      course_id
      created_at
      end_date
      id
      max_number_of_students
      name
      start_date
      status
      updated_at
    }
  }
GRAPHQL
