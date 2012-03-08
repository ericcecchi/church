class ServicesController < ApplicationController
  # GET /event/services
  # GET /event/services.json
  def index
    @event_services = Event::Service.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @event_services }
    end
  end

  # GET /event/services/1
  # GET /event/services/1.json
  def show
    @event_service = Event::Service.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event_service }
    end
  end

  # GET /event/services/new
  # GET /event/services/new.json
  def new
    @event_service = Event::Service.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event_service }
    end
  end

  # GET /event/services/1/edit
  def edit
    @event_service = Event::Service.find(params[:id])
  end

  # POST /event/services
  # POST /event/services.json
  def create
    @event_service = Event::Service.new(params[:event_service])

    respond_to do |format|
      if @event_service.save
        format.html { redirect_to @event_service, notice: 'Service was successfully created.' }
        format.json { render json: @event_service, status: :created, location: @event_service }
      else
        format.html { render action: "new" }
        format.json { render json: @event_service.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /event/services/1
  # PUT /event/services/1.json
  def update
    @event_service = Event::Service.find(params[:id])

    respond_to do |format|
      if @event_service.update_attributes(params[:event_service])
        format.html { redirect_to @event_service, notice: 'Service was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event_service.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /event/services/1
  # DELETE /event/services/1.json
  def destroy
    @event_service = Event::Service.find(params[:id])
    @event_service.destroy

    respond_to do |format|
      format.html { redirect_to event_services_url }
      format.json { head :no_content }
    end
  end
end
