class MissionalTeamsController < ApplicationController
  # GET /missional_teams
  # GET /missional_teams.json
  def index
    @missional_teams = MissionalTeam.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @missional_teams }
    end
  end

  # GET /missional_teams/1
  # GET /missional_teams/1.json
  def show
    @missional_team = MissionalTeam.first(conditions: {name: params[:name]})

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @missional_team }
    end
  end

  # GET /missional_teams/new
  # GET /missional_teams/new.json
  def new
    @missional_team = MissionalTeam.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @missional_team }
    end
  end

  # GET /missional_teams/1/edit
  def edit
    @missional_team = MissionalTeam.first(conditions: {name: params[:name]})
  end

  # POST /missional_teams
  # POST /missional_teams.json
  def create
    @missional_team = MissionalTeam.new(params[:missional_team])

    respond_to do |format|
      if @missional_team.save
        format.html { redirect_to manage_missional_teams_path, notice: 'Missional team was successfully created.' }
        format.json { render json: @missional_team, status: :created, location: @missional_team }
      else
        format.html { render action: "new" }
        format.json { render json: @missional_team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /missional_teams/1
  # PUT /missional_teams/1.json
  def update
    @missional_team = MissionalTeam.first(conditions: {name: params[:name]})

    respond_to do |format|
      if @missional_team.update_attributes(params[:missional_team])
        format.html { redirect_to manage_missional_teams_path, notice: 'Missional team was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @missional_team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /missional_teams/1
  # DELETE /missional_teams/1.json
  def destroy
    @missional_team = MissionalTeam.first(conditions: {name: params[:name]})
    @missional_team.destroy

    respond_to do |format|
      format.html { redirect_to missional_teams_url }
      format.json { head :no_content }
    end
  end
end
