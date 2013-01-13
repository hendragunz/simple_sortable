class ApplicationController < ActionController::Base
  protect_from_forgery
  layout :determine_layout

  # set layout dependent on request
  def determine_layout
    request.xhr? ? 'ajax' : 'application'
  end
end
