# frozen_string_literal: true

# == Schema Information
#
# Table name: instructors
#
#  id                     :bigint           not null, primary key
#  bio                    :text
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  name                   :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_instructors_on_email                 (email) UNIQUE
#  index_instructors_on_reset_password_token  (reset_password_token) UNIQUE
#
FactoryBot.define do
  factory :instructor do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
    bio { Faker::Lorem.paragraph }
  end
end
