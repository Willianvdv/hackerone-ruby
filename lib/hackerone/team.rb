module Hackerone
  class Team < SimpleDelegator
    TeamQuery = ::Hackerone::Client.parse <<-'GRAPHQL'
      query($handle: String!) {
        team(handle: $handle) {
          handle
          name
        }
      }
    GRAPHQL

    def self.find_by(handle:)
      new \
        ::Hackerone::Client.query(TeamQuery, variables: { handle: handle })
        .data
        .team
    end
  end
end
