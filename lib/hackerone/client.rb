require "graphql/client"
require "graphql/client/http"

module Hackerone
  def self.symbolize_keys(hash)
    hash.keys.each do |key|
      hash[key.to_sym] = hash.delete(key)
    end

    hash
  end

  HTTP = GraphQL::Client::HTTP.new("https://hackerone.com/graphql")
  Schema = GraphQL::Client.load_schema(HTTP)
  Client = GraphQL::Client.new(schema: Schema, execute: HTTP)
end
