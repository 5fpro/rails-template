class AddGoogleSecretToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :mfa_secret, :string
    add_column :users, :mfa_token, :string
  end
end
