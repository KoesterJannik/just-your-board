class ApplicationController < ActionController::Base
  include Authentication

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  private

    # Override the after_authentication_url method to redirect to dashboard
    def after_authentication_url
      session.delete(:return_to_after_authenticating) || dashboard_url
    end
end
