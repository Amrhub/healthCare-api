class ChangeFriendshipReferenceNames < ActiveRecord::Migration[7.0]
  def change
    rename_column :friendships, :user_id, :requester_id
    rename_column :friendships, :users_id, :requestee_id
  end
end
