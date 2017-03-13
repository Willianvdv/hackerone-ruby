require 'pry'

module Hackerone
  class Report < OpenStruct
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
      ::Hackerone::User.find_by username: data[:reporter][:username]
    end

    def self.find_by(id:)
      result = ::Hackerone::Client.query ReportQuery, variables: { id: id }
      data = result.data.report.data.deep_symbolize_keys
      data[:_data] = data
      new(**data)
    end

    private

    def data
      self._data
    end
  end
end
