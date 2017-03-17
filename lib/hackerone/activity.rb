module Hackerone
  class Activity < SimpleDelegator
    ActivityFragment = ::Hackerone::Client.parse <<-'GRAPHQL'
      fragment on ActivityInterface {
        __typename
        message
      }
    GRAPHQL
  end
end
