class HomeController < ApplicationController
  def index
  end

  def about
    @about_me = "Mi nombre es Victor Valenzuela."
    @year = 2020 + 3
  end
end
