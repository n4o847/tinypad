class KondatesController < ApplicationController
  # GET /kondates
  def index
    @kondates = Kondate.all
  end

  # GET /kondates/1
  def show
    @kondate = Kondate.find(params[:id])
  end
end
