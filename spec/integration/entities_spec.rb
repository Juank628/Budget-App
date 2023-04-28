require 'rails_helper'

RSpec.describe 'entity', type: :feature do
  include Warden::Test::Helpers
  before :each do
    @user = User.create!(name: 'Juan', email: 'myemail@email.com', password: '123456789')
    login_as(@user, scope: :user)

    @group1 = Group.create!(name: 'Food', icon: 'https://myimage1.com', user_id: @user.id)

    @entity1 = Entity.create!(name: 'apple', amount: 12.5, author_id: @user.id, groups: [@group1])
    @entity2 = Entity.create!(name: 'orange', amount: 10.1, author_id: @user.id, groups: [@group1])

    visit "/groups/#{@group1.id}/entities"
  end

  it 'should display "transactions" as page name' do
    expect(page).to have_content('TRANSACTIONS')
  end

  it 'should display entities names' do
    expect(page).to have_content('apple')
    expect(page).to have_content('orange')
  end

  it 'should display the total group ammount' do
    expect(page).to have_content('22.6')
  end

  it 'should redirect to create transaction after click "Add new transaction" button' do
    click_link 'ADD NEW TRANSACTION'
    expect(current_path).to eq("/groups/#{@group1.id}/entities/new")
  end

  it 'should redirect to groups after click on back button' do
    click_link '<-'
    expect(current_path).to eq('/groups')
  end
end
