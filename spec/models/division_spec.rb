require 'rails_helper'

RSpec.describe Division, type: :model do

  it { should respond_to(:letter, :age) }
  it { should respond_to(:name, :full_name) }

  it '#full_name works' do
    puts "Working here..."
    d = FactoryGirl.create(:division)
    d.update(letter: 'z', age: 20)
    expect(d.full_name).to eq 'Division Z (20+)'
  end
end
