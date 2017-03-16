module Hackerone
  class User < SimpleDelegator
    UserFragment = ::Hackerone::Client.parse <<-'GRAPHQL'
      fragment on User {
        name
        username
        signal
        reputation
        impact
      }
    GRAPHQL

    FindUserQuery = ::Hackerone::Client.parse <<-'GRAPHQL'
      query($username: String!) {
        user(username: $username) {
          ...Hackerone::User::UserFragment
        }
      }
    GRAPHQL

    def self.find_by(username:)
      new \
        UserFragment.new(
          ::Hackerone::Client.query(
            FindUserQuery, variables: { username: username }
          ).data.user
        )
    end
  end
end
