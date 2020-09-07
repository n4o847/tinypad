class KondatesController < ApplicationController
  # GET /kondates
  def index
    @kondates = Kondate.all
  end
end
