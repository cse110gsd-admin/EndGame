class EventsController < ApplicationController
  # GET /events
  # GET /events.xml
  def index   
    @events = Event.where(:user_id => current_user.id)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @events }
      format.js  { render :json => @events }
    end
  end

  # GET /events/1
  # GET /events/1.xml
  def show
    @event = Event.find(params[:id])

    @workout = Workout.where(:event_id => @event.id ).first


    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @event }
      format.js { render :json => @event.to_json }
    end
  end

  # GET /events/new
  # GET /events/new.xml
  def new
    @event = Event.new
    @event.user_id = current_user.id

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.xml
  def create
    @event = Event.new(params[:event])
    @event.user_id = current_user.id
    @start_date = DateTime.civil(@event.starts_at.year, @event.starts_at.month, @event.starts_at.day, 14, 14, 14)
    @end_date = DateTime.civil(@event.starts_at.year, @event.starts_at.month, @event.starts_at.day, 14, 14, 15)
    @event.starts_at = @start_date
    @event.ends_at = @end_date
    @event.all_day = true
    respond_to do |format|
      if @event.save
        format.html { redirect_to(new_workout_path(:user_id => @current_user.id, :event_id => @event.id ), :notice => 'Pick the workout template.') }
        format.xml  { render :xml => @event, :status => :created, :location => @event }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.xml
  # PUT /events/1.js
  # when we drag an event on the calendar (from day to day on the month view, or stretching
  # it on the week or day view), this method will be called to update the values.
  # viv la REST!
  def update
    @event = Event.find(params[:id])
    
    respond_to do |format|
      if @event.update_attributes(params[:event])
        if(@workout.nil?)
          format.html { redirect_to(new_workout_path(:user_id => @current_user.id, :event_id => @event.id ), :notice => 'Pick the workout template.') }
        else
          format.html { redirect_to( edit_workout_path(@workout) ) }
          format.xml  { head :ok }
          format.js { head :ok}
        end
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
        format.js  { render :js => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.xml
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to(calendar_index_path) }
      format.xml  { head :ok }
    end
  end
end
