class ChangeUserToUserId < ActiveRecord::Migration[6.0]
  def change
  	rename_column :consignments, :user, :user_id
  
  end
end
