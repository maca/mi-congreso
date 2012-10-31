class HomeController < ApplicationController
  def index
    @initiatives = Initiative.latest(3)
  end
end
