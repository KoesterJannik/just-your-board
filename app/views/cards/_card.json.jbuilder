json.extract! card, :id, :name, :description, :column_id, :created_at, :updated_at
json.url card_url(card, format: :json)
