class MainController < ApplicationController
  def index
    @cigars = CigarSearchLog.all_cigars
  end
end
