require 'rails_helper'

RSpec.describe Formation, type: :model do
  it { should respond_to(:name, :image_url) }
end
