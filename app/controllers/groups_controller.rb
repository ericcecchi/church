class GroupsController < ApplicationController
  load_and_authorize_resource find_by: :slug
  respond_to :html, :json, :xml
  
  def index
    @groups = Group.all
    respond_with @groups
  end

  def show
    @group = Group.find_by_slug params[:id]
    @discussion = Discussion.new
    respond_with @group
  end

  def new
    @group = Group.new
    @users = User.all.to_a
  end

  def edit
    @group = Group.find_by_slug params[:id]
    @users = User.all.to_a
  end

  def create
    @group = Group.new(params[:group])
    @users = User.all.to_a

    respond_to do |format|
      if @group.save
        format.html { redirect_to manage_groups_path, notice: 'Group was successfully created.' }
        format.json { render json: @group, status: :created, location: @group }
      else
        format.html { render action: "new" }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @group = Group.find_by_slug params[:id]
    respond_to do |format|
      if @group.update_attributes(params[:group])
        format.html { redirect_to manage_groups_path, notice: 'Group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @group = Group.find_by_slug params[:id]
    @group.destroy

    respond_to do |format|
      format.html { redirect_to manage_groups_url }
      format.json { head :no_content }
    end
  end
end
