class Api::V1::CommentsController < ApplicationController
  before_action :set_comment, only: %i[show update destroy]

  # GET /comments
  def index
    @comments = Comment.all.order(created_at: :desc)
    @comments = @comments.where(post_id: params[:post_id]) if params[:post_id]

    render json: @comments.map { |comment| format_comment_json(comment) }
  end

  # GET /comments/1
  def show
    render json: @comment
  end

  # POST /comments
  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      render json: format_comment_json(@comment), status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /comments/1
  def update
    if @comment.update(comment_params)
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /comments/1
  def destroy
    @comment.destroy
  end

  def format_comment_json(comment)
    {
      id: comment.id,
      content: comment.content,
      user: {
        name: "#{comment.user.first_name} #{comment.user.last_name}",
        profilePic: comment.user.profile_pic.attached? ? url_for(comment.user.profile_pic) : nil
      }
    }
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = Comment.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def comment_params
    params.permit(:user_id, :post_id, :content)
  end
end
