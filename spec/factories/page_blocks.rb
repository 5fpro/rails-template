# == Schema Information
#
# Table name: page_blocks
#
#  id              :bigint           not null, primary key
#  name            :string
#  body            :text
#  enabled         :boolean          default(FALSE)
#  template_engine :string
#  variables       :text
#  data            :jsonb
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_page_blocks_on_data     (data) USING gin
#  index_page_blocks_on_enabled  (enabled)
#  index_page_blocks_on_name     (name)
#
FactoryBot.define do
  factory :page_block do
    name { :test }
    body { '<p>OK</p>' }
    enabled { true }

    trait :admin_creation do
      enabled { '1' }
    end
  end
end
