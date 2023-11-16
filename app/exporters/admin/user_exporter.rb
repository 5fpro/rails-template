module Admin

  class UserExporter < ApplicationExporter
    define_export(
      'ID': :id,
      'Created At': :created_at.to_s
    )
  end
end
