class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:home]

  # == GET /home
  def home
    puts "\n******** home ********"
    current_user = nil
    puts "*** current_user.inspect: #{current_user.inspect} ***"
    @users = User.all
    puts "*** current_user.inspect: #{current_user.inspect} ****"
    # puts "*** current_user[:id].inspect: #{current_user[:id].inspect} ****"
  end

  # == GET /feed
  def feed
    puts "\n******** feed ********"
    @user = User.find(current_user.id)
  end

  # == GET /login_form
  # def login_form
  #     puts "\n******** login_form ********"
  #     render :login_form
  # end

  # == POST /login
  # def login
  #     puts "\n******** login ********"
  #     @user = User.where(username: params[:username]).first
  #       if @user
  #           if @user.password == params[:password]
  #               current_user = @user.id
  #               puts "** current_user, #{current_user} **"
  #               @current_user = get_current_user
  #               flash[:notice] = "You've been logged in successfully."
  #               redirect_to '/feed'
  #           else
  #               flash[:notice]= "Please check your username and password and try again."
  #               redirect_to "/login_form"
  #           end
  #       else
  #           flash[:notice] = "Please check your username and password and try again."
  #           redirect_to "/login_form"
  #       end
  # end

  # == GET /logout
  # def logout
  #   puts "\n******* logout *******"
  #   current_user = nil
  # 	flash[:notice] = "You've been logged out successfully."
  # 	redirect_to '/'
  # end

  # == get_current_user
  # def get_current_user
  #     puts "\n******* get_current_user *******"
  #     if current_user
  #         return User.find(current_user)
  #     else
  #         puts "** NO CURRENT USER **"
  #     end
  # end

  # GET /users
  # GET /users.json
  def index
    puts "\n******** index_user ********"
    @users = User.all
    @comment = Comment.new
    # binding.pry
    # begin
    #     puts "@user.fname: #{@user.fname}"
    # rescue => e
    #     puts "***** Error: #{e} *****"
    # end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    puts "*** @user.inspect, #{@user.inspect} ***"
    puts "*** params.inspect, #{params.inspect} ***"
    @user = User.find(params[:id])
    @post = Post.new
    @posts = @user.posts
    @addresses = Address.all
    @address = @user.address
    puts "@user.fname: #{@user.fname}"
    puts "*** @posts.inspect: #{@posts.inspect} ***"
    puts "*** @address.inspect: #{@address.inspect} ***"
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  # def edit
  # end

  # POST /users
  # POST /users.json
  def create
    puts "\n******** create_user ********"
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to '/feed', notice: 'You have successfully created an account.' }
        format.json { render :show, status: :created, location: @user }
        current_user = @user.id
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    puts "\n******** update_user ********"
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    puts "\n******** destroy_user ********"
    @user.destroy
    current_user = nil
    flash[:notice] = 'User was successfully deleted.'
    redirect_to '/'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
        puts "\n******** set_user ********"
        @user = User.find(current_user.id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
        puts "\n******** user_params ********"
        # params.require(:user).permit(:fname, :lname, :email, :username, :password, :password_confirmation, :email_confirmation)
        #   params.fetch(:user, {})
    end
end
