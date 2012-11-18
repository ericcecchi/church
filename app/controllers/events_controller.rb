class EventsController < ApplicationController
	respond_to :html, :json, :xml
	before_filter :get_group

	def get_group
		@group = Group.find_by_slug(params[:group_id]) if params[:group_id]
	end
	
	def index
		@events = Event.regular
		respond_to do |format|
			format.html
			format.json { render :json => @events.map(&:cal_json) }
		end
	end

	def show
		@event = Event.find params[:id]
		respond_with @event
	end

	def new
		@event = Event.new
		@users = User.all.to_a
	end

	def edit
		@event = Event.find params[:id]
		@users = User.all.to_a
	end

	def create
		params['event']['start'] = "#{params['event']['start_date']} #{params['event']['start_time']}"
		params['event']['endd'] = "#{params['event']['end_date']} #{params['event']['end_time']}"
		params['event'].delete 'start_date'
		params['event'].delete 'start_time'
		params['event'].delete 'end_date'
		params['event'].delete 'end_time'
		
		@event = Event.new(params[:event])

		respond_to do |format|
			if @event.save
				current_user.created_events << @event

				if @group
				 	@group.events << @event
					format.html { redirect_to group_events_path @group, notice: 'Event was successfully created.' }
				else
					format.html { redirect_to events_path, notice: 'Event was successfully created.' }
				end
				
				format.json { render json: @event, status: :created, location: @event }
			else
				format.html { render action: "new" }
				format.json { render json: @event.errors, status: :unprocessable_entity }
			end
		end
	end

	def update
		params['event']['start'] = "#{params['event']['start_date']} #{params['event']['start_time']}" unless params['event']['start']
		params['event']['endd'] = "#{params['event']['end_date']} #{params['event']['end_time']}" unless params['event']['endd']
		params['event'].delete 'start_date'
		params['event'].delete 'start_time'
		params['event'].delete 'end_date'
		params['event'].delete 'end_time'
		
		@event = Event.find params[:id]
		respond_to do |format|
			if @event.update_attributes!(params[:event])
				if @group
					format.html { redirect_to group_events_path @group, notice: 'Event was successfully created.' }
					format.json { head :no_content }
				else
					format.html { redirect_to events_path, notice: 'Event was successfully created.' }
					format.json { head :no_content }
				end
				
			else
				format.html { render action: "edit" }
				format.json { render json: @event.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@event = Event.find params[:id]
		@event.destroy

		respond_to do |format|
			if @group
				@group.events << @event
				format.html { redirect_to group_events_path @group }
			else
				format.html { redirect_to events_url }
			end
			format.html { redirect_to events_url }
			format.json { head :no_content }
		end
	end
end
