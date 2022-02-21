require 'rails_helper'

RSpec.describe UsersController do
  
  describe 'GET index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end

    it 'renders the index template' do
      post :import_users, params: { file: Rack::Test::UploadedFile.new("#{Rails.root}/spec/fixtures/users.csv", 'csv') }
      expect(User.count).to eq(1)
      expect(response).to render_template('index')
    end
  end
end
