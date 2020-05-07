json.extract! consignment, :id, :company_code, :reference, :parcels, :pallets, :bundles, :created_at, :updated_at
json.url consignment_url(consignment, format: :json)
