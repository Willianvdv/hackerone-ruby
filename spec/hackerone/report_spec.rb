require "spec_helper"

describe Hackerone::Report do
  describe' .find_by' do
    it 'fetches a report by id' do
      report = Hackerone::Report.find_by id: 112935

      expect(report.id).to be_present
    end
  end
end
