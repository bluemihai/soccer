describe User do

  before(:each) { @user = FactoryGirl.create(:user) }

  subject { @user }

  it { should respond_to(:age, :first, :team, :players, :player, :gravatar,
                          :full_name, :set_default_role) }

  it '#name returns a string' do
    expect(@user.name).to match 'Test User'
  end

  it '#role works' do
    expect(@user.role).to eq 'admin'
    expect{@user.update(role: 'foo')}.to raise_error(ArgumentError)
    @user.update(role: 'manager')
    expect(@user.role).to eq 'manager'
    @user.update(role: 'player')
    expect(@user.role).to eq 'player'
  end

end
