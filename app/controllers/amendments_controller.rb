class AmendmentsController < ApplicationController
  before_action :set_amendment, only: [:show, :edit, :update, :destroy]

  # GET /amendments
  # GET /amendments.json
  def index
    @amendments = Amendment.all
  end

  # GET /amendments/1
  # GET /amendments/1.json
  def show
  end

  # GET /amendments/new
  def new
    @amendment = Amendment.new
  end

  # GET /amendments/1/edit
  def edit
  end

  # POST /amendments
  # POST /amendments.json
  def create
    @amendment = current_user.amendments.new(amendment_params)
    @amendment.budget = current_budget

    respond_to do |format|
      if @amendment.save
        format.html { redirect_to @amendment, notice: 'Amendment was successfully created.' }
        format.json { render action: 'show', status: :created, location: @amendment }
      else
        format.html { render action: 'new' }
        format.json { render json: @amendment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /amendments/1
  # PATCH/PUT /amendments/1.json
  def update
    respond_to do |format|
      if @amendment.update(amendment_params)
        format.html { redirect_to @amendment, notice: 'Amendment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @amendment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @amendment.destroy
    respond_to do |format|
      format.html { redirect_to amendments_url }
      format.json { head :no_content }
    end
  end

    private

    def set_amendment
      @amendment = Amendment.find(params[:id])
    end

    def amendment_params
      params.require(:amendment).permit(:number, :type, :explanation, :user_id)
    end
end
