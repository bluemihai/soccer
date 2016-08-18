require 'rails_helper'

RSpec.describe Player, type: :model do
  let(:player) { FactoryGirl.create(:player) }

  it '#status and #active/#inactive scopes work' do
    puts player.inspect
    expect(player.status).to eq 'Ready to Register and Pay!'
    player2 = FactoryGirl.create(:player, status: 'Very Likely to Join')
    player3 = FactoryGirl.create(:player, status: 'On the Fence')
    player4 = FactoryGirl.create(:player, status: 'Inactive This (EBSSL 30+) Season')
    expect(Player.count).to eq(4)
    expect(Player.active.count).to eq(3)
    expect(Player.inactive.count).to eq(1)
  end
end
