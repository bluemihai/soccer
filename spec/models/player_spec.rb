require 'rails_helper'

RSpec.describe Player, type: :model do
  let(:player) { FactoryGirl.create(:player) }

  it '#status and #active/#inactive scopes work' do
    expect(player.status).to eq 'Ready to Register and Pay!'
    player2 = FactoryGirl.create(:player, status: 'Very Likely to Join')
    player3 = FactoryGirl.create(:player, status: 'On the Fence')
    player4 = FactoryGirl.create(:player, status: 'Inactive This (EBSSL 30+) Season')
    expect(Player.count).to eq(4)
    expect(Player.active.count).to eq(3)
    expect(Player.inactive.count).to eq(1)
  end

  it 'validates for status presence' do
    expect(player).to be_valid
    player.status = nil
    expect(player).not_to be_valid
  end

  it 'validates for jersey presence and uniqueness' do
    expect(player).to be_valid
    player.jersey = nil
    expect(player).not_to be_valid

    player.update(jersey: 30)
    expect{
      FactoryGirl.create(:player, jersey: 30)
    }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'validates email presence and uniqueness' do
    expect{
      FactoryGirl.create(:player, email: nil)
    }.to raise_error(ActiveRecord::RecordInvalid)    

    FactoryGirl.create(:player, email: 'foo@foo.com')
    expect{
      FactoryGirl.create(:player, email: 'foo@foo.com')
    }.to raise_error(ActiveRecord::RecordInvalid)    
  end

  it 'validates name presence and uniqueness' do
    expect{
      FactoryGirl.create(:player, name: nil)
    }.to raise_error(ActiveRecord::RecordInvalid)    

    FactoryGirl.create(:player, name: 'Foo Bar')
    expect{
      FactoryGirl.create(:player, name: 'Foo Bar')
    }.to raise_error(ActiveRecord::RecordInvalid)    
  end
end
