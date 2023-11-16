module Admin
  class UserPolicy < ::BasePolicy

    def index?
      perm?(:manage_users)
    end

  end
end
