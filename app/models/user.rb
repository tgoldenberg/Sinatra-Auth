class User < ActiveRecord::Base
  validates_presence_of :password_hash, :username
  include BCrypt

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def self.authenticate(name, password)
    @user = self.find_by(username: name)
    return @user if !@user.nil? && @user.password == password
  end
end
