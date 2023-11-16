# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  name                   :string
#  avatar                 :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  data                   :jsonb
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_data                  (data) USING gin
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_name                  (name) USING gin
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
module Admin
  class User < ::User
    class << self
      def ransackable_scopes(_auth_object = nil)
        [:has_avatar]
      end

      def has_avatar(_boolean = true)
        where.not(avatar: nil)
      end

      def base_class
        ::User
      end
    end

    def label
      "#{name} (#{email})"
    end
  end
end
