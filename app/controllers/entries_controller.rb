class EntriesController < ApplicationController
  def show
  end

  def new
  end

  def create
    # only authorize logged-in user to add entries
    if User.find_by({ "id" => session["user_id"] }) != nil
    @entry = Entry.new
    @entry["title"] = params["title"]
    @entry["description"] = params["description"]
    @entry.uploaded_image.attach(params["uploaded_image"])
    @entry["occurred_on"] = params["occurred_on"]
    @entry["place_id"] = params["place_id"]
    # assign logged-in user as task's user
    @entry["user_id"] = session["user_id"]
    @entry.save
    end
    redirect_to "/places/#{@entry["place_id"]}"
  end

end
