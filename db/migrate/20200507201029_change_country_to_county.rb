class ChangeCountryToCounty < ActiveRecord::Migration[6.0]
  def change
  	rename_column :customers, :country, :county
  end
end
