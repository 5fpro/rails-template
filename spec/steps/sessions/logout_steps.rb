step ':model_name 登出' do |klass|
  delete "/#{klass.to_s.underscore.pluralize}/sign_out"
end
