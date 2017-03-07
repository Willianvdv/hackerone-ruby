require "active_support/core_ext/hash"
require "graphql/client"
require "graphql/client/http"

module Hackerone
  HTTP = GraphQL::Client::HTTP.new("https://hackerone.com/graphql")
  Schema = GraphQL::Client.load_schema(HTTP)
  Client = GraphQL::Client.new(schema: Schema, execute: HTTP)
end
