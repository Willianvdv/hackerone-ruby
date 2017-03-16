module Hackerone
  class Report < SimpleDelegator
    ReportQuery = ::Hackerone::Client.parse <<-'GRAPHQL'
      query($id: Int!) {
        report(id: $id) {
          id

          reporter {
            username
          }
        }
      }
    GRAPHQL

    def reporter
      ::Hackerone::User.find_by username: data.dig('reporter', 'username')
    end

    def self.find_by(id:)
      new \
        ::Hackerone::Client.query(ReportQuery, variables: { id: id })
        .data
        .report
    end
  end
end
