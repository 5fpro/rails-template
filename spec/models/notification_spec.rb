# == Schema Information
#
# Table name: notifications
#
#  id            :bigint           not null, primary key
#  sender_type   :string
#  sender_id     :string
#  receiver_type :string
#  receiver_id   :string
#  item_type     :string
#  item_id       :string
#  notify_type   :string
#  readed        :boolean          default(FALSE)
#  subject       :string
#  body          :string
#  created_on    :date
#  data          :jsonb
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  idx_on_readed_receiver_type_receiver_id_1d93789c5c    (readed,receiver_type,receiver_id)
#  index_notifications_on_body                           (body) USING gin
#  index_notifications_on_created_on                     (created_on)
#  index_notifications_on_data                           (data) USING gin
#  index_notifications_on_item_type_and_item_id          (item_type,item_id)
#  index_notifications_on_notify_type                    (notify_type)
#  index_notifications_on_receiver_type_and_receiver_id  (receiver_type,receiver_id)
#  index_notifications_on_sender_type_and_sender_id      (sender_type,sender_id)
#  index_notifications_on_subject                        (subject) USING gin
#
require 'rails_helper'

RSpec.describe Notification, type: :model do
  it do
    create(:notification)
  end
end
