class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :no_log_in, only: [:new, :edit, :show]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    # お気に入り機能のために@favoriteに値を入れる
    @favorite = current_user.favorites.find_by(post_id: @post.id)
  end

  # GET /posts/new
  def new
    if params[:back]
      @post = Post.new(post_params)
    else
      @post = Post.new
    end
  end

  # GET /posts/1/edit
  def edit
  end

  # 機能追加
  def confirm
    @post = Post.new(post_params)
    render :new if @post.invalid?
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    # ログインしているuserのIDを、postのuser_idカラムへ入れる
    @post.user_id = current_user.id

    # 確認ページを経て画像データを保持するために追記
    @post.image.retrieve_from_cache! params[:cache][:image]
    respond_to do |format|
      if @post.save
        ConfirmMailer.confirm_mail(@post).deliver
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
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
      params.require(:post).permit(:content, :id, :image)
    end

    def no_log_in
      if current_user == nil
        redirect_to new_session_path, notice: "ログインして下さい"
      end
    end
end
