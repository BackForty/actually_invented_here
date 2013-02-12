class ApplicationController < ActionController::Base
  before_filter :set_current_subdomain

  private
  def current_subdomain
    return @subdomain if defined? @subdomain
    @subdomain = Subdomain.find_by_name(request.subdomain)
  end
  helper_method :current_subdomain

  def set_current_subdomain
    unless Thread.current[:subdomain] = current_subdomain
      deny!(404)
    end
  end
end
