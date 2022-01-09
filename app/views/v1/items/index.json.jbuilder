json.array! @items do |item|
  json.code item.code
  json.name item.name
  json.price item.price
end
