class CommunityGroupsController < ApplicationController
  # GET /community_groups
  # GET /community_groups.json
  def index
    @community_groups = CommunityGroup.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @community_groups }
    end
  end

  # GET /community_groups/1
  # GET /community_groups/1.json
  def show
    @community_group = CommunityGroup.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @community_group }
    end
  end

  # GET /community_groups/new
  # GET /community_groups/new.json
  def new
    @community_group = CommunityGroup.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @community_group }
    end
  end

  # GET /community_groups/1/edit
  def edit
    @community_group = CommunityGroup.find(params[:id])
  end

  # POST /community_groups
  # POST /community_groups.json
  def create
    @community_group = CommunityGroup.new(params[:community_group])

    respond_to do |format|
      if @community_group.save
        format.html { redirect_to @community_group, notice: 'Community group was successfully created.' }
        format.json { render json: @community_group, status: :created, location: @community_group }
      else
        format.html { render action: "new" }
        format.json { render json: @community_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /community_groups/1
  # PUT /community_groups/1.json
  def update
    @community_group = CommunityGroup.find(params[:id])

    respond_to do |format|
      if @community_group.update_attributes(params[:community_group])
        format.html { redirect_to @community_group, notice: 'Community group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @community_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /community_groups/1
  # DELETE /community_groups/1.json
  def destroy
    @community_group = CommunityGroup.find(params[:id])
    @community_group.destroy

    respond_to do |format|
      format.html { redirect_to community_groups_url }
      format.json { head :no_content }
    end
  end
end
