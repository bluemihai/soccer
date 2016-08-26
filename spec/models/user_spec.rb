describe User do

  let(:user) { FactoryGirl.create(:user, name: 'Test User') }

  it { should respond_to(:age, :first, :team, :players, :player, :gravatar,
    :full_name, :set_default_role) }

  context 'validations' do
    context 'names' do
      it 'middle name is left blank for a two-word name' do
        u = FactoryGirl.create(:user, name: 'John Doe')
        expect(u.middle).to eq('')
      end

      it 'middle name is set correctly for a three-word name' do
        u = FactoryGirl.create(:user, name: 'John Wilkes Doe')
        expect(u.middle).to eq('Wilkes')
      end

      it 'first name is set correctly for a three-word name' do
        u = FactoryGirl.create(:user, name: 'John Wilkes Doe')
        expect(u.first).to eq('John')
      end

      it 'last name is set correctly for a three-word name' do
        u = FactoryGirl.create(:user, name: 'John Wilkes Doe')
        expect(u.last).to eq('Doe')
      end
    end

    it 'validates age presence and above 28 on Dec 31' do
      puts "user: #{user.inspect}"
      u = User.create!(email: 'foo@foo.com', name: 'Foo Bar', dob: nil)
      expect(u).to be_persisted
      u.
      expect{u.save}.to raise_error(ActiveRecord::RecordInvalid)

      old_enough = 28.years.ago.at_end_of_year
      expect(FactoryGirl.create(:user, dob: old_enough)).to be_valid

      too_young = old_enough + 1.day
      expect{
        FactoryGirl.create(:user, dob: too_young)
      }.to raise_error(ActiveRecord::RecordInvalid)
    end

    # it 'validates email presence and uniqueness' do
    #   expect{
    #     FactoryGirl.create(:user, email: nil)
    #   }.to raise_error(ActiveRecord::RecordInvalid)
    #
    #   FactoryGirl.create(:user, email: 'foo@foo.com')
    #   expect{
    #     FactoryGirl.create(:user, email: 'foo@foo.com')
    #   }.to raise_error(ActiveRecord::RecordInvalid)
    # end
    #
    # it 'validates league_history presence' do
    #   expect{
    #     FactoryGirl.create(:user, league_history: nil)
    #   }.to raise_error(ActiveRecord::RecordInvalid)
    # end
    #
    # it 'validates liability_waiver_agreed presence and truthiness' do
    #   expect{
    #     FactoryGirl.create(:user, liability_waiver_agreed: nil)
    #   }.to raise_error(ActiveRecord::RecordInvalid)
    #
    #   expect{
    #     FactoryGirl.create(:user, liability_waiver_agreed: false)
    #   }.to raise_error(ActiveRecord::RecordInvalid)
    # end
  end


  it '#name returns a string' do
    expect(user.name).to match 'Test User'
  end

  # it '#role works' do
  #   expect(@user.role).to eq 'admin'
  #   expect{@user.update(role: 'foo')}.to raise_error(ArgumentError)
  #   @user.update(role: 'manager')
  #   expect(@user.role).to eq 'manager'
  #   @user.update(role: 'player')
  #   expect(@user.role).to eq 'player'
  # end

end
