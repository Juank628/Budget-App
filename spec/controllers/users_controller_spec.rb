require 'rails_helper'

RSpec.describe UsersController, type: :request do
  include Warden::Test::Helpers

  before do
    @user = User.create!(name: 'Juan', email: 'myemail@email.com', password: '123456789')
    login_as(@user, scope: :user)
  end

  describe 'GET #index' do
    before do
      get new_user_session_path
    end

    it 'redirects to groups page after login' do
      expect(response).to redirect_to('/')
    end
  end
end