require 'rails_helper'

RSpec.describe Entity, type: :model do
  subject do
    @user = User.create!(name: 'Juan', email: 'myemail@email.com', password: '123456789')
  end

  before { subject.save }

  it 'should be valid if all the fields are filled' do
    expect(subject).to be_valid
  end

  it 'should have name' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'should have email' do
    subject.email = nil
    expect(subject).to_not be_valid
  end
end