require 'rails_helper'

RSpec.describe ImageUploader, type: :uploader do
  it do
    uploader = described_class.new
    uploader.store!(File.open(Rails.root.join('spec/fixtures/example.png')))
  end
end
