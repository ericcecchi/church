class CommunityGroupsController < ApplicationController
  load_and_authorize_resource
  respond_to :html, :json, :xml
  
  def index
    @community_groups = CommunityGroup.all
    respond_with @community_groups
  end

  def show
    @community_group = CommunityGroup.first(conditions: {name: params[:name]})
    respond_with @community_group
  end

  def new
    @community_group = CommunityGroup.new
  end

  def edit
    @community_group = CommunityGroup.first(conditions: {name: params[:name]})
  end

  def create
    @community_group = CommunityGroup.new(params[:community_group])

    respond_to do |format|
      if @community_group.save
        format.html { redirect_to manage_community_groups_path, notice: 'Community group was successfully created.' }
        format.json { render json: @community_group, status: :created, location: @community_group }
      else
        format.html { render action: "new" }
        format.json { render json: @community_group.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @community_group = CommunityGroup.first(conditions: {name: params[:name]})

    respond_to do |format|
      if @community_group.update_attributes(params[:community_group])
        format.html { redirect_to manage_community_groups_path, notice: 'Community group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @community_group.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @community_group = CommunityGroup.first(conditions: {name: params[:name]})
    @community_group.destroy

    respond_to do |format|
      format.html { redirect_to community_groups_url }
      format.json { head :no_content }
    end
  end
end
