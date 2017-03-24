module Hackerone
  class Report < SimpleDelegator
    ReportAll = ::Hackerone::Client.parse <<-'GRAPHQL'
      query {
        reports {
          edges {
            node {
              id
              _id

              reporter {
                username
              }
            }
          }
        }
      }
    GRAPHQL

    ReportFindByIdQuery = ::Hackerone::Client.parse <<-'GRAPHQL'
      query($id: Int!) {
        report(id: $id) {
          id
          _id

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
      response = ::Hackerone::Client.query \
        ReportFindByIdQuery, variables: { id: id }

      new response.data.report
    end

    def self.all
      response = ::Hackerone::Client.query ReportAll

      response.data.reports.edges.map do |edge|
        new(edge.node)
      end
    end
  end
end
