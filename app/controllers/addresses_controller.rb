class AddressesController < ApplicationController
  before_action :set_address, only: [:show, :edit, :update, :destroy]

  # GET /addresses
  # GET /addresses.json
  def index
    puts "\n******** index_address ********"
    @addresses = Address.all
  end

  # GET /addresses/1
  # GET /addresses/1.json
  def show
  end

  # GET /addresses/new
  def new
    puts "\n******** new_address ********"
    @address = Address.new
    @user = User.find(current_user.id)
    puts "*** @user.inspect: #{@user.inspect} ***"
    puts "*** @address.inspect: #{@address.inspect} ***"

  end

  # GET /addresses/1/edit
  def edit
    puts "\n******** edit_address ********"
    @user = User.find(params[:user_id])
    puts "*** @user.inspect: #{@user.inspect} ***"
  end

  # POST /addresses
  # POST /addresses.json
  def create
    puts "\n******** create_address ********"
    @address = Address.new(address_params)
    puts "*** params.inspect: #{params.inspect} ***"

    respond_to do |format|
      if @address.save
          format.html { redirect_to user_path(params[:user_id]), notice: 'Address was successfully added.' }
        format.json { render :show, status: :created, location: @address }
      else
        format.html { render :new }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /addresses/1
  # PATCH/PUT /addresses/1.json
  def update
    puts "\n******** update_address ********"
    respond_to do |format|
      if @address.update(address_params)
        format.html { redirect_to user_path(params[:user_id]), notice: 'Address was successfully updated.' }
        format.json { render :show, status: :ok, location: @address }
      else
        format.html { render :edit }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /addresses/1
  # DELETE /addresses/1.json
  def destroy
    puts "\n******** delete_address ********"
    @address.destroy
    respond_to do |format|
      format.html { redirect_to addresses_url, notice: 'Address was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_address
      @address = Address.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def address_params
        puts "\n******** address_params ********"
        params.require(:address).permit(:street, :city, :state, :zip, :user_id)
    end
end
