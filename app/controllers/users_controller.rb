class UsersController < ApplicationController
  before_filter :authenticate, :only => [:edit, :update, :destroy]
  before_filter :correct_user, :only => [:edit, :update, :destroy]
  # "Edit" and "Account Management" are the same.


  # GET /users
  # GET /users.xml
  def index
    respond_to do |format|
      format.html { redirect_to root_path }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    respond_to do |format|
      format.html { redirect_to root_path }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @title = "Sign up"
    @user = User.new

  #  respond_to do |format|
   #   format.html # new.html.erb
   #   format.xml  { render :xml => @user }
   # end
  end

  # GET /users/1/edit
  def edit
    @title = "Edit user"
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])
    respond_to do |format|
      if @user.save
        sign_in @user
        format.html { redirect_to(root_path, :notice => 'Registration successful!') }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => 'Account info updated.') }
        format.xml  { head :ok }
      else
        @title = "Edit user"
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(root_path, :notice => 'Account deleted.') }
      format.xml  { head :ok }
    end
  end


  private

    def authenticate
      deny_access unless signed_in?
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end


end
