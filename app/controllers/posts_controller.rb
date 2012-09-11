class MessagesController < ApplicationController
	respond_to :html, :json
	before_filter :get_message, except: [:inbox, :index, :new, :sent, :create]

	def get_message
		@message = Message.find(params[:id])
	end

	def get_group
		@group = Group.find_by_slug(params[:group_id])
	end
	
	def show
		respond_with @message
	end
	
	def index
		if params[:group_id]
			get_group
	    @messages = @group.discussions
	    respond_with @messages
	  else
	  	redirect_to :inbox
	  end
	end

  # GET /messages
  # GET /messages.json
  def inbox
    @messages = current_user.received_messages
    respond_with @messages
  end

  # GET /messages
  # GET /messages.json
  def sent
    @messages = current_user.sent_messages
    respond_with @messages
  end

  # GET /messages/new
  # GET /messages/new.json
  def new
    @message = Message.new
  end
  
  # POST /messages
  # POST /messages.json
  def create
  	params[:message][:group_id] = params[:group_id]
    @message = Message.new(params[:message])

    respond_to do |format|
      if @message.save
      	current_user.sent_messages << @message
        format.html { redirect_to @message, notice: 'Message was successfully created.' }
        format.json { render json: @message, status: :created, location: @message }
      else
        format.html { render action: "new" }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /messages/1
  # PUT /messages/1.json
  def update
    respond_to do |format|
      if @message.update_attributes(params[:message])
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    
    respond_to do |format|
      format.html { redirect_to messages_url }
      format.json { head :no_content }
    end
  end
end
