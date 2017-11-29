step ':user 登入' do |user|
  @current_user ||= user
  signin_user(@current_user)
end

step '通過MFA驗證' do
  pass_mfa
end

placeholder :user do
  match /user/ do
    create(:user)
  end

  match /二階段認證者/ do
    create(:user, :admin, :enable_mfa)
  end

  match /管理者/ do
    create(:user, :admin)
  end
end
