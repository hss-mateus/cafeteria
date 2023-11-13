# == Schema Information
#
# Table name: users
#
#  id                           :integer          not null, primary key
#  activation_state             :string
#  activation_token             :string
#  activation_token_expires_at  :datetime
#  crypted_password             :string
#  email                        :string
#  name                         :string
#  remember_me_token            :string
#  remember_me_token_expires_at :datetime
#  role                         :integer          default("customer"), not null
#  salt                         :string
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#
# Indexes
#
#  index_users_on_activation_token   (activation_token)
#  index_users_on_email              (email) UNIQUE
#  index_users_on_remember_me_token  (remember_me_token)
#
class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :orders, dependent: :destroy
  has_many :shifts, dependent: :destroy
  has_many :table_reservations, dependent: :destroy

  enum role: {
    customer: 0,
    employee: 1,
    manager: 2
  }

  validates :name, :email, presence: true
  validates :name, length: { maximum: 50 }
  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 6 }, confirmation: true, if: ->(u) { u.new_record? || u.changes[:crypted_password] }
end
