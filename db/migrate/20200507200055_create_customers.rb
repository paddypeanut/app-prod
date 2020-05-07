class CreateCustomers < ActiveRecord::Migration[6.0]
  def change
    create_table :customers do |t|
      t.string :customer_code
      t.string :company_name
      t.string :address1
      t.string :address2
      t.string :address3
      t.string :country
      t.string :eircode
      t.integer :user_id
      t.integer :consignment_id
      t.integer :consignments_count

      t.timestamps
    end
  end
end
