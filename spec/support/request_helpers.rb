module RequestHelpers
  def request_administrator_sign_in
    administrator = create(:tyr_administrator, :root)
    if Tyr.config.mfa.enable && Tyr.config.admin.enable_mfa
      klass = Tyr.config.admin.administrator_class_name.constantize
      klass.send(:enable_mfa)
      administrator = klass.find(administrator.id)
      administrator.mfa_initialize!
    end
    post '/administrators/sign_in', params: { administrator: { email: administrator.email, password: default_password } }
    if Tyr.config.mfa.enable && Tyr.config.admin.enable_mfa
      get '/admin'
      follow_redirect!
      allow_any_instance_of(klass).to receive(:mfa_authentic?).with('123123').and_return(true)
      allow_any_instance_of(::Mfa).to receive(:authenticated?).and_return(true)
      post '/mfa_session?scope=tyr/administrator', params: { mfa_code: '123123' }
    end
  end
end
