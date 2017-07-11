class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    puts "\n******** post_index ********"
    @posts = Post.all
    puts "******** @post, #{@posts} ********"

  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    puts "\n******** show_posts ********"
    puts "*** params.inspect: #{params.inspect} ***"
    @user = User.find(current_user.id)
    @comment = Comment.new
    @comments = @user.comments
  end

  # GET /posts/new
  def new
    puts "\n******** new_post ********"
    @post = Post.new
    @user = User.find(current_user.id)
    puts "*** @user.inspect: #{@user.inspect} ***"
  end

  # GET /posts/1/edit
  def edit
    puts "\n******** edit_post ********"
    @user = User.find(params[:user_id])
    puts "*** @user.inspect: #{@user.inspect} ***"
  end

  # POST /posts
  # POST /posts.json
  def create
    puts "\n******** create_post ********"
    @post = Post.new(post_params)
    puts "*** params.inspect: #{params.inspect} ***"

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
    puts "\n******** update_post ********"
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
    puts "\n******** delete_post ********"
    @post.destroy
    flash[:notice] = 'Post was successfully deleted.'
    redirect_to '/feed'
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
