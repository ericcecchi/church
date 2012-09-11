class DiscussionsController < ApplicationController
	respond_to :html, :json
	before_filter :get_discussion, except: [:index, :new, :create]
	before_filter :get_group

	def get_discussion
		@discussion = Discussion.find(params[:id])
	end

	def get_group
		@group = Group.find_by_slug(params[:group_id])
	end
	
	def show
		@discussion.mark_read_by(current_user)
		respond_with @discussion
	end
	
	def index
    @discussions = @group.discussions
    respond_with @discussions
	end

  # GET /messages/new
  # GET /messages/new.json
  def new
    @discussion = Discussion.new
  end
  
  # POST /messages
  # POST /messages.json
  def create
    @discussion = Discussion.new(params[:discussion])

    respond_to do |format|
      if @discussion.save
      	current_user.sent_messages << @discussion
      	@group.discussions << @discussion
      	@discussion.recipients << @group.members
      	@discussion.create_read_receipts
        format.html { redirect_to [@group,@discussion], notice: 'Discussion was successfully created.' }
        format.json { render json: @discussion, status: :created, location: @discussion }
      else
        format.html { render action: "new" }
        format.json { render json: @discussion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /messages/1
  # PUT /messages/1.json
  def update
    respond_to do |format|
      if @discussion.update_attributes(params[:message])
        format.html { redirect_to [@group,@discussion], notice: 'Discussion was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @discussion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @discussion.destroy
    
    respond_to do |format|
      format.html { redirect_to group_discussions_url(@group) }
      format.json { head :no_content }
    end
  end
end
