module Hackerone
  class Report < OpenStruct
    ReportQuery = ::Hackerone::Client.parse <<-'GRAPHQL'
      query($id: Int!) {
        report(id: $id) {
          id
          title
          vulnerability_information
        }
      }
    GRAPHQL

    def self.find_by(id:)
      result = ::Hackerone::Client.query ReportQuery, variables: { id: id }
      report_data = result.data.report.data
      new(**report_data.symbolize_keys)
    end
  end
end
