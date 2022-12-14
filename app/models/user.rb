require 'bcrypt'

class User < ApplicationRecord
  has_secure_password
  validates :email, uniqueness: true
  validates :email, presence: true
  validates :organizer_name, uniqueness: true
  validates :organizer_name, presence: true
  # create bi-directional associations
  # https://guides.rubyonrails.org/association_basics.html#bi-directional-associations
  has_many :events

  # see: https://github.com/bcrypt-ruby/bcrypt-ruby
  def password=(raw)
    # # temporary variable, not in db
    # @password = raw
    self.password_digest = BCrypt::Password.create(raw)
  end

  def is_password?(raw)
    BCrypt::Password.new(self.password_digest).is_password?(raw)
  end
end
