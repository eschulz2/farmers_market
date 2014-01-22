class FarmersController < ApplicationController
  # GET /farmers
  # GET /farmers.json
  def index
    @farmers = Farmer.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @farmers }
    end
  end

  # GET /farmers/1
  # GET /farmers/1.json
  # GET /farmers/1
  def show
    @farmer = Farmer.find(params[:id])
    @is_admin = current_user && current_user.id == @farmer.id
  end

  # GET /farmers/new
  def new
    if current_user
      redirect_to root_path, :notice => "You are already registered" 
    end
    @farmer = Farmer.new
  end

  # GET /farmers/1/edit
  def edit
    @farmer = Farmer.find(params[:id])
    if current_user.id != @farmer.id
      redirect_to @farmer
    end
  end

  # POST /farmers
  # POST /farmers.json
  
  # POST /farmers
  def create    
    @farmer = Farmer.new(params[:farmer])

    if @farmer.save
      session[:farmer_id] = @farmer.id
      redirect_to @farmer, notice: 'Farmer was successfully created.'      
    else
      render action: "new"
    end
  end

  # PUT /farmers/1
  # PUT /farmers/1.json
  def update
    @farmer = Farmer.find(params[:id])

    respond_to do |format|
      if @farmer.update_attributes(params[:farmer])
        format.html { redirect_to @farmer, notice: 'Farmer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @farmer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /farmers/1
  # DELETE /farmers/1.json
  def destroy
    @farmer = Farmer.find(params[:id])
    @farmer.destroy

    respond_to do |format|
      format.html { redirect_to farmers_url }
      format.json { head :no_content }
    end
  end
end
