class EventsController < ApplicationController
  respond_to :html, :json, :xml
  def index
    @events = Event.all
    respond_to do |format|
      format.html
			format.json { render :json => @events.map(&:cal_json) }
		end
  end

  def show
    @event = Event.find params[:id]
    respond_with @event
  end

  def new
    @event = Event.new
    @users = User.all.to_a
  end

  def edit
    @event = Event.find params[:id]
    @users = User.all.to_a
  end

  def create
    @event = Event.new(params[:event])
    @users = User.all.to_a

    respond_to do |format|
      if @event.save
        format.html { redirect_to events_path, notice: 'Event was successfully created.' }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @event = Event.find params[:id]
    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to events_path, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @event = Event.find params[:id]
    @event.destroy

    respond_to do |format|
      format.html { redirect_to manage_events_url }
      format.json { head :no_content }
    end
  end
end
