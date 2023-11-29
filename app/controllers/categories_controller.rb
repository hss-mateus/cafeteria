class CategoriesController < ApplicationController
  skip_before_action :require_login

  def index
    @categories = Category.all
    @daily_specials = DailySpecial.where(week_day: Time.zone.today.wday).map(&:product)
  end
end
