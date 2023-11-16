class FakeDataContext < BaseContext
  def perform
    create_users!
    create_admins!
    puts "user: #{@users.first.email} / #{password}"
    puts "admin: #{@administrator.email} / #{password}"
    puts "admin login: http://#{ENV['APP_HOST']}/administrators/sign_in"
  end

  def password
    '12341234'
  end

  private

  def create_users!
    User.destroy_all
    @users = []
    @users << User.create!(user_params(email: 'user-1@5fpro.com'))
  end

  def user_params(opts)
    {
      name: 'Haha',
      password: password
    }.merge(opts)
  end

  def create_admins!
    email = 'admin@5fpro.com'
    @administrator = Administrator.find_by(email: email) || FactoryBot.create(:administrator, email: email, password: password)
    @administrator.update(password: password, root: true)
  end

end
