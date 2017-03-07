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
      new(**user_data.symbolize_keys)
    end
  end
end
