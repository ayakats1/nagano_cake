class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admin_items_path
    when Public
      public_items_path
    end
  end
end
