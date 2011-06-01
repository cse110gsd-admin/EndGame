class WarmupsController < ApplicationController
  # GET /warmups
  # GET /warmups.xml
  def index
    @warmups = Warmup.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @warmups }
    end
  end

  # GET /warmups/1
  # GET /warmups/1.xml
  def show
    @warmup = Warmup.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @warmup }
    end
  end

  # GET /warmups/new
  # GET /warmups/new.xml
  def new
    @warmup = Warmup.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @warmup }
    end
  end

  # GET /warmups/1/edit
  def edit
    @warmup = Warmup.find(params[:id])
  end

  # POST /warmups
  # POST /warmups.xml
  def create
    @warmup = Warmup.new(params[:warmup])

    respond_to do |format|
      if @warmup.save
        format.html { redirect_to(@warmup, :notice => 'Warmup was successfully created.') }
        format.xml  { render :xml => @warmup, :status => :created, :location => @warmup }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @warmup.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /warmups/1
  # PUT /warmups/1.xml
  def update
    @warmup = Warmup.find(params[:id])

    respond_to do |format|
      if @warmup.update_attributes(params[:warmup])
        format.html { redirect_to(@warmup, :notice => 'Warmup was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @warmup.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /warmups/1
  # DELETE /warmups/1.xml
  def destroy
    @warmup = Warmup.find(params[:id])
    @warmup.destroy

    respond_to do |format|
      format.html { redirect_to(warmups_url) }
      format.xml  { head :ok }
    end
  end
end
