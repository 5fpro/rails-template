# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string
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
#  created_at             :datetime
#  updated_at             :datetime
#  admin                  :boolean          default(FALSE)
#  avatar                 :string
#  mfa_secret             :string
#  mfa_token              :string
#

class User < ApplicationRecord
  attr_accessor :mfa_code
  acts_as_google_authenticated issuer: ENV['APP_NAME'],
                               google_secret_column: :mfa_secret,
                               lookup_token: :mfa_token
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :async
  omniauthable

  mount_uploader :avatar, AvatarUploader

  def setup_mfa_token
    return if self.mfa_token.present?
    update(mfa_token: ROTP::Base32.random_base32)
  end
end
