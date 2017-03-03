require "spec_helper"

describe Hackerone::User do
  describe '.find_by' do
    it 'fetches details of HackerOne\'s demo user' do
      user = Hackerone::User.find_by username: 'demo-member'
      expect(user.name).to eq 'Demo Member'
      expect(user.username).to eq 'demo-member'
    end
  end
end
