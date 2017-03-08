require "spec_helper"

describe Hackerone::Team do
  describe' .find_by' do
    it 'fetches a report by id' do
      report = Hackerone::Report.find_by id: 211770

       expect(report).to be_present
       expect(report.id).to be_present
      expect(report.title).to eq 'kerk'
      expect(report.vulnerability_information).to be_present
    end
  end
end
