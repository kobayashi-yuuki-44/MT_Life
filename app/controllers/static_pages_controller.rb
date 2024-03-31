class StaticPagesController < ApplicationController
  skip_before_action :require_login, only: [:top, :terms, :privacy]
  
  def top
    redirect_to home_path if logged_in?
  end

  def terms; end

  def privacy; end

end
