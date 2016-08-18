require 'rails_helper'

RSpec.describe Card, type: :model do
  it { should respond_to(:red, :yellow) }
end
