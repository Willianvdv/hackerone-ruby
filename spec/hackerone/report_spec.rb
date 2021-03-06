require "spec_helper"

describe Hackerone::Report do
  describe' .find_by' do
    it 'fetches a report by id' do
      report = Hackerone::Report.find_by id: 213998

      expect(report.id).to be_present
    end
  end

  it 'fetches the reporter' do
    report = Hackerone::Report.find_by id: 213998

    expect(report.reporter.username).to be_present
  end

  it 'fetches the team' do
    report = Hackerone::Report.find_by id: 213998

    expect(report.team.handle).to be_present
  end

  it 'fetches the activities' do
    report = Hackerone::Report.find_by id: 213998

    expect(report.activities).to be_present
  end
end
