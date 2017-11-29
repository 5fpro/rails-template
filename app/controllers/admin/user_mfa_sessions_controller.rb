class Admin::UserMfaSessionsController < Admin::BaseController
  skip_before_action :check_mfa

  layout 'admin_landing'

  def new
  end

  def create
    user = current_user # grab your currently logged in user
    if user.google_authentic?(params[:user][:mfa_code])
      user.setup_mfa_token
      UserMfaSession.create(user)
      redirect_to admin_root_path
    else
      flash[:error] = "Wrong code"
      render :new
    end
  end
end
