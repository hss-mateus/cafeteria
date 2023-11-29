# == Schema Information
#
# Table name: users
#
#  id                           :integer          not null, primary key
#  crypted_password             :string
#  email                        :string
#  loyalty_points               :integer          default(0), not null
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
#  index_users_on_email              (email) UNIQUE
#  index_users_on_remember_me_token  (remember_me_token)
#
class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :orders, dependent: :destroy
  has_many :confirmed_orders, -> { confirmed }, class_name: "Order", dependent: :destroy, inverse_of: :user
  has_many :shifts, dependent: :destroy
  has_many :table_reservations, dependent: :destroy
  has_many :ratings, dependent: :destroy

  has_many :sent_messages, class_name: "Message", dependent: :nullify, foreign_key: :sender_id, inverse_of: :sender
  has_many :received_messages, class_name: "Message", as: :recipient, dependent: :nullify

  enum role: {
    customer: 0,
    employee: 1,
    manager: 2
  }

  validates :name, :email, presence: true
  validates :name, length: { maximum: 50 }
  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 6 }, confirmation: true, if: ->(u) { u.new_record? || u.changes[:crypted_password] }

  def first_and_last_names
    name.split.then { [_1.shift, _1.pop] }.join(" ")
  end
end
