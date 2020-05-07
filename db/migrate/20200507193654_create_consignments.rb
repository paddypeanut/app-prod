class CreateConsignments < ActiveRecord::Migration[6.0]
  def change
    create_table :consignments do |t|
      t.string :company_code
      t.string :reference
      t.integer :parcels
      t.integer :pallets
      t.integer :bundles

      t.timestamps
    end
  end
end
