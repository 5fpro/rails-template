step '前往首頁' do
  get '/'
end

step '頁面正常' do
  expect(response).to be_success
end
