require 'rails_helper'

RSpec.describe FakeDataContext, type: :context do
  it do
    described_class.new.perform
  end
end
