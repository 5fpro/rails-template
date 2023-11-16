require 'rails_helper'

describe Admin::UsersController, type: :request do
  before { request_administrator_sign_in }

  it 'CRUD' do
    get '/admin/users'
    expect(response).to be_successful

    get '/admin/users/new'
    expect(response).to be_successful

    create_params = {
      name: 'Mary',
      email: 'test123@asaa.com',
      password: 'qazwsxedc'
    }
    expect {
      post '/admin/users', params: { user: create_params }
    }.to change(Admin::User, :count).by(1)
    follow_redirect!
    expect(response).to be_successful
    instance = Admin::User.last

    get '/admin/users'
    expect(response).to be_successful

    get "/admin/users/#{instance.id}"
    expect(response).to be_successful

    get "/admin/users/#{instance.id}/edit"
    expect(response).to be_successful

    update_params = {

      name: 'Mars'
    }
    expect {
      put "/admin/users/#{instance.id}", params: { user: update_params }
    }.to change { instance.reload.name }
    follow_redirect!
    expect(response).to be_successful

    expect {
      delete "/admin/users/#{instance.id}"
    }.to change(Admin::User, :count).by(-1)
    follow_redirect!
    expect(response).to be_successful
  end
end
