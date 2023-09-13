class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :name, :email, presence: true
  validates :name, length: { maximum: 50 }
  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 6 }, confirmation: true, if: ->(u) { u.new_record? || u.changes[:crypted_password] }
end
