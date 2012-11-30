class PagesController < ApplicationController
  before_filter :authorize, :only => [:home]
  def home
    @students = User.search(params[:search], params[:page], 20).order("name ASC")
    @surveys = Survey.where(:published => true)
    respond_to do |format|
      format.html # pages.html.erb
      format.js
    end
  end

  def error
  end
end
