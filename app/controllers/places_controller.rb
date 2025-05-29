class PlacesController < ApplicationController

  def index
    @places = Place.all
  end

  def show
    @place = Place.find_by({ "id" => params["id"] })
    @entries = Entry.where({ "place_id" => @place["id"] })
    # filter entries by place and logged-in user
    @entries = Entry.where({ "place_id" => @place["id"], "user_id" => session["user_id"] })
  end

  def new
  end

  def create
    @place = Place.new
    @place["name"] = params["name"]
    @place.save
    redirect_to "/places"
  end

  def edit
    @place = Place.find_by({ "id" => params["id"] })
  end

  def update
    @place = Place.find_by({ "id" => params["id"] })
    if User.find_by({ "id" => session["user_id"] }) != nil
      @place["name"] = params["name"]
      @place.save
    else
      flash["notice"] = "You must be logged in to edit places."
    end
    redirect_to "/places/#{@place["id"]}"
  end
  
  def destroy
    @place = Place.find_by({ "id" => params["id"] })
    if User.find_by({ "id" => session["user_id"] }) != nil
      @place.destroy
      redirect_to "/places"
    else
      flash["notice"] = "You must be logged in to delete places."
      redirect_to "/places/#{@place["id"]}"
    end
  end
end
