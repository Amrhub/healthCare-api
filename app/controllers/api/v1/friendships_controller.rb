class Api::V1::FriendshipsController < ApplicationController
  before_action :set_friendship, only: %i[show update destroy]

  # GET /friendships
  def index
    @friendships = Friendship.all

    render json: @friendships
  end

  # GET /friendships/1
  def show
    render json: @friendship
  end

  # POST /friendships
  def create
    @friendship = Friendship.new(friendship_params)
    @friendship.status = 'pending' unless @friendship.status
    user = User.find(@friendship.requestee_id)
    user_info = {
      id: user.id,
      name: "#{user.first_name} #{user.last_name}",
      profilePic: user.profile_pic.attached? ? url_for(user.profile_pic) : nil
    }

    if @friendship.save
      render json: { **format_friendsip_json(@friendship), userInfo: user_info }, status: :created
    else
      render json: @friendship.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /friendships/1
  def update
    if @friendship.update(friendship_params)
      render json: format_friendsip_json(@friendship)
    else
      render json: @friendship.errors, status: :unprocessable_entity
    end
  end

  # DELETE /friendships/1
  def destroy
    @friendship.destroy
  end

  def show_friendships
    @friendships = Friendship.where(requester_id: params[:user_id]).or(Friendship.where(requestee_id: params[:user_id]))

    friendships_list = {
      pending: [],
      accepted: [],
      blocked: [],
    }

    @friendships.each do |friendship|
      case friendship.status.downcase
      when 'pending'
        data = {
          **format_friendsip_json(friendship),
          userInfo: user_info_from_friendship(params[:user_id], friendship.requester_id, friendship.requestee_id)
        }
        friendships_list[:pending].push data
      when 'accepted'
        data = {
          **format_friendsip_json(friendship),
          userInfo: user_info_from_friendship(params[:user_id], friendship.requester_id, friendship.requestee_id)
        }
        friendships_list[:accepted].push data
      when 'blocked'
        data = {
          **format_friendsip_json(friendship),
          userInfo: user_info_from_friendship(params[:user_id], friendship.requester_id, friendship.requestee_id)
        }
        friendships_list[:blocked].push data
      end
    end

    render json: friendships_list
  end

  def user_info_from_friendship(user_id, requester_id, requestee_id)
    user = user_id.to_i == requester_id ? User.find(requestee_id) : User.find(requester_id)

    {
      id: user.id,
      name: "#{user.first_name} #{user.last_name}",
      profilePic: user.profile_pic.attached? ? url_for(user.profile_pic) : nil
    }
  end

  def format_friendsip_json(friendship)
    {
      id: friendship.id,
      requester_id: friendship.requester_id,
      requestee_id: friendship.requestee_id,
      status: friendship.status
    }
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_friendship
    @friendship = Friendship.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def friendship_params
    params.permit(:requester_id, :requestee_id, :status)
  end
end
