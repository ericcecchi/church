class SermonsController < ApplicationController
  # GET /service/sermons
  # GET /service/sermons.json
  def index
    @service_sermons = Service::Sermon.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @service_sermons }
    end
  end

  # GET /service/sermons/1
  # GET /service/sermons/1.json
  def show
    @service_sermon = Service::Sermon.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @service_sermon }
    end
  end

  # GET /service/sermons/new
  # GET /service/sermons/new.json
  def new
    @service_sermon = Service::Sermon.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @service_sermon }
    end
  end

  # GET /service/sermons/1/edit
  def edit
    @service_sermon = Service::Sermon.find(params[:id])
  end

  # POST /service/sermons
  # POST /service/sermons.json
  def create
    @service_sermon = Service::Sermon.new(params[:service_sermon])

    respond_to do |format|
      if @service_sermon.save
        format.html { redirect_to @service_sermon, notice: 'Sermon was successfully created.' }
        format.json { render json: @service_sermon, status: :created, location: @service_sermon }
      else
        format.html { render action: "new" }
        format.json { render json: @service_sermon.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /service/sermons/1
  # PUT /service/sermons/1.json
  def update
    @service_sermon = Service::Sermon.find(params[:id])

    respond_to do |format|
      if @service_sermon.update_attributes(params[:service_sermon])
        format.html { redirect_to @service_sermon, notice: 'Sermon was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @service_sermon.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /service/sermons/1
  # DELETE /service/sermons/1.json
  def destroy
    @service_sermon = Service::Sermon.find(params[:id])
    @service_sermon.destroy

    respond_to do |format|
      format.html { redirect_to service_sermons_url }
      format.json { head :no_content }
    end
  end
end
