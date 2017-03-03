require "spec_helper"

describe Hackerone::Team do
  describe '.find_by' do
    it 'fetches details of HackerOne\'s demo user' do
      user = Hackerone::Team.find_by handle: 'security'
      expect(user.name).to eq 'HackerOne'
      expect(user.handle).to eq 'security'
    end
  end
end
