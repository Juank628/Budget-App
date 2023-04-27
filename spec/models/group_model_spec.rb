require 'rails_helper'

RSpec.describe Entity, type: :model do
  subject do
    @user = User.create!(name: 'Juan', email: 'myemail@email.com', password: '123456789')
    @group1 = Group.create!(name: 'Food', icon: 'https://myimage1.com', user_id: @user.id)
  end

  before { subject.save }

  it 'should be valid if all the fields are filled' do
    expect(subject).to be_valid
  end

  it 'should have name' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'should have icon' do
    subject.icon = nil
    expect(subject).to_not be_valid
  end
end