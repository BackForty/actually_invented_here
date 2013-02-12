require 'devise/strategies/authenticatable'

module Devise
  module Strategies
    class MultiTenant < Authenticatable
      def valid?
        true
      end

      def authenticate!
        if params[:user]
          user = Thread.current[:subdomain].users.find_by_email(params[:user][:email])

          if user && user.encrypted_password == params[:user][:password]
            success!(user)
          else
            fail
          end
        else
          fail
        end
      end
    end
  end
end

Warden::Strategies.add(:multi_tenant, Devise::Strategies::MultiTenant)

config.warden do |manager|
  manager.default_strategies(:scope => :user).unshift :multi_tenant
end
