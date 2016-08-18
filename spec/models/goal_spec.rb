require 'rails_helper'

RSpec.describe Goal, type: :model do
  let(:goal) { FactoryGirl.create(:goal) }

  it 'FactoryGirl creation works' do
    expect(goal.details).to eq 'MyText'
  end

end
