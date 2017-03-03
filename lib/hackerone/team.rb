require "hackerone/client"

module Hackerone
  class Team
    TeamQuery = ::Hackerone::Client.parse <<-'GRAPHQL'
      query($handle: String!) {
        team(handle: $handle) {
          handle
          name
        }
      }
    GRAPHQL

    attr_accessor :handle, :name

    def initialize(handle:, name:)
      @handle = handle
      @name = name
    end

    def self.find_by(handle:)
      result = ::Hackerone::Client.query TeamQuery, variables: { handle: handle }
      team_data = result.data.team.data
      new(**::Hackerone.symbolize_keys(team_data))
    end
  end
end
