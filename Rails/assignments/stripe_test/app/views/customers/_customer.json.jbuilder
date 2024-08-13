json.extract! customer, :id, :email, :stripe_customer_id, :created_at, :updated_at
json.url customer_url(customer, format: :json)
