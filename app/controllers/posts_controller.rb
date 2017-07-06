class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    puts "\n******** index ********"
    @posts = Post.all
    puts "\n******** @post, #{@posts} ********"

  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    puts "\n******** show posts ********"
    puts "\n*** params.inspect: #{params.inspect} ***"
    @user = User.find(params[:user_id])
  end

  # GET /posts/new
  def new
    puts "\n******** new post ********"
    @post = Post.new
    @user = User.find(session[:user_id])
    puts "*** @user.inspect: #{@user.inspect} ***"
  end

  # GET /posts/1/edit
  def edit
    puts "\n******** edit post ********"
    @user = User.find(params[:user_id])
    puts "*** @user.inspect: #{@user.inspect} ***"
  end

  # POST /posts
  # POST /posts.json
  def create
    puts "\n******** create post ********"
    @post = Post.new(post_params)
    puts "\n*** params.inspect: #{params.inspect} ***"

    respond_to do |format|
      if @post.save
        format.html { redirect_to user_path(params[:user_id]), notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { redirect_to new_user_post_path(params[:user_id]), notice: 'Post update failed.'  }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    puts "\n******** update post ********"
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    puts "\n******** delete post ********"
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
        puts "\n******** post_params ********"
        params.require(:post).permit(:user_id, :title, :content)
    end
end
