require "hackerone/client"

module Hackerone
  class User < OpenStruct
    UserQuery = ::Hackerone::Client.parse <<-'GRAPHQL'
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

    def self.find_by(username:)
      result = ::Hackerone::Client.query UserQuery, variables: { username: username }
      user_data = result.data.user.data
      new(**::Hackerone.symbolize_keys(user_data))
    end
  end
end
