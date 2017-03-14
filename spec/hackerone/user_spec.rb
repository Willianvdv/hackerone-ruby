require "spec_helper"

describe Hackerone::User do
  describe '.find_by' do
    xit 'fetches my details' do
      user = Hackerone::User.me
      expect(user.username).not_to be_nil
    end

    it 'fetches details of HackerOne\'s demo user' do
      user = Hackerone::User.find_by username: 'demo-member'
      expect(user.name).to eq 'Demo Member'
      expect(user.username).to eq 'demo-member'

      # These specs are a bit silly since the demo member doesn't have
      # reports with reputation and so we don't have any values here.
      expect(user.reputation).to eq nil
      expect(user.impact).to eq nil
      expect(user.signal).to eq nil
    end
  end
end
