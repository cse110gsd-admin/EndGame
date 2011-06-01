class WorkoutsController < ApplicationController
  # GET /workouts
  # GET /workouts.xml
  def index
    @workouts = Workout.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @workouts }
    end
  end

  # GET /workouts/1
  # GET /workouts/1.xml
  def show
    @workout = Workout.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @workout }
    end
  end

  # GET /workouts/new
  # GET /workouts/new.xml
  def new
    @workout = Workout.new
    # fetches all the crossfit templates ordered by name
    #@templates = Template.where(:user_id => 
    #  User.find_by_name("crossfit").id).order(:name)
	  @templates = Template.where(:user_id => current_user.id).order(:name) 
    @workout.event_id = params[:event_id]

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @workout }
    end
  end

  # GET /workouts/1/edit
  def edit
    @workout = Workout.find(params[:id])
  end

  # POST /workouts
  # POST /workouts.xml
  def create
    @workout = Workout.new(params[:workout])
    if @workout.template_id != nil
      @template = Template.find(@workout.template_id)
      if @template.name != "Custom"
        @workout.attributes = { :name => @template.name, 
          :description => @template.description }
        @workout.save
        @exercises = @template.exercises
        @exercises.each do |exercise|
          @temp = @workout.exercises.create(:name => exercise.name,
                                    :reps => exercise.reps,
                                    :weight => exercise.weight )
          @temp.save
        end
      end
    end
    respond_to do |format|
      if @workout.save
        format.html { redirect_to(edit_workout_path(@workout), :notice => 'Workout was successfully created.') }
        format.xml  { render :xml => @workout, :status => :created, :location => @workout }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @workout.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /workouts/1
  # PUT /workouts/1.xml
  def update
    @workout = Workout.find(params[:id])

    respond_to do |format|
      if @workout.update_attributes(params[:workout])
        format.html { redirect_to(@workout, :notice => 'Workout was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @workout.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /workouts/1
  # DELETE /workouts/1.xml
  def destroy
    @workout = Workout.find(params[:id])
    @workout.destroy

    respond_to do |format|
      format.html { redirect_to(workouts_url) }
      format.xml  { head :ok }
    end
  end

  
end
