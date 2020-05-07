class AddUserToConsignments < ActiveRecord::Migration[6.0]
  def change
    add_column :consignments, :user, :integer
  end
end
