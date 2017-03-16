module Hackerone
  class Report < SimpleDelegator
    ReportQuery = ::Hackerone::Client.parse <<-'GRAPHQL'
      query($id: Int!) {
        report(id: $id) {
          id

          reporter {
            username
          }

          team {
            handle
          }

          activities {
            edges {
              node {
                ... on ActivityInterface {
                   ...Hackerone::Activity::ActivityFragment
                }
              }
            }
          }
        }
      }
    GRAPHQL

    def team
      ::Hackerone::Team.find_by handle: data.dig('team', 'handle')
    end

    def reporter
      ::Hackerone::User.find_by username: data.dig('reporter', 'username')
    end

    def activities
      __getobj__.activities.edges.map do |edge|
        ::Hackerone::Activity.new \
          ::Hackerone::Activity::ActivityFragment.new(edge.node)
      end
    end

    def self.find_by(id:)
      new \
        ::Hackerone::Client.query(ReportQuery, variables: { id: id })
        .data
        .report
    end
  end
end
