class ApplicationController < ActionController::Base
  before_filter :init_sessionvoc
  protect_from_forgery
end
