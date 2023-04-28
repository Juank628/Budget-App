require 'rails_helper'

RSpec.describe 'group', type: :feature do
  include Warden::Test::Helpers
  before :each do
    @user = User.create!(name: 'Juan', email: 'myemail@email.com', password: '123456789')
    login_as(@user, scope: :user)

    @group1 = Group.create!(name: 'Food', icon: 'https://myimage1.com', user_id: @user.id)
    @group2 = Group.create!(name: 'Sports', icon: 'https://myimage2.com', user_id: @user.id)

    @entity1 = Entity.create!(name: 'apple', amount: 12.5, author_id: @user.id, groups: [@group1])
    @entity2 = Entity.create!(name: 'orange', amount: 10.1, author_id: @user.id, groups: [@group1])

    visit '/groups'
  end

  it 'should display "categories" as page name' do
    expect(page).to have_content('CATEGORIES')
  end

  it 'should display groups names' do
    expect(page).to have_content('Food')
    expect(page).to have_content('Sports')
  end

  it 'should display the total group ammount' do
    expect(page).to have_content('22.6')
  end

  it 'should redirect to create group after click "Add new category" button' do
    click_link 'ADD NEW CATEGORY'
    expect(current_path).to eq('/groups/new')
  end

  it 'should redirect to food entities after click on food group' do
    click_link 'Food'
    expect(current_path).to eq("/groups/#{@group1.id}/entities")
  end

  it 'should redirect to sports entities after click on sports group' do
    click_link 'Sports'
    expect(current_path).to eq("/groups/#{@group2.id}/entities")
  end
end
