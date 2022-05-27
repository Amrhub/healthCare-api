class Api::V1::PostsController < ApplicationController
  before_action :set_post, only: %i[show update destroy]

  # GET /posts
  def index
    @posts = Post.all

    render json: @posts.order(created_at: :desc).map { |post| format_post_json(post) }
  end

  # GET /posts/1
  def show
    render json: @post
  end

  # POST /posts
  def create
    @post = Post.new(post_params)

    if @post.save
      render json: format_post_json(@post), status: :created
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params.merge(age: calculate_age(params[:birth_date]) || @post.age))
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
  end

  def user_posts
    posts = Post.where(user_id: params[:user_id]).order(created_at: :desc).limit(3)

    render json: posts.map { |post| format_post_json(post) }
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  def calculate_age(birth_date)
    (Date.today - birth_date.to_date).to_i / 365
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.permit(:content, :category, :user_id, :comments_counter, :likes_counter)
  end

  def format_post_json(post)
    {
      **post.attributes.except("created_at", "updated_at", "user_id", "likes_counter", "comments_counter"),
      likesCounter: post.likes_counter,
      commentsCounter: post.comments_counter,
      user: {
        id: post.user.id,
        name: "#{post.user.first_name} #{post.user.last_name}",
        profilePic: post.user.profile_pic.attached? ? url_for(post.user.profile_pic) : nil
      }
    }
  end
end
