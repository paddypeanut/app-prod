class AddUserIdToConsignments < ActiveRecord::Migration[6.0]
  def change
  	add_column :consignments, :user_id, :integer
  end
end
