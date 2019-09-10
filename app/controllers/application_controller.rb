class ApplicationController < ActionController::Base
  helper_method :current_budget

  def current_budget
    @current_budget ||= request.env["current_budget"]
  end
end
