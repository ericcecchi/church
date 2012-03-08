class MissionalTeamsController < ApplicationController
  load_and_authorize_resource
  respond_to :html, :json, :xml

  def index
    @missional_teams = MissionalTeam.all
    respond_with @missional_teams
  end

  def show
    @missional_team = MissionalTeam.first(conditions: {name: params[:name]})
    respond_with @missional_team
  end

  def new
    @missional_team = MissionalTeam.new
  end

  def edit
    @missional_team = MissionalTeam.first(conditions: {name: params[:name]})
  end

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

  def destroy
    @missional_team = MissionalTeam.first(conditions: {name: params[:name]})
    @missional_team.destroy

    respond_to do |format|
      format.html { redirect_to missional_teams_url }
      format.json { head :no_content }
    end
  end
end
