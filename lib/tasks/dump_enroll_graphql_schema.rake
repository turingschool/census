require "graphql/client"
require "graphql/client/http"

namespace :graphql do
  task generate_schema: :environment do
    GraphQL::Client.dump_schema(Enroll::HTTP, "#{Rails.root}/public/graphql_enroll_schema.json")
  end
end
