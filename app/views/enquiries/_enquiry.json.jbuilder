json.extract! enquiry, :id, :name, :phone, :email, :postcode, :message, :agent_id, :property_id, :created_at, :updated_at
json.url enquiry_url(enquiry, format: :json)
