class DirectMessagesController < ApplicationController
	respond_to :html, :json
	before_filter :get_direct_message, except: [:inbox, :index, :new, :sent, :create]

	def get_direct_message
		@direct_message = DirectMessage.find(params[:id])
	end
	
	def show
		@direct_message.mark_read_by(current_user)
		respond_with @direct_message
	end
	
	def index
  	redirect_to :inbox
	end

  # GET /messages
  # GET /messages.json
  def inbox
    @direct_messages = current_user.received_messages.where(_type: 'DirectMessage')
    respond_with @direct_messages
  end

  # GET /messages
  # GET /messages.json
  def sent
    @direct_messages = current_user.sent_messages.where(_type: 'DirectMessage')
    respond_with @direct_messages
  end

  # GET /messages/new
  # GET /messages/new.json
  def new
    @direct_message = DirectMessage.new
  end
  
  # POST /messages
  # POST /messages.json
  def create
    @direct_message = DirectMessage.new(params[:direct_message])

    respond_to do |format|
      if @direct_message.save
      	current_user.sent_messages << @direct_message
        format.html { redirect_to @direct_message, notice: 'Message was successfully created.' }
        format.json { render json: @direct_message, status: :created, location: @direct_message }
      else
        format.html { render action: "new" }
        format.json { render json: @direct_message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /messages/1
  # PUT /messages/1.json
  def update
    respond_to do |format|
      if @direct_message.update_attributes(params[:direct_message])
        format.html { redirect_to @direct_message, notice: 'Message was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @direct_message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @direct_message.destroy
    
    respond_to do |format|
      format.html { redirect_to DirectMessages_url }
      format.json { head :no_content }
    end
  end
end
