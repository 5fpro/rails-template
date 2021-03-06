module Admin
  class UserExporter < ::ApplicationExporter
    define_export(
      :id,
      :name,
      :email,
      :sign_in_count
    )
  end
end
