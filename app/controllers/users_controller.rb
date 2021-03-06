class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]


  # == GET /home
  def home
    puts "\n******** home ********"
    @users = User.all
  end

  # == GET /feed
  def feed
    puts "\n******** feed ********"
    @user = User.find(session[:user_id])

  end

  # == GET /login_form
  def login_form
      puts "\n******** login_form ********"
      render :login_form
  end

  # == POST /login
  def login
      puts "\n******** login ********"
      @user = User.where(username: params[:username]).first
        if @user
            if @user.password == params[:password]
                session[:user_id] = @user.id
                puts "** session[:user_id], #{session[:user_id]} **"
                @current_user = get_current_user
                flash[:notice] = "You've been logged in successfully."
                redirect_to '/feed'
            else
                flash[:notice]= "Please check your username and password and try again."
                redirect_to "/login_form"
            end
        else
            flash[:notice] = "Please check your username and password and try again."
            redirect_to "/login_form"
        end
  end

  # == GET /logout
  def logout
    puts "\n******* logout *******"
    session[:user_id] = nil
  	flash[:notice] = "You've been logged out successfully."
  	redirect_to '/'
  end

  # == get_current_user
  def get_current_user
      puts "\n******* get_current_user *******"
      if session[:user_id]
          return User.find(session[:user_id])
      else
          puts "** NO CURRENT USER **"
      end
  end

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
    @post = Post.new
    @posts = @user.posts
    puts "@user.fname: #{@user.fname}"
    puts "*** @posts.inspect: #{@posts.inspect} ***"
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    puts "\n******** create_user ********"
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
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
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
        puts "\n******** set_user ********"
        @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
        puts "\n******** user_params ********"
        params.require(:user).permit(:fname, :lname, :email, :username, :password)
        #   params.fetch(:user, {})
    end
end
