class User < ApplicationRecord
  validates :name, :last_name, :email, :phone, :gender, presence: true
  validates :email, uniqueness: true
end
