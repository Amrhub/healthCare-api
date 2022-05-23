class Api::V1::LikesController < ApplicationController
  before_action :set_like, only: %i[show update destroy]

  # GET /likes
  def index
    @likes = Like.all

    render json: @likes
  end

  # GET /likes/1
  def show
    render json: @like
  end

  # POST /likes
  def create
    @like = Like.new(like_params)

    if @like.save
      render json: format_like_json(@like), status: :created
    else
      render json: @like.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /likes/1
  def update
    if @like.update(like_params)
      render json: @like
    else
      render json: @like.errors, status: :unprocessable_entity
    end
  end

  # DELETE /likes/1
  def destroy
    @like.destroy
  end

  def posts_user_likes
    @user = User.find(params[:user_id])

    render json: @user.likes.map { |like| format_like_json(like) }
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_like
    @like = Like.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def like_params
    params.permit(:user_id, :post_id)
  end

  def format_like_json(like)
    {
      likeId: like.id,
      postId: like.post_id,
    }
  end
end
