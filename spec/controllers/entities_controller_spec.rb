require 'rails_helper'

RSpec.describe EntitiesController, type: :request do
    include Warden::Test::Helpers
    before :each do
        @user = User.create!(name: 'Juan', email: 'myemail@email.com', password: '123456789')
        login_as(@user, scope: :user)

        @group1 = Group.create!(name: 'Food', icon: 'https://myimage1.com', user_id: @user.id)
        @group2 = Group.create!(name: 'Sports', icon: 'https://myimage2.com', user_id: @user.id)

        @entity1 = Entity.create!(name: 'apple', amount: 12.5, author_id: @user.id, groups: [@group1])
        @entity2 = Entity.create!(name: 'orange', amount: 10.1, author_id: @user.id, groups: [@group1])
    end

    describe 'GET#index' do
        before do
            get "/groups/#{@group1.id}/entities"
        end

        it 'should be seccessful' do
            expect(response).to be_successful
        end

        it 'should use index template' do
            expect(response).to render_template(:index)
        end
    end

    describe 'GET#new' do
        before do
            get "/groups/#{@group1.id}/entities/new"
        end

        it 'should be seccessful' do
            expect(response).to be_successful
        end

        it 'should use new template' do
            expect(response).to render_template(:new)
        end
    end
end