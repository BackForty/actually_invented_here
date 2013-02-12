class User < ActiveRecord::Base
  def self.authenticate(email, password)
    if user = where(email: email).first
      return user if user.authenticates_with?(password)
    end
  end

  def authenticates_with?(check_password)
    encrypted_password && BCrypt::Password.new(encrypted_password) == check_password
  end
end
