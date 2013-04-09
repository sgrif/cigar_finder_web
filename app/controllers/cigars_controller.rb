class CigarsController < ApplicationController
  def index
    render json: CigarSearchLog.all_cigars
  end
end
