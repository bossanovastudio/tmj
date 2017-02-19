class Admin::CastingController < Admin::AdminController
  respond_to :csv, :json, only: :download

  def index
  end

  # GET /castings/download.json
  # GET /castings/download.csv
  def download
    data = Casting.all
    respond_with do |format|
      format.json  { render json: data }
      format.csv { render csv: data, except: [:created_at, :updated_at, :newsletter] }
    end
  end
end
