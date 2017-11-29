module RequestClient
  def signout_user
    delete '/users/sign_out'
    @current_user = nil
  end

  def signin_user(user = nil)
    user ||= create(:user, :admin)
    post '/users/sign_in', params: { user: { email: user.email, password: user.password } }
    @current_user = user if response.status == 302
  end

  def pass_mfa
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@current_user)
    expect(@current_user).to receive(:google_authentic?).and_return(true)
    post '/admin/user_mfa_sessions', params: { user: { mfa_code: '1234' } }
  end

  def current_user
    @current_user
  end

  def file_data
    fixture_file_upload('spec/fixtures/5fpro.png', 'image/png')
  end
end
