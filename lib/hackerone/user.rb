require "hackerone/client"

module Hackerone
  class User
    FindUserQuery = ::Hackerone::Client.parse <<-'GRAPHQL'
      query($username: String!) {
        user(username: $username) {
          name
          username
          signal
          reputation
          impact
        }
      }
    GRAPHQL

    MeUserQuery = ::Hackerone::Client.parse <<-'GRAPHQL'
      query {
        me {
          name
          username
          signal
          reputation
          impact
        }
      }
    GRAPHQL

    attr_accessor :username, :name, :signal, :reputation, :impact

    def initialize(username:, name:, signal:, reputation:, impact:)
      @username = username
      @name = name
      @signal = signal
      @reputation = reputation
      @impact = impact
    end

    def self.me
      result = ::Hackerone::Client.query MeUserQuery
      user_data = result.data.me.data
      new(**::Hackerone.symbolize_keys(user_data))
    end

    def self.find_by(username:)
      result = ::Hackerone::Client.query FindUserQuery, variables: { username: username }
      user_data = result.data.user.data
      new(**::Hackerone.symbolize_keys(user_data))
    end
  end
end
